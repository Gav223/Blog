<?php

namespace app\common\service\comment;
use app\common\model\Comment;
use app\common\service\common\CommonDbService;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-19
 * Time: 下午3:59
 */

class CommentDataService
{
    private $dbService;

    public function __construct()
    {
        $this->dbService = new Comment();
    }

    public function checkCommentAuth($ip ,$articleId)
    {
        $commentData = $this->dbService->findByIpAndArticleId($ip,$articleId);
        if($commentData !== NULL) return false;
        return true;
    }


}