<?php

namespace app\common\service\message;
use think\Request;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-19
 * Time: 下午6:18
 */

class MessageDataService
{
    public function req2domain(Request $request)
    {
        $domain = $request->param();
        $domain['ip'] = $request->ip();
        return $domain;
    }
}