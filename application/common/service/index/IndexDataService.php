<?php

namespace app\common\service\index;
use app\common\lib\Condition;
use app\common\lib\DefaultSetting;
use app\common\model\Admin;
use app\common\model\Article;
use app\common\model\ArticleCate;
use app\common\model\Comment;
use app\common\model\Message;
use app\common\service\article\ArticleDataService;
use app\common\service\common\CommonDbService;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-20
 * Time: 下午6:19
 */

class IndexDataService
{
    private $articleModel;
    private $cateModel;
    private $articleDataService;
    private $commonDbService;
    private $commentModel;
    private $adminModel;
    private $messageModel;

    public function __construct()
    {
        $this->articleModel = new Article();
        $this->cateModel = new ArticleCate();
        $this->articleDataService = new ArticleDataService();
        $this->commonDbService = new CommonDbService(new Article());
        $this->commentModel = new Comment();
        $this->adminModel = new Admin();
        $this->messageModel = new Message();
    }

    /**
     * 设置首页数据
     * @return array
     */
    public function setIndexInfo()
    {
        $cateList = $this->cateModel->findAll(DefaultSetting::$SHOW_NUM);   //TODO 分类列表
        $cateList = $this->articleDataService->setArticleList($cateList);    //TODO 获取分类下的文章
        $sort = ['is_top' => 'desc' , 'id' => 'desc'];
        $articleData = $this->commonDbService->findAllPaged(new Condition(['showNum' => DefaultSetting::$SHOW_NUM]),$sort);
        $rankList = $this->articleModel->findRankList(DefaultSetting::$RANK_SHOW_NUM);  //TODO 查询排行数据
        $newArticleList = $this->articleModel->findNewArticle(4);   //TODO 查询最新四篇文章
        $recommendedList = $this->commonDbService->findByCondition(['is_recommended' => 1] , 10 , ['id' => 'desc']);    //TODO 推荐文章
        return [
            'cateList' => $cateList ,
            'articleData' => $articleData ,
            'rankList' => $rankList ,
            'newArticleList' => $newArticleList ,
            'recommendedList' => $recommendedList
        ];
    }

    /**
     * TODO 文章数,评论数,管理员数,留言数
     */
        public function getCountInfo()
    {
        $countData = [];
        $countData['articleCount'] = $this->articleModel->count();   //TODO 查询文章数
        $countData['commentCount'] = $this->commentModel->count();   //TODO 查询评论数
        $countData['adminCount'] = $this->adminModel->count();   //TODO 查询管理员数
        $countData['messageCount'] = $this->messageModel->count();   //TODO 查询留言数
        return $countData;
    }
}