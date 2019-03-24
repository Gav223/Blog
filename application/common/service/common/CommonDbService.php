<?php

namespace app\common\service\common;
use app\common\lib\CommonListRes;
use app\common\lib\Condition;
use think\Model;

/**
 * Created by PhpStorm.
 * User: alex
 * Date: 19-2-18
 * Time: 上午9:04
 */

class CommonDbService
{

    private $model;

    public function __construct(Model $model)
    {
        $this->model = $model;
    }

    /**
     * @param $model
     * @param Condition $condition
     * @return mixed
     * 设置查询条件
     */
    public static function setCondition($model , Condition $condition)
    {
        $model = $model->where([]);
        if ($condition->startDate !== NULL && $condition->endDate !== NULL) {
            $model = $model->where('create_time', 'between', [$condition->startTimeStamp, $condition->endTimeStamp]);
        }
        if ($condition->searchKeyWords !== NULL) {
            $model = $model->where('name', 'like', "%{$condition->searchKeyWords}%");
        }
        if($condition->cate_id !== NULL) {
            $model = $model->where('cate_id' , $condition->cate_id);
        }
        if($condition->article_id !== NULL) {
            $model = $model->where('article_id' , $condition->article_id);
        }
        return $model;
    }

    /**
     * @param Condition $condition
     * @return array
     * 查询(分页)
     */
    public function findAllPaged(Condition $condition ,$sort = ['id' => 'desc'])
    {
        $model = CommonDbService::setCondition($this->model,$condition)->order($sort)
            ->paginate($condition->showNum);
        return CommonListRes::getData($model);
    }

    /**
     * 根据条件查询
     */
    public function findByCondition($condition ,$limit = NULL ,$sort = NULL)
    {
        $model = $this->model->where($condition);
        if($limit !== NULL) $model = $model->limit($limit);
        if($sort !== NULL) $model = $model->order($sort);
        return $model->all();
    }

    /**
     * 查询所有记录
     */
    public function findAll()
    {
        return $this->model->order('id' , 'desc')->all();
    }

    /**
     * 根据名称查询
     */
    public function findByName(array $condition){
        return $this->model->where($condition)->find();
    }

    /**
     * 添加
     */
    public function add($data)
    {
        return $this->model->save($data);
    }

    /**
     * 更新(by id)
     */
    public function update($data)
    {
        return $this->model->where(['id' => $data['id']])->update($data);
    }

    /**
     * 根据条件更新
     */
    public function updateByCondition($condition ,$data)
    {
        return $this->model->where($condition)->update($data);
    }

    /**
     * 删除
     */
    public function delete($id)
    {
        return $this->model->where(['id' => $id])->delete();
    }

    /**
     * 通过id查询
     */
    public function findById($id)
    {
        return $this->model->where(['id' => $id])->find();
    }

    /**
     * 查询id !=
     */
    public function findByIdNotIn($id,$name)
    {
        return $this->model->where(['name' => $name])->where('id','<>',$id)->find();
    }

    /**
     * 批量删除
     */
    public function deleteByIdIn($idList)
    {
        return $this->model->where('id' , 'in' , $idList)->delete();
    }
}