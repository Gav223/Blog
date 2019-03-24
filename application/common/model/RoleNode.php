<?php

namespace app\common\model;
use think\Model;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-21
 * Time: 上午11:10
 */

class RoleNode extends Model
{
    public function findByRoleId($roleId , $field = NULL)
    {
        return $this->where(['role_id' => $roleId])->field($field)->order(['id' => 'desc'])->all();
    }

    public function deleteByRoleId($roleId)
    {
        return $this->where('role_id' , $roleId)->delete();
    }

    public function deleteByRoleIdIn($roleIdList)
    {
        return $this->where('role_id' , 'in' ,$roleIdList)->delete();
    }
}