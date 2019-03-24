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
 * 留言模块
 */

class Message extends Controller
{
    private $commonDbService;
    private $commonDataService;
    private $validate;

    public function __construct()
    {
        $this->commonDbService = new CommonDbService(new \app\common\model\Message());
        $this->commonDataService = new CommonDataService(new \app\common\model\Message());
        $this->validate = new \app\common\validate\Message();
    }


    /**
     * 留言列表
     */
    public function messageList()
    {
        $condition = new Condition(request()->get());
        $commentData = $this->commonDbService->findAllPaged($condition);
        return view('list' , $this->commonDataService->setCondition($commentData , $condition));
    }

    /**
     * 留言详情
     * @param $id   留言id
     * @return mixed|\think\response\View
     */
    public function details($id)
    {
        $details = $this->commonDbService->findById($id);
        return view('' , ['details' => $details]);
    }

    /**
     * 回复留言
     */
    public function reply()
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