<?php

namespace app\admin\controller;
use app\common\lib\Condition;
use app\common\service\article\ArticleDataService;
use app\common\service\articleCate\ArticleCateDataService;
use app\common\service\common\CommonDataService;
use app\common\service\common\CommonDbService;
use think\Controller;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-15
 * Time: 上午10:46
 * 文章模块
 */

class Article extends Controller
{
    private $commonDbService;
    private $commonDataService;
    private $dataService;
    private $cateModel;
    private $cateDataService;
    private $validate;

    public function __construct()
    {
        $this->commonDbService = new CommonDbService(new \app\common\model\Article());
        $this->commonDataService = new CommonDataService(new \app\common\model\Article());
        $this->dataService = new ArticleDataService();
        $this->cateModel = new \app\common\model\ArticleCate();
        $this->cateDataService = new ArticleCateDataService();
        $this->validate = new \app\common\validate\Article();
    }

    /**
     * 文章列表
     * TODO 查询文章列表,设置所属分类名,查询分类列表
     */
    public function articleList()
    {
        $condition = new Condition(request()->get());
        $queryData = $this->commonDbService->findAllPaged($condition);
        $queryData['list'] = $this->cateDataService->setCateName($queryData['list']);   //TODO 设置所属分类名
        $queryData['cateList'] = $this->cateModel->findAll();    //TODO 设置分类列表
        return view('list' , $this->commonDataService->setCondition($queryData,$condition));
    }

    /**
     * 添加
     */
    public function add()
    {
        if(request()->method() === 'GET') {
            $cateList = $this->cateModel->findAll();
            return view('',['cateList' => $cateList]);
        }
        $req = $this->dataService->setAdminInfo(request()->param());
        return $this->commonDataService->add($req,NULL,$this->validate);
    }

    /**
     * 详情
     */
    public function details()
    {
        $cateList = $this->cateModel->findAll();
        $article = $this->commonDbService->findById(request()->only('id'));
        return view('' , ['article' => $article , 'cateList' => $cateList]);
    }

    /**
     * 更新
     */
    public function update()
    {
        return $this->commonDataService->update(request()->param(),$this->validate);
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

    /**
     * 置顶
     * @param $id
     * @param $is_top   //是否置顶 1.是 0.否
     * @return \ezswoole\response\Json|\think\response\Json
     */
    public function setTop($id ,$is_top)
    {
        return $this->dataService->setTop($id,$is_top);
    }

    /**
     * 推荐
     * @param $id
     * @param $is_recommended
     * @return \ezswoole\response\Json|\think\response\Json
     */
    public function setRecommended($id ,$is_recommended)
    {
        return $this->dataService->setRecommended($id,$is_recommended);
    }
}