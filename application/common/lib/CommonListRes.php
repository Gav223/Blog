<?php

namespace app\common\lib;
use think\paginator\driver\Bootstrap;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-15
 * Time: 下午5:30
 */

class CommonListRes
{
    public static function getData(Bootstrap $model)
    {
        $retData = [];
        $retData['list'] = $model->all();
        $retData['page'] = $model->render();
        $retData['total'] = $model->total();
        return $retData;
    }
}