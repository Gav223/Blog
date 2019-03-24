<?php

namespace app\common\lib;
/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-15
 * Time: 下午4:44
 */

class Condition
{
    public $showNum;
    public $searchKeyWords;
    public $startDate;
    public $endDate;
    public $startTimeStamp;
    public $endTimeStamp;
    public $cate_id;
    public $article_id;
    public $article_name;

    public function __construct($requestParam)
    {
        if(isset($requestParam['showNum']) && !empty($requestParam['showNum'])) {
            $this->showNum = $requestParam['showNum'];
        }else{
            $this->showNum = DefaultSetting::$SHOW_NUM;
        }
        if(isset($requestParam['searchKeyWords']) && !empty($requestParam['searchKeyWords'])) {
            $this->searchKeyWords = $requestParam['searchKeyWords'];
        }
        if(isset($requestParam['startDate']) && !empty($requestParam['startDate'])) {
            $this->startDate = $requestParam['startDate'];
            $this->startTimeStamp = strtotime($this->startDate);
        }
        if(isset($requestParam['endDate']) && !empty($requestParam['endDate'])) {
            $this->endDate = $requestParam['endDate'];
            $this->endTimeStamp = strtotime($this->endDate)+86399;
        }
        if(isset($requestParam['cate_id']) && !empty($requestParam['cate_id'])) {
            $this->cate_id = $requestParam['cate_id'];
        }
        if(isset($requestParam['article_id']) && !empty($requestParam['article_id'])) {
            $this->article_id = $requestParam['article_id'];
        }
        if(isset($requestParam['article_name']) && !empty($requestParam['article_name'])) {
            $this->article_name = $requestParam['article_name'];
        }
        return $this;
    }
}