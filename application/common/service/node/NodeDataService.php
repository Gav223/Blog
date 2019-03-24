<?php

namespace app\common\service\node;
use app\common\model\Node;
use app\common\service\common\CommonDbService;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-21
 * Time: 下午2:50
 */

class NodeDataService
{
    private $commonDbService;

    public function __construct()
    {
        $this->commonDbService = new CommonDbService(new Node());
    }

    /**
     * 设置父节点名
     */
    public function setParentName($nodeList)
    {
        foreach ($nodeList as $key => $value) {
            if(isset($value['pid'])) {
                $parentData = $this->commonDbService->findById($value['pid']);
                if(!empty($parentData['name'])) {
                    $nodeList[$key]['parent_name'] = $parentData['name'];
                }else {
                    $nodeList[$key]['parent_name'] = '无';
                }
            }
        }
        return $nodeList;
    }

    /**
     * 查询所有控制器节点
     */
    public static function findControllerNodes()
    {
        $dbService = new CommonDbService(new Node());
        return $dbService->findByCondition(['pid' => 0] , NULL , ['id' => 'desc']);
    }

    /**
     * 查询所有控制器节点+对应的操作节点
     */
    public static function findControllerNodeAndActions()
    {
        $controllerNodes = self::findControllerNodes();
        $dbService = new CommonDbService(new Node());
        foreach ($controllerNodes as $key => $value) {
            $controllerNodes[$key]['actionList'] = $dbService->findByCondition(['pid' => $value['id']] , NULL , ['id' => 'desc']);
        }
        return $controllerNodes;
    }
}