<?php

namespace app\common\model;
use think\Model;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-14
 * Time: 下午3:55
 */
class Admin extends Model
{
    public function findByName($name)
    {
        return $this->where(['name' => $name])->find();
    }

    public function count()
    {
        return $this->where([])->count();
    }

    public function add($domain)
    {
        return $this->save($domain);
    }

    public function findById($id)
    {
        return $this->where(['id' => $id])->find();
    }
}