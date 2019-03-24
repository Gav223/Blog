<?php

namespace app\common\validate;

use think\Validate;

class Node extends Validate
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
        'description' => 'require' ,
        'pid' => 'require'
    ];

    /**
     * 定义错误信息
     * 格式：'字段名.规则名'	=>	'错误信息'
     *
     * @var array
     */
    protected $message = [
        'name.require' => '请输入节点名' ,
        'description.require' => '请输入节点描述' ,
        'pid.require' => '请选择父节点' ,
    ];

    protected $scene = [
        'add' => ['name' , 'description' , 'pid'] ,
        'delete'  =>  ['id'] ,
        'update' => ['id' , 'name' , 'description' , 'pid']
    ];
}
