<?php

namespace app\common\model;
use think\Model;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-15
 * Time: 上午10:55
 */

class ArticleCate extends Model
{
    public function findAll($limit = NULL)
    {
        if($limit !== NULL) return $this->order('id' , 'desc')->limit($limit)->all();
        return $this->order('id' , 'desc')->all();
    }
}