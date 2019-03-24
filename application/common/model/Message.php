<?php

namespace app\common\model;
use think\Model;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-19
 * Time: 下午6:00
 */

class Message extends Model
{
    public function count()
    {
        return $this->where([])->count();
    }
}