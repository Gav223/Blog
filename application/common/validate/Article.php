<?php

namespace app\common\validate;

use think\Validate;

class Article extends Validate
{
    /**
     * 定义验证规则
     * 格式：'字段名'	=>	['规则1','规则2'...]
     *
     * @var array
     */
    protected $rule = [
        'id' => 'require' ,
	    'name' => 'require',
        'content' => 'require',
        'cate_id' => 'require',
        'is_top' => 'require|in:0,1',
        'image' => 'require',
        'description' => 'require'
    ];
    
    /**
     * 定义错误信息
     * 格式：'字段名.规则名'	=>	'错误信息'
     *
     * @var array
     */
    protected $message = [
        'name.require' => '请输入文章标题' ,
        'content.require' => '请输入文章内容' ,
        'cate_id.require' => '请选择分类' ,
        'is_top.require' => '请选择是否置顶' ,
        'image.require' => '请选择文章展示图片' ,
        'description.require' => '请输入文章描述'
    ];

    protected $scene = [
        'add' => ['name' , 'content' , 'cate_id' , 'is_top' , 'image' , 'description'] ,
        'delete'  =>  ['id']
    ];
}
