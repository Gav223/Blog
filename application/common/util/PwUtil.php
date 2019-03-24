<?php

namespace app\common\util;
/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-18
 * Time: 下午4:01
 */

class  PwUtil
{
    public static function encode($pw,$salt)
    {
        return md5($pw.$salt);
    }
}