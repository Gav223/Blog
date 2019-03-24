<?php

namespace app\common\lib;
/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-15
 * Time: 下午5:18
 */

class DefaultSetting
{
    public static $SHOW_NUM = 7;
    public static $UPLOAD_PATH = "http://localhost/tp5/public/uploads/";
    public static $RANK_SHOW_NUM = 8;
    public static $NOT_NEED_LOGIN_ACTION_LIST = [
        "login" , "checklogin"
    ];
    public static $NOT_NEED_CHECK_AUTH_CONTROLLERS = [
        'index'
    ];
    public static $NOT_NEED_CHECK_AUTH_ACTIONS = [
        'login' , 'logout'
    ];
}