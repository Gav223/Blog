<?php

namespace app\common\model;
use think\Model;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-21
 * Time: 上午11:10
 */

class AdminRole extends Model
{
    public function findByAdminId($adminId ,$field = NULL)
    {
        return $this->where(['admin_id' => $adminId])->field($field)->order(['id' => 'desc'])->all();
    }

    public function deleteByAdminId($adminId)
    {
        return $this->where(['admin_id' => $adminId])->delete();
    }

    public function deleteByAdminIdIn($adminIdList)
    {
        return $this->where('admin_id' , 'in' , $adminIdList)->delete();
    }
}