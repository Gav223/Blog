<?php

namespace app\admin\behavior;
use app\common\lib\DefaultSetting;
use think\Request;
use traits\controller\Jump;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-14
 * Time: 下午4:23
 */

class CheckLogin
{
    use Jump;

    /**
     * 检查是否登录
     */
    public function run(Request $request)
    {
        $notNeedLoginActionList = DefaultSetting::$NOT_NEED_LOGIN_ACTION_LIST;
        if(!in_array($request->action() , $notNeedLoginActionList) && cookie('?adminId') === false){
            return $this->error('请登录','admin/Admin/login');
        }
    }
}