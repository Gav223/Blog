<?php

namespace app\admin\controller;
use app\common\lib\Condition;
use app\common\service\common\CommonDataService;
use app\common\service\common\CommonDbService;
use think\Controller;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-15
 * Time: 上午10:49
 * 文章分类模块
 */

class ArticleCate extends Controller
{
    private $commonDbService;
    private $commonDataService;
    private $validate;

    public function __construct()
    {
        $this->commonDbService = new CommonDbService(new \app\common\model\ArticleCate());
        $this->commonDataService = new CommonDataService(new \app\common\model\ArticleCate());
        $this->validate = new \app\common\validate\ArticleCate();
    }

    /**
     * 分类列表
     */
    public function cateList()
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
        return $this->commonDataService->add(request()->param() , NULL , $this->validate);
    }

    /**
     * 详情
     */
    public function details()
    {
        $articleCate = $this->commonDbService->findById(request()->only('id'));
        return view('details' , ['articleCate' => $articleCate]);
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