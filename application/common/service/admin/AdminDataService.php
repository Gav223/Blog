<?php

namespace app\common\service\admin;
use app\common\lib\Code;
use app\common\lib\Condition;
use app\common\lib\Message;
use app\common\model\Admin;
use app\common\model\AdminRole;
use app\common\model\Node;
use app\common\model\Role;
use app\common\model\RoleNode;
use app\common\service\common\CommonDataService;
use app\common\service\common\CommonDbService;
use app\common\util\PwUtil;
use think\Exception;
use think\facade\Log;
use traits\controller\Jump;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-14
 * Time: 下午4:11
 */

class AdminDataService
{
    private $adminRoleModel;
    private $roleNodeModel;
    private $nodeModel;
    private $commonDbService;
    private $commonDataService;
    private $model;
    private $logModel;
    private $roleModel;
    use Jump;

    public function __construct()
    {
        $this->adminRoleModel = new AdminRole();
        $this->roleNodeModel = new RoleNode();
        $this->nodeModel = new Node();
        $this->commonDbService = new CommonDbService(new Admin());
        $this->commonDataService = new CommonDataService(new Admin());
        $this->model = new Admin();
        $this->logModel = new \app\common\model\Log();
        $this->roleModel = new Role();
    }

    /**
     * 检查账户信息
     */
    public function checkAccountInfo($postData , $accountData)
    {
        if($postData === NULL || $accountData === NULL){
            return false;
        }
        $salt = $accountData['salt'];
        Log::write('pw:'.$postData['pw'].'|salt:'.$accountData['salt']);
        Log::write("login_pw:".PwUtil::encode($postData['pw'],$salt)."|db_pw:".$accountData['pw']);
        if($postData['name'] === $accountData['name']){
            if(PwUtil::encode($postData['pw'],$salt) === $accountData['pw']){
                return true;
            }
        }
        return false;
    }

    /**
     * 加密密码 , 设置salt
     */
    public function setPwAndSalt($params)
    {
        $params['salt'] = time();
        $pw = $params['pw'];
        $params['pw'] = PwUtil::encode($pw,$params['salt']);
        Log::write('pw:'.$pw.'salt:'.$params['salt'].'encode_pw:'.$params['pw']);
        return $params;
    }

    /**
     * 通过管理员角色列表,查询角色节点列表
     */
    public function findRoleNodeList($adminRoleList)
    {
        $afterNodeList = [];
        $nodeList = [];
        foreach ($adminRoleList as $key => $value) {
            $nodeList[$key] = $this->roleNodeModel->findByRoleId($value['role_id']); //TODO 2.循环查询角色对应节点列表
            foreach ($nodeList[$key] as $k => $v) {
                $nodeList[$key][$k]['name'] = '';
                $nodeData = $this->nodeModel->findById($v['node_id'] , 'name,pid');
                if($nodeData !== false) {
                    $nodeList[$key][$k]['name'] = $nodeData['name'];
                    $nodeList[$key][$k]['pid'] = $nodeData['pid'];
                }
                $afterNodeList[] = $nodeList[$key][$k];
            }
        }
        return $afterNodeList;
    }

    /**
     * 管理员节点列表 to 管路员权限数组
     */
    public function adminNodeList2authData($adminNodeList)
    {
        foreach ($adminNodeList as $key => $value) {
            if(isset($value['pid']) && $value['pid'] == 0) {
                $adminNodeList[strtolower($value['name'])] = [];
                foreach ($adminNodeList as $k => $v) {
                    if(isset($v['pid']) && isset($value['node_id']) && $v['pid'] == $value['node_id']) {
                        $adminNodeList[strtolower($value['name'])][strtolower($v['name'])] = '';
                    }
                }
            }
        }
        return $adminNodeList;
    }


    public function setAdminCookie($accountData)
    {
        cookie('adminName',$accountData['name']);   //管理员名
        cookie('adminId' , $accountData['id']);     //管理员Id
        $adminRoleList = $this->adminRoleModel->findByAdminId($accountData['id']);  //TODO 1.查询管理员对应角色列表
        $adminNodeList = $this->findRoleNodeList($adminRoleList);   //TODO 2.循环查询角色对应节点列表
        $authData = $this->adminNodeList2authData($adminNodeList);  //TODO 3.管理员节点列表 to 权限数组
        session('authData:'.$accountData['name'] , $authData);     //TODO 因为cookie默认将对象转化成了json字符串,为了避免使用序列化函数
    }

    public function unsetAdminCookie()
    {
        cookie('adminName' , null);
        cookie('adminId' , null);
        cookie('authData' , null);
    }

    /**
     * 根据idList拼装管理员角色信息
     */
    public function getAdminRoleList(array $roleIdList ,$adminId)
    {
        $adminRoleList = [];
        foreach ($roleIdList as $key => $value) {
            $adminRoleList[$key]['admin_id'] = $adminId;
            $adminRoleList[$key]['role_id'] = $value;
            $adminRoleList[$key]['create_time'] = time();
        }
        return $adminRoleList;
    }

    /**
     * TODO 1.添加管理员基础信息
     * TODO 2.添加管理员角色记录
     */
    public function add($param ,\app\common\validate\Admin $validate)
    {
        if(!$validate->scene('add')->check($param)) {
            return json(['code' => Code::$VALIDATE_ERROR , 'msg' => $validate->getError()]);
        }
        $roleIdList = isset($param['role_id'])?$param['role_id']:[];
        unset($param['role_id']);
        try{
            $addAdminResult = Admin::create($param);    //TODO 添加管理员基础信息
            $adminRoleList = $this->getAdminRoleList($roleIdList , $addAdminResult->id); //TODO 拼装管理员角色记录数组
            $this->adminRoleModel->insertAll($adminRoleList);     //TODO 添加管理员角色记录
            return json(['code' => Code::$SUCCESS , 'msg' => Message::$SUCCESS]);
        }catch (Exception $exception) {
            return json(['code' => Code::$ERROR , 'msg' => $exception->getMessage()]);
        }
    }

    /**
     * 获取管理员详细信息（基础信息+角色信息）
     */
    public function getDetailsInfo($param)
    {
        $adminInfo = $this->model->findById($param['id']);  //TODO 管理员基础信息
        $adminInfo['roleIdList'] = $this->getIdListString($this->adminRoleModel->findByAdminId($param['id'],'role_id'));//TODO 管理员角色信息
        return $adminInfo;
    }

    /**
     * 讲查询出来的adminRoleList转换成idList
     */
    public function getIdListString($adminRoleList)
    {
        $idListString = '';
        foreach ($adminRoleList as $key => $value) {
            $idListString.= $value['role_id'].",";
        }
        $idListString = rtrim($idListString , ',');
        return $idListString;
    }

    /**
     * TODO 1.更新管理员基础信息
     * TODO 2.添加管理员角色记录
     */
    public function update($param ,\app\common\validate\Admin $validate)
    {
        if(!$validate->scene('update')->check($param)) {
            return json(['code' => Code::$VALIDATE_ERROR , 'msg' => $validate->getError()]);
        }
        $roleIdList = isset($param['role_id'])?$param['role_id']:[];
        unset($param['role_id']);
        try{
            Admin::update($param , ['id' => $param['id']]);    //TODO 更新管理员基础信息
            $this->adminRoleModel->deleteByAdminId($param['id']);    //TODO 删除管理员角色记录
            $adminRoleList = $this->getAdminRoleList($roleIdList , $param['id']); //TODO 拼装管理员角色记录数组
            $this->adminRoleModel->insertAll($adminRoleList);     //TODO 添加管理员角色记录
            return json(['code' => Code::$SUCCESS , 'msg' => Message::$SUCCESS]);
        }catch (Exception $exception) {
            Log::write("update admin error | message:{$exception->getMessage()}");
            return json(['code' => Code::$ERROR , 'msg' => Message::$FAILED]);
        }
    }

    /**
     * 删除管理员
     * TODO 1.删除管理员表信息
     * TODO 2.删除管理员角色表信息
     */
    public function delete($param,\app\common\validate\Admin $validate)
    {
        if(!$validate->scene('delete')->check($param)) {
            return json(['code' => Code::$VALIDATE_ERROR , 'msg' => $validate->getError()]);
        }
        try{
            $this->commonDbService->delete($param['id']);   //TODO 删除管理员信息
            $this->adminRoleModel->deleteByAdminId($param['id']);   //TODO 删除管理员角色信息
            return json(['code' => Code::$SUCCESS , 'msg' => Message::$SUCCESS]);
        }catch(Exception $exception){
            Log::write("delete admin error | message:{$exception->getMessage()}");
            return json(['code' => Code::$ERROR , 'msg' => Message::$FAILED]);
        }
    }

    /**
     * 批量删除
     * TODO 1.删除管理员信息
     * TODO 2.删除管理员角色信息
     */
    public function deleteAll($param)
    {
        try{
            $this->commonDbService->deleteByIdIn($param['idList']);   //TODO 删除管理员信息
            $this->adminRoleModel->deleteByAdminIdIn($param['idList']);   //TODO 删除管理员角色信息
            return json(['code' => Code::$SUCCESS , 'msg' => Message::$SUCCESS]);
        }catch(Exception $exception){
            Log::write("delete admin error | message:{$exception->getMessage()}");
            return json(['code' => Code::$ERROR , 'msg' => Message::$FAILED]);
        }
    }

    /**
     * 登陆之前
     * TODO 1.检查账号密码
     */
    public function beforeLogin($param)
    {
        $accountData = $this->model->findByName($param['name']);
        $checkResult = $this->checkAccountInfo($param , $accountData);  //TODO 1.检查账号密码
        if($checkResult === true) return $accountData;
        return $checkResult;
    }

    /**
     * 登录之后
     * TODO 1.种cookie
     * TODO 2.打数据库日志
     */
    public function afterLogin($accountData)
    {
        try{
            $this->setAdminCookie($accountData);   //TODO 1.种cookie
            $this->logModel->add(['ip' => request()->ip() , 'name' => request()->only('name')['name']]);    //TODO 2.打数据库日志
        }catch(Exception $exception){
            Log::write("afterLogin error | message:{$exception->getMessage()}");
            return $this->error('程序出错');
        }
    }

    public function roleList2string($roleList , $field)
    {

        $nameString = '';
        foreach ($roleList as $key => $value) {
            $nameString.= $value[$field].",";
        }
        return trim($nameString , ',');
    }


    /**
     * 往AdminList数据中,插入角色信息
     */
    public function setRoleName($adminList)
    {
        foreach ($adminList as $key => $value) {
            $adminRoleList = $this->adminRoleModel->findByAdminId($value['id']);
            $roleIdString = $this->roleList2string($adminRoleList , 'role_id');
            $adminList[$key]['roleName'] = $this->roleList2string($this->roleModel->findByIdIn($roleIdString) , 'name');
        }
        return $adminList;
    }

    /**
     * 获取管理员列表数据
     */
    public function getAdminList($param)
    {
        $condition = new Condition($param);
        $queryData = $this->commonDbService->findAllPaged($condition);
        $queryData['list'] = $this->setRoleName($queryData['list']);    //TODO 查询角色信息
        return $this->commonDataService->setCondition($queryData,$condition);
    }
}