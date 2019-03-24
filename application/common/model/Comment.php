<?php

namespace app\common\model;
use think\Model;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-19
 * Time: 下午3:58
 */

class  Comment extends Model
{
    public function findByArticleId($articleId)
    {
        return $this->where(['article_id' => $articleId])->order('id', 'desc')->all();
    }

    public function findByIpAndArticleId($ip, $articleId)
    {
        return $this->where(['ip' => $ip, 'article_id' => $articleId])->find();
    }

    public function count()
    {
        return $this->where([])->count();
    }
}