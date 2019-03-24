<?php

namespace app\common\util;
/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-21
 * Time: 下午6:14
 */

class StringUtil
{
    public static function array2string(array $array , $separator = ",")
    {
        $retString = "";
        foreach ($array as $key => $value) {
            $retString.= $value.$separator;
        }
        return trim($retString , $separator);
    }
}