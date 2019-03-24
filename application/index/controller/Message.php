<?php

namespace app\index\controller;
use app\common\lib\DefaultSetting;
use app\common\model\ArticleCate;
use app\common\service\articleCate\ArticleCateDbService;
use app\common\service\common\CommonDataService;
use app\common\service\common\CommonDbService;
use app\common\service\message\MessageDataService;
use think\Controller;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-19
 * Time: 下午5:56
 */

class Message extends Controller
{
    private $commonDbService;
    private $commonDataService;
    private $cateDbService;
    private $dataService;
    private $validate;

    public function __construct()
    {
        $this->commonDbService = new CommonDbService(new \app\common\model\Message());
        $this->commonDataService = new CommonDataService(new \app\common\model\Message());
        $this->cateDbService = new ArticleCate();
        $this->dataService = new MessageDataService();
        $this->validate = new \app\common\validate\Message();
    }

    public function add()
    {
        $domain = $this->dataService->req2domain(request());
        return $this->commonDataService->add($domain , 'form' , $this->validate);
    }

    public function messageList()
    {
        $cateList = $this->cateDbService->findAll(DefaultSetting::$SHOW_NUM);   //TODO 查询分类列表
        $messageList = $this->commonDbService->findAll();   //TODO 查询留言列表
        return view('message' , ['cateList' => $cateList , 'messageList' => $messageList]);
    }
}