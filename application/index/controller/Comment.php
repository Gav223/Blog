<?php

namespace app\index\controller;
use app\common\service\comment\CommentDataService;
use app\common\service\common\CommonDataService;
use app\common\service\common\CommonDbService;
use think\App;
use think\Controller;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-19
 * Time: 下午3:56
 */

class Comment extends Controller
{
    private $commonDbService;
    private $commonDataService;
    private $dataService;
    private $validate;

    public function __construct()
    {
        $this->commonDbService = new CommonDbService(new \app\common\model\Comment());
        $this->commonDataService = new CommonDataService(new \app\common\model\Comment());
        $this->dataService = new CommentDataService();
        $this->validate = new \app\common\validate\Comment();
    }

    /**
     * @return \ezswoole\response\Json|\think\response\Json
     * TODO 1.检查该ip是否已评论
     * TODO 2.插入数据|返回提示信息
     */
    public function add()
    {
        $params = request()->param();
        $params['ip'] = request()->ip();
        $checkResult = $this->dataService->checkCommentAuth($params['ip'],$params['article_id']);    //TODO 检查是否已评论
        if($checkResult === false) return $this->success('请勿重复评论');
        return $this->commonDataService->add($params , "form" , $this->validate);
    }
}