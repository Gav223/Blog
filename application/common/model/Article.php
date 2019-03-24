<?php

namespace app\common\model;
use think\Model;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-14
 * Time: 下午6:12
 */

class Article extends Model
{
    public function findByCateId($cateId ,$showNum = NULL)
    {
        if($showNum !== NULL) return $this->where('cate_id' , $cateId)->order('id' , 'desc')->limit($showNum)->all();
        return $this->where('cate_id' , $cateId)->order('id' , 'desc')->all();
    }

    public function findPreOrNextInfo($id ,$type)
    {
        $sort = 'desc';
        if($type === '>') $sort = 'asc';
        return $this->where('id' , $type , $id)->order('id' , $sort)->find();
    }

    public function findRankList($showNum)
    {
        return $this->order('page_view' , 'desc')->limit($showNum)->all();
    }

    public function findNewArticle($showNum)
    {
        return $this->order('create_time' , 'desc')->limit($showNum)->all();
    }

    public function incPageView($id)
    {
        return $this->where(['id' => $id])->setInc('page_view');
    }

    public function count()
    {
        return $this->where([])->count();
    }
}