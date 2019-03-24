<?php

namespace app\common\validate;

use think\Validate;

class ArticleCate extends Validate
{
    /**
     * 定义验证规则
     * 格式：'字段名'	=>	['规则1','规则2'...]
     *
     * @var array
     */	
	protected $rule = [
	    'id' => 'require' ,
        'name' => 'require'
    ];
    
    /**
     * 定义错误信息
     * 格式：'字段名.规则名'	=>	'错误信息'
     *
     * @var array
     */	
    protected $message = [
        'name.require' => '请输入分类名'
    ];

    protected $scene = [
        'add' => ['name'] ,
        'delete'  =>  ['id'] ,
        'update' => ['id' , 'name']
    ];
}
