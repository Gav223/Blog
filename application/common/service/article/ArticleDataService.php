<?php

namespace app\common\service\article;
use app\common\lib\Code;
use app\common\lib\Condition;
use app\common\lib\DefaultSetting;
use app\common\lib\Message;
use app\common\model\Article;
use app\common\model\ArticleCate;
use app\common\model\Comment;
use app\common\service\articleCate\ArticleCateDataService;
use app\common\service\common\CommonDbService;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-15
 * Time: 下午6:08
 */

class ArticleDataService
{

    private $commonDbService;
    private $dbService;
    private $cateDbService;
    private $commentDbService;
    private $cateDataService;

    public function __construct()
    {
        $this->commonDbService = new CommonDbService(new Article());
        $this->dbService = new Article();
        $this->cateDbService = new ArticleCate();
        $this->commentDbService = new Comment();
        $this->cateDataService = new ArticleCateDataService();
    }

    public function setArticleList($cateList)
    {
        foreach ($cateList as $key => $value) {
            $cateList[$key]['articleList'] = $this->dbService->findByCateId($value['id'], 5);
        }
        return $cateList;
    }

    public function setPreAndNextInfo($id)
    {
        $retData = [];
        $retData['preInfo'] = $this->dbService->findPreOrNextInfo($id, '>');
        $retData['nextInfo'] = $this->dbService->findPreOrNextInfo($id, '<');
        return $retData;
    }

    public function setAdminInfo($req)
    {
        $req['admin_id'] = cookie('?adminId') ? cookie('adminId') : 0;
        $req['admin_name'] = cookie('?adminName') ? cookie('adminName') : '';
        return $req;
    }

    /**
     * 置顶
     * TODO 1.设置对应的文章为置顶
     * TODO 2.将已置顶文章取消置顶
     * @param $id
     * @param $is_top
     * @return \ezswoole\response\Json|\think\response\Json
     */
    public function setTop($id ,$is_top)
    {
        if($is_top == 1) {
            $this->commonDbService->updateByCondition(['is_top' => 1],['is_top' => 0]);    //取消已置顶文章
        }
        $setTopResult = $this->commonDbService->update(['id' => $id , 'is_top' => $is_top]);   // 设置对应的文章置顶
        if($setTopResult !== false){
            return json(['code' => Code::$SUCCESS , 'msg' => Message::$SUCCESS]);
        }else{
            return json(['code' => Code::$ERROR , 'msg' => Message::$FAILED]);
        }
    }

    /**
     * 推荐
     * @param $id
     * @param $is_recommended
     * @return \ezswoole\response\Json|\think\response\Json
     */
    public function setRecommended($id ,$is_recommended)
    {
        $updateResult = $this->commonDbService->update(['id' => $id , 'is_recommended' => $is_recommended]);
        if($updateResult !== false){
            return json(['code' => Code::$SUCCESS , 'msg' => Message::$SUCCESS]);
        }else{
            return json(['code' => Code::$ERROR , 'msg' => Message::$FAILED]);
        }
    }

    /**
     * 增加点击量
     * @param $id
     * @return int|true
     */
    public function incPageView($id)
    {
        return $this->dbService->incPageView($id);
    }

    /**
     * 设置文章详情信息
     * @param $id
     * @return array
     */
    public function setDetailsInfo($id)
    {
        $this->incPageView($id);   //TODO 1.更新点击量
        $article = $this->commonDbService->findById($id);
        $article = $this->cateDataService->setCateName($article,''); //TODO 查询所属分类名称
        $article['preAndNextInfo'] = $this->setPreAndNextInfo($id);  //TODO 查询上一篇与下一篇文章信息
        $rankList = $this->dbService->findRankList(DefaultSetting::$RANK_SHOW_NUM);  //TODO 查询排行数据
        $cateList = $this->cateDbService->findAll(DefaultSetting::$SHOW_NUM);   //TODO 查询分类列表
        $commentList = $this->commentDbService->findByArticleId($article['id']);    //TODO 查询评论数据
        $newArticleList = $this->dbService->findNewArticle(4);   //TODO 查询最新文章数据
        $recommendedList = $this->commonDbService->findByCondition(['is_recommended' => 1] , 10 , ['id' => 'desc']);    //TODO 推荐文章
        return [
                'article' => $article ,
                'cateList' => $cateList ,
                'rankList' => $rankList ,
                'commentList' => $commentList ,
                'newArticleList' => $newArticleList ,
                'recommendedList' => $recommendedList
            ];
    }

    /**
     * 设置文章列表信息
     * @param $cateId
     * @param $cateName
     * @return array
     */
    public function setArticleListInfo($cateId ,$cateName)
    {
        $cateList = $this->cateDbService->findAll(DefaultSetting::$RANK_SHOW_NUM);   //TODO 查询分类列表
        $articleData = $this->commonDbService->findAllPaged(new Condition(['cate_id' => $cateId]));
        $rankList = $this->dbService->findRankList(DefaultSetting::$RANK_SHOW_NUM);  //TODO 查询排行数据
        $newArticleList = $this->dbService->findNewArticle(4);   //TODO 查询最新文章数据
        $recommendedList = $this->commonDbService->findByCondition(['is_recommended' => 1] , 10 , ['id' => 'desc']);    //TODO 推荐文章
        return [
            'articleData' => $articleData ,
            'cateList' => $cateList ,
            'cateName' => $cateName ,
            'rankList' => $rankList ,
            'newArticleList' => $newArticleList ,
            'recommendedList' => $recommendedList
        ];
    }

    /**
     * 设置搜索列表信息
     * @return array
     */
    public function setSearchInfo()
    {
        $cateList = $this->cateDbService->findAll(DefaultSetting::$RANK_SHOW_NUM);   //分类列表
        $articleData = $this->commonDbService->findAllPaged(new Condition(request()->param()));
        $rankList = $this->dbService->findRankList(DefaultSetting::$RANK_SHOW_NUM);  //TODO 查询排行数据
        $newArticleList = $this->dbService->findNewArticle(4);   //TODO 查询最新文章数据
        $recommendedList = $this->commonDbService->findByCondition(['is_recommended' => 1] , 10 , ['id' => 'desc']);    //TODO 推荐文章
        return [
            'articleData' => $articleData , 'cateList' => $cateList ,
            'cateName' => 'search' ,
            'rankList' => $rankList ,
            'newArticleList' => $newArticleList ,
            'recommendedList' => $recommendedList
        ];
    }


}