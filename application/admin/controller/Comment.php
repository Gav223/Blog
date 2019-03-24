<?php

namespace app\admin\controller;
use app\common\lib\Condition;
use app\common\service\common\CommonDataService;
use app\common\service\common\CommonDbService;
use think\Controller;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-20
 * Time: 上午10:21
 * 评论模块
 */

class Comment extends Controller
{

    private $commonDbService;
    private $commonDataService;
    private $validate;

    public function __construct()
    {
        $this->commonDbService = new CommonDbService(new \app\common\model\Comment());
        $this->commonDataService = new CommonDataService(new \app\common\model\Comment());
        $this->validate = new \app\common\validate\Comment();
    }


    /**
     * 评论列表
     */
    public function commentList()
    {
        $condition = new Condition(request()->get());
        $commentData = $this->commonDbService->findAllPaged($condition);
        return view('list' , $this->commonDataService->setCondition($commentData , $condition));
    }

    /**
     * 详情
     * @param $id   评论id
     * @return mixed|\think\response\View
     */
    public function details($id)
    {
        $details = $this->commonDbService->findById($id);
        return view('' , ['details' => $details]);
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