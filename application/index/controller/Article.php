<?php

namespace app\index\controller;
use app\common\lib\Condition;
use app\common\lib\DefaultSetting;
use app\common\service\article\ArticleDataService;
use app\common\service\article\ArticleDbService;
use app\common\service\articleCate\ArticleCateDataService;
use app\common\service\articleCate\ArticleCateDbService;
use app\common\service\comment\CommentDbService;
use app\common\service\common\CommonDbService;
use think\Controller;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-15
 * Time: 上午9:40
 */

class Article extends Controller
{

    private $dataService;

    public function __construct(ArticleDataService $dataService)
    {
        $this->dataService = $dataService;
    }

    /**
     * 文章详情
     * @param $id
     * @return mixed|\think\response\View
     */
    public function details($id)
    {
       return view('' , $this->dataService->setDetailsInfo($id));
    }

    /**
     * 分类下的文章列表
     * @param $cateId
     * @return mixed|\think\response\View
     */
    public function articleList($cateId ,$cateName)
    {
        return view('list' , $this->dataService->setArticleListInfo($cateId,$cateName));
    }

    /**
     * 搜索
     * @return mixed|\think\response\View
     */
    public function search()
    {
        return view('list' , $this->dataService->setSearchInfo());
    }
}