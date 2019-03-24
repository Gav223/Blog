<?php

namespace app\admin\controller;
use app\common\lib\Condition;
use app\common\service\common\CommonDataService;
use app\common\service\common\CommonDbService;
use app\common\service\node\NodeDataService;
use think\Controller;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-21
 * Time: 下午2:33
 * 权限-节点模块
 */

class Node extends Controller
{
    private $commonDbService;
    private $commonDataService;
    private $dataService;
    private $validate;

    public function __construct()
    {
        $this->commonDbService = new CommonDbService(new \app\common\model\Node());
        $this->commonDataService = new CommonDataService(new \app\common\model\Node());
        $this->dataService = new NodeDataService();
        $this->validate = new \app\common\validate\Node();
    }

    /**
     * 节点列表
     */
    public function nodeList()
    {
        $condition = new Condition(request()->get());
        $queryData = $this->commonDbService->findAllPaged($condition);
        $queryData['list'] = $this->dataService->setParentName($queryData['list']); //TODO 查询父节点名称
        return view('list' , $this->commonDataService->setCondition($queryData,$condition));
    }

    /**
     * 添加
     */
    public function add()
    {
        if(request()->method() === 'GET') return view();
        return $this->commonDataService->add(request()->param() , NULL , $this->validate);
    }

    /**
     * 详情
     */
    public function details()
    {
        $details = $this->commonDbService->findById(request()->only('id'));
        return view('details' , ['details' => $details]);
    }

    /**
     * 更新
     */
    public function update()
    {
        return $this->commonDataService->update(request()->param() , $this->validate);
    }

    /**
     * 删除
     */
    public function delete()
    {
        return $this->commonDataService->delete(request()->param() , $this->validate);
    }

    /**
     * 批量删除
     */
    public function deleteAll()
    {
        return $this->commonDataService->deleteByIdIn(request()->only('idList'));
    }
}