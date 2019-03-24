<?php

namespace app\admin\controller;
use app\common\service\index\IndexDataService;
use think\App;
use think\Controller;


/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-14
 * Time: 下午2:53
 * 首页
 */
class Index extends Controller
{
    private $dataService;

    public function __construct()
    {
        $this->dataService = new IndexDataService();
    }

    /**
     * 首页
     */
    public function index()
    {
        return view();
    }

    /**
     * 欢迎页面
     */
    public function welcome()
    {
        return view('' , $this->dataService->getCountInfo());
    }
}