<?php

namespace app\admin\controller;
use app\common\lib\Condition;
use app\common\service\admin\AdminDataService;
use app\common\service\common\CommonDataService;
use app\common\service\common\CommonDbService;
use think\Controller;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-14
 * Time: 下午3:06
 * 管理员模块
 */

class Admin extends Controller
{
    private $dataService;
    private $commonDataService;
    private $commonDbService;
    private $validate;

    public function __construct()
    {
        $this->dataService = new AdminDataService();
        $this->commonDataService = new CommonDataService(new \app\common\model\Admin());
        $this->commonDbService = new CommonDbService(new \app\common\model\Admin());
        $this->validate = new \app\common\validate\Admin();
    }

    /**
     * 登录
     * TODO 1.检查账号密码
     * TODO 2.种cookie , 打日志
     */
    public function login()
    {
        if(request()->method() === 'GET') return view();
        $checkResult = $this->dataService->beforeLogin(request()->param()); //TODO 1.检查账号密码
        if($checkResult === false) return $this->error('账号或密码错误');
        $this->dataService->afterLogin($checkResult);     //TODO 2.种cookie , 打日志
        return $this->redirect('admin/Index/index');
    }

    /**
     * 登出
     * TODO 1.清cookie
     */
    public function logout()
    {
        $this->dataService->unsetAdminCookie();
        return $this->redirect('admin/Admin/login');
    }

    /**
     * 管理员列表
     */
    public function adminList()
    {
        return view('list' , $this->dataService->getAdminList(request()->param()));
    }

    /**
     * 添加
     */
    public function add()
    {
        if(request()->method() === 'GET') return view();
        $params = $this->dataService->setPwAndSalt(request()->post(false));
        return $this->dataService->add($params , $this->validate);
    }

    /**
     * 详情
     */
    public function details()
    {
        return view('details' , ['details' => $this->dataService->getDetailsInfo(request()->only('id'))]);
    }

    /**
     * 更新
     */
    public function update()
    {
        $params = request()->post(false);
        if(isset($params['pw']) && !empty($params['pw'])) $params = $this->dataService->setPwAndSalt($params);
        return $this->dataService->update($params , $this->validate);
    }

    /**
     * 删除
     */
    public function delete()
    {
        return $this->dataService->delete(request()->only('id') , $this->validate);
    }

    /**
     * 批量删除
     */
    public function deleteAll()
    {
        return $this->dataService->deleteAll(request()->only('idList'));
    }

}

