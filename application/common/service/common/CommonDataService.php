<?php

namespace app\common\service\common;
use app\common\lib\Code;
use app\common\lib\Message;
use think\facade\Log;
use think\Model;
use think\Validate;
use traits\controller\Jump;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-18
 * Time: 上午9:18
 */

class CommonDataService
{
    private $dbService;
    use Jump;

    public function __construct(Model $model)
    {
        $this->dbService = new CommonDbService($model);
    }

    /**
     * 添加
     * @param $request //请求数据
     * @param null $retType //返回类型(json|jump)
     * @return \ezswoole\response\Json|\think\response\Json
     */
    public function add($request ,$retType = NULL ,Validate $validate)
    {
        if(!$validate->scene('add')->check($request))
        {
            if($retType !== NULL) $this->error($validate->getError());
            return json(['code' => Code::$VALIDATE_ERROR , 'msg' => $validate->getError()]);
        }
        $code = Code::$SUCCESS;
        $msg = Message::$SUCCESS;
        $condition = ['name' => $request['name']];
        if(isset($request['pid'])) $condition['pid'] = $request['pid'];
        $domain = $this->dbService->findByName($condition);
        if($domain !== NULL){
            $code = Code::$ALREADY_EXISTED;
            $msg = Message::$ALREADY_EXISTED;
        }else{
            $addResult = $this->dbService->add($request);
            if($addResult === false) {
                $code = Code::$ERROR;
                $msg = Message::$FAILED;
            }
        }
        if($retType !== NULL) $this->success('操作成功');
        return json(['code' => $code , 'msg' => $msg]);
    }

    /**
     * 更新
     * @param $request  //请求数据
     * @return \ezswoole\response\Json|\think\response\Json
     */
    public function update($request ,Validate $validate)
    {
        if(!$validate->scene('update')->check($request))
        {
            return json(['code' => Code::$VALIDATE_ERROR , 'msg' => $validate->getError()]);
        }
        $code = Code::$SUCCESS;
        $msg = Message::$SUCCESS;
        $request['id'] = (int)$request['id'];
        if(isset($request['name'])) {
            $domain = $this->dbService->findByIdNotIn($request['id'],$request['name']);
        }else{
            $domain = NULL;
        }
        if($domain === NULL){
            $updateResult = $this->dbService->update($request);
            if($updateResult === false){
                Log::write('更新失败');
                $code = Code::$ERROR;
                $msg = Message::$FAILED;
            }else{
                Log::write('更新成功');
            }
        }else{
            $code = Code::$ALREADY_EXISTED;
            $msg = Message::$ALREADY_EXISTED;
        }
        return json(['code' => $code , 'msg' => $msg]);
    }

    /**
     * 删除
     * @param $id
     * @return \ezswoole\response\Json|\think\response\Json
     */
    public function delete($request ,Validate $validate)
    {
        if(!$validate->scene('delete')->check($request))
        {
            return json(['code' => Code::$VALIDATE_ERROR , 'msg' => $validate->getError()]);
        }
        $code = Code::$SUCCESS;
        $msg = Message::$SUCCESS;
        $deleteResult = $this->dbService->delete($request['id']);
        if($deleteResult === false){
            $code = -1;
            $msg = '删除失败';
            Log::write('删除失败');
        }
        return json(['code' => $code , 'msg' => $msg]);
    }

    /**
     * 批量删除
     * @param $idList
     * @return \ezswoole\response\Json|\think\response\Json
     */
    public function deleteByIdIn($request)
    {
        $code = Code::$SUCCESS;
        $msg = Message::$SUCCESS;
        $deleteResult = $this->dbService->deleteByIdIn($request['idList']);
        if($deleteResult === false){
            $code = -1;
            $msg = '操作失败';
        }
        return json(['code' => $code , 'msg' => $msg]);
    }

    public function setCondition($queryData , $condition)
    {
        $queryData['condition'] = $condition;
        return $queryData;
    }
}