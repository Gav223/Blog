<?php

namespace app\common\validate;

use think\Validate;

class Message extends Validate
{
    /**
     * 定义验证规则
     * 格式：'字段名'	=>	['规则1','规则2'...]
     *
     * @var array
     */
    protected $rule = [
        'id' => 'require' ,
        'name' => 'require' ,
        'content' => 'require' ,
        'image' => 'require'
    ];

    /**
     * 定义错误信息
     * 格式：'字段名.规则名'	=>	'错误信息'
     *
     * @var array
     */
    protected $message = [
        'image.require' => '请选择头像' ,
        'name.require' => '请输入昵称' ,
        'content.require' => '请输入留言内容'
    ];

    protected $scene = [
        'add' => ['name' , 'content' , 'image'] ,
        'delete'  =>  ['id'] ,
        'update' => ['id' , 'name' , 'content' , 'image']
    ];
}
