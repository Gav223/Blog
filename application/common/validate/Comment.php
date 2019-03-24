<?php

namespace app\common\validate;

use think\Validate;

class Comment extends Validate
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
        'article_id' => 'require' ,
        'image' => 'require' ,
        'article_name' => 'require'
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
        'content.require' => '请输入评论内容'
    ];

    protected $scene = [
        'add' => ['name' , 'content' , 'article_id' , 'image' , 'article_name'] ,
        'delete'  =>  ['id'] ,
        'update' => ['id' , 'name' , 'content' , 'article_id' , 'image' , 'article_name']
    ];
}
