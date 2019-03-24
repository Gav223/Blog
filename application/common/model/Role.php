<?php

namespace app\common\model;
use think\Model;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-21
 * Time: 上午11:10
 */

class Role extends Model
{
    public function findById($id)
    {
        return $this->where(['id' => $id])->find();
    }

    public function findByIdIn($idList)
    {
        return $this->where('id' , 'in' ,$idList)->all();
    }

}