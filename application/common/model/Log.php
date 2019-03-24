<?php

namespace app\common\model;
use think\Model;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-20
 * Time: 上午11:52
 */

class Log extends Model
{
    public function add($domain)
    {
        return $this->save($domain);
    }
}