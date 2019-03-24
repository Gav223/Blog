<?php

namespace app\common\service\articleCate;


use app\common\lib\Code;
use app\common\lib\Condition;
use app\common\lib\Message;
use app\common\model\ArticleCate;
use app\common\service\article\ArticleDbService;
use app\common\service\common\CommonDbService;
use think\facade\Log;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-15
 * Time: 上午10:56
 */

class ArticleCateDataService
{

    private $commonDbService;

    public function __construct()
    {
        $this->commonDbService = new CommonDbService(new ArticleCate());
    }

    /**
     * @param $articleList
     * @return mixed
     * 设置文章所属分类名称
     */
    public function setCateName($articleList, $type = NULL)
    {
        if ($type === NULL) {
            foreach ($articleList as $key => $value) {
                $cate = $this->commonDbService->findById($value['cate_id']);
                if ($cate === NULL) {
                    $articleList[$key]['cate_name'] = '未知';
                } else {
                    $articleList[$key]['cate_name'] = $cate['name'];
                }
            }
            return $articleList;
        } else {
            $cate = $this->commonDbService->findById($articleList['cate_id']);
            if ($cate === NULL) {
                $articleList['cate_name'] = '未知';
            } else {
                $articleList['cate_name'] = $cate['name'];
            }
            return $articleList;
        }

    }
}