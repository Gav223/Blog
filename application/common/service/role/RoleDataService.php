<?php

namespace app\common\service\role;
use app\common\lib\Code;
use app\common\lib\Message;
use app\common\model\Role;
use app\common\model\RoleNode;
use app\common\service\common\CommonDbService;
use think\Exception;
use think\facade\Log;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-21
 * Time: 下午3:55
 */

class RoleDataService
{
    private $model;
    private $roleNodeModel;
    private $commonDbService;

    public function __construct()
    {
        $this->model = new Role();
        $this->roleNodeModel = new RoleNode();
        $this->commonDbService = new CommonDbService(new Role());
    }

    public function getRoleNodeData(array $nodeIdList ,$roleId)
    {
        $roleNodeList = [];
        foreach($nodeIdList as $key => $value) {
            $roleNodeList[$key]['role_id'] = $roleId;
            $roleNodeList[$key]['node_id'] = $value;
            $roleNodeList[$key]['create_time'] = time();
        }
        return $roleNodeList;
    }

    /**
     * 添加角色
     * TODO 1.添加角色
     * TODO 2.添加角色节点
     */
    public function add($params ,\app\common\validate\Role $validate)
    {
        if(!$validate->scene('add')->check($params))
        {
            return json(['code' => Code::$VALIDATE_ERROR , 'msg' => $validate->getError()]);
        }
        $nodeIdList = $params['node_id'];
        unset($params['node_id']);
        try{
            $addRoleResult = Role::create($params);   //TODO 1.添加角色
            $roleNodeData = $this->getRoleNodeData($nodeIdList , $addRoleResult->id);     //TODO 拼装角色节点数组
            $this->roleNodeModel->insertAll($roleNodeData);     //TODO 2.添加角色节点
            return json(['code' => Code::$SUCCESS , 'msg' => Message::$SUCCESS]);
        }catch (Exception $exception){
            return json(['code' => Code::$ERROR , 'msg' => $exception->getMessage()]);
        }
    }

    /**
     * TODO 1.查询角色基础信息(name,description)
     * TODO 2.查询角色所拥有的节点Id列表
     */
    public function setDetailsInfo($params)
    {
        $id = $params['id'];
        $roleDetails = $this->model->findById($id); //TODO 1.基础信息
        $roleDetails['nodeIdList'] = $this->getIdListString($this->roleNodeModel->findByRoleId($id , 'node_id')); //TODO 2.查询角色所拥有的节点Id列表
        return $roleDetails;
    }

    /**
     * 数据库查询出来的二维数组转换成idString(格式如:"1,2,3")
     */
    public function getIdListString($nodeIdList)
    {
        $idListString = '';
        foreach ($nodeIdList as $key => $value) {
            $idListString.= $value['node_id'].",";
        }
        $idListString = rtrim($idListString , ',');
        return $idListString;
    }

    public function update($params , \app\common\validate\Role $validate)
    {
        if(!$validate->scene('update')->check($params))
        {
            return json(['code' => Code::$VALIDATE_ERROR , 'msg' => $validate->getError()]);
        }
        $nodeIdList = $params['node_id'];
        unset($params['node_id']);
        try{
            Role::update($params , ['id' => $params['id']]);   //TODO 1.更新角色基础信息
            $this->roleNodeModel->deleteByRoleId($params['id']);   //TODO 2.删除角色节点
            $roleNodeData = $this->getRoleNodeData($nodeIdList , $params['id']);     //TODO 拼装角色节点数组
            $this->roleNodeModel->insertAll($roleNodeData);     //TODO 3.添加角色节点
            return json(['code' => Code::$SUCCESS , 'msg' => Message::$SUCCESS]);
        }catch (Exception $exception){
            return json(['code' => Code::$ERROR , 'msg' => $exception->getMessage()]);
        }
    }

    public static function findRoleList()
    {
        $dbService = new CommonDbService(new Role());
        return $dbService->findAll();
    }

    public function delete($param ,\app\common\validate\Role $validate)
    {
        if(!$validate->scene('delete')->check($param)) {
            return json(['code' => Code::$VALIDATE_ERROR , 'msg' => $validate->getError()]);
        }
        try{
            $this->commonDbService->delete($param['id']);   //TODO 删除角色信息
            $this->roleNodeModel->deleteByRoleId($param['id']);   //TODO 删除角色节点信息
            return json(['code' => Code::$SUCCESS , 'msg' => Message::$SUCCESS]);
        }catch(Exception $exception){
            Log::write("delete role error | message:{$exception->getMessage()}");
            return json(['code' => Code::$ERROR , 'msg' => Message::$FAILED]);
        }
    }

    public function deleteAll($param)
    {
        try{
            $this->commonDbService->deleteByIdIn($param['idList']);   //TODO 删除角色信息
            $this->roleNodeModel->deleteByRoleIdIn($param['idList']);   //TODO 删除角色节点信息
            return json(['code' => Code::$SUCCESS , 'msg' => Message::$SUCCESS]);
        }catch(Exception $exception){
            Log::write("deleteAll role error | message:{$exception->getMessage()}");
            return json(['code' => Code::$ERROR , 'msg' => Message::$FAILED]);
        }
    }

}