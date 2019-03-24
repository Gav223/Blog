<?php

namespace app\index\controller;
use app\common\lib\DefaultSetting;
use app\common\model\ArticleCate;
use app\common\service\articleCate\ArticleCateDbService;
use app\common\service\index\IndexDataService;
use think\Controller;

class Index extends Controller
{
    private $dataService;
    private $cateDbService;

    public function __construct(IndexDataService $dataService ,ArticleCate $cateDbService)
    {
        $this->dataService = $dataService;
        $this->cateDbService = $cateDbService;
    }

    /**
     * 首页
     * @return mixed|\think\response\View
     */
    public function index()
    {
        return view('' , $this->dataService->setIndexInfo());
    }

    /**
     * 关于我
     * @return mixed|\think\response\View
     */
    public function about()
    {
        $cateList = $this->cateDbService->findAll(DefaultSetting::$SHOW_NUM);   //TODO 分类列表
        return view('' , ['cateList' => $cateList]);
    }
}