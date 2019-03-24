<?php

namespace app\common\model;
use think\Model;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-21
 * Time: 上午11:09
 */

class Node extends Model
{
    public function findById($id ,$field)
    {
        return $this->where(['id' => $id])->field($field)->find();
    }
}