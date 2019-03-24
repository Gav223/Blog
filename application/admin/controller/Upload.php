<?php

namespace app\admin\controller;
use app\common\lib\Code;
use app\common\lib\DefaultSetting;
use think\Controller;
use think\facade\Log;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-18
 * Time: 上午10:30
 * 文件上传
 */

class Upload extends Controller
{

    /**
     * 图片上传
     */
    public function uploadImage()
    {
        // 获取表单上传文件 例如上传了001.jpg
        $file = request()->file('file');
        // 移动到框架应用根目录/uploads/ 目录下
        $info = $file->validate(['ext'=>'jpg,png,gif,jpeg'])->move( './uploads/');
        if($info){
            $saveName = $info->getSaveName();
            return json([
                'code' => Code::$SUCCESS ,
                'path' => DefaultSetting::$UPLOAD_PATH.$saveName ,
                'msg' => '上传成功'
            ]);
        }else{
            // 上传失败获取错误信息
            Log::write('上文件失败:'.$file->getError());
            return json(['code' => Code::$ERROR , 'msg' => '上传失败']);
        }
    }
}