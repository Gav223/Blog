<?php

namespace app\admin\behavior;
use app\common\lib\DefaultSetting;
use think\facade\Log;
use think\Request;
use traits\controller\Jump;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-21
 * Time: 上午10:52
 */

class CheckAuth
{
    use Jump;

    /**
     * 鉴权
     */
    public function run(Request $request)
    {
        $controller = strtolower($request->controller());
        $action = strtolower($request->action());
        Log::write("controller:{$controller}|action:{$action}");
        if(!in_array($controller , DefaultSetting::$NOT_NEED_CHECK_AUTH_CONTROLLERS) && !in_array($action , DefaultSetting::$NOT_NEED_CHECK_AUTH_ACTIONS))
        {
            $authData = session('authData:'.cookie('adminName'));
            Log::write('authData:'.json_encode($authData));
            if(!isset($authData[$controller][$action])) {
                return $this->error('无权限' , 'admin/Index/welcome');
            }
        }
    }
}