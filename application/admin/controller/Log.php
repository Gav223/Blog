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
 * Time: 上午10:25
 * 日志模块
 */

class Log extends Controller
{
    private $commonDbService;
    private $commonDataService;
    private $validate;

    public function __construct()
    {
        $this->commonDbService = new CommonDbService(new \app\common\model\Log());
        $this->commonDataService = new CommonDataService(new \app\common\model\Log());
        $this->validate = new \app\common\validate\Log();
    }

    /**
     * 日志列表
     */
    public function logList()
    {
        $condition = new Condition(request()->get());
        $commentData = $this->commonDbService->findAllPaged($condition);
        return view('list' , $this->commonDataService->setCondition($commentData , $condition));
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