<?php

namespace app\common\validate;

use think\Validate;

class Role extends Validate
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
        'node_id' => 'require'
    ];

    /**
     * 定义错误信息
     * 格式：'字段名.规则名'	=>	'错误信息'
     *
     * @var array
     */
    protected $message = [
        'name.require' => '请输入角色名' ,
        'description.require' => '请输入角色描述' ,
        'node_id.require' => '请选择节点'
    ];

    protected $scene = [
        'add' => ['name' , 'description' , 'node_id'] ,
        'delete'  =>  ['id'] ,
        'update' => ['id' , 'name' , 'description']
    ];
}
