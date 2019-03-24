<?php

namespace app\common\validate;

use think\Validate;

class Admin extends Validate
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
        'pw' => 'require' ,
        'role_id' => 'require'
    ];
    
    /**
     * 定义错误信息
     * 格式：'字段名.规则名'	=>	'错误信息'
     *
     * @var array
     */	
    protected $message = [
        'role_id.require' => '请选择角色' ,
        'name.require' => '请输入昵称' ,
        'pw.require' => '请输入密码'
    ];

    protected $scene = [
        'add' => ['name' , 'pw' , 'role_id'] ,
        'delete'  =>  ['id'] ,
        'update' => ['id' , 'name' , 'role_id']
    ];
}
