<?php

namespace app\admin\controller;
use app\common\lib\Condition;
use app\common\service\common\CommonDataService;
use app\common\service\common\CommonDbService;
use app\common\service\role\RoleDataService;
use think\Controller;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-21
 * Time: 下午3:53
 * 权限-角色模块
 */

class Role extends Controller
{
    private $commonDbService;
    private $commonDataService;
    private $dataService;
    private $validate;

    public function __construct()
    {
        $this->commonDbService = new CommonDbService(new \app\common\model\Role());
        $this->commonDataService = new CommonDataService(new \app\common\model\Role());
        $this->dataService = new RoleDataService();
        $this->validate = new \app\common\validate\Role();
    }

    /**
     * 角色列表
     */
    public function roleList()
    {
        $condition = new Condition(request()->get());
        $queryData = $this->commonDbService->findAllPaged($condition);
        return view('list' , $this->commonDataService->setCondition($queryData,$condition));
    }

    /**
     * 添加
     */
    public function add()
    {
        if(request()->method() === 'GET') return view();
        return $this->dataService->add(request()->param() , $this->validate);
    }

    /**
     * 详情
     */
    public function details()
    {
        return view('details' , ['details' => $this->dataService->setDetailsInfo(request()->only('id'))]);
    }

    /**
     * 更新
     */
    public function update()
    {
        return $this->dataService->update(request()->param() , $this->validate);
    }

    /**
     * 删除
     */
    public function delete()
    {
        return $this->dataService->delete(request()->param() , $this->validate);
    }

    /**
     * 批量删除
     */
    public function deleteAll()
    {
        return $this->dataService->deleteAll(request()->only('idList'));
    }
}