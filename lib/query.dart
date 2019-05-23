import 'package:yun_dao/dao.dart';
import 'package:yun_dao/db_manager.dart';

///sqllite查询器
class Query {
  ///表名
  dynamic dao;
  List<QueryCondition> _queryConditionList = List();
  String _orderBy;
  String _groupBy;

  Query(dynamic dao) {
    this.dao = dao;
  }

  ///增加查询条件
  Query where(QueryCondition queryCondition) {
    _queryConditionList.add(queryCondition);
    return this;
  }

  ///排序
  Query orderBy(QueryCondition queryCondition) {
    _orderBy = queryCondition.key;
    return this;
  }

  Query groupBy(QueryCondition queryCondition) {
    _groupBy = queryCondition.key;
    return this;
  }

  ///查询
  Future<List> list() async {
    DBManager dbManager = DBManager();
    String whereKey = "";
    List whereValue = List();
    for (QueryCondition queryCondition in _queryConditionList) {
      if (queryCondition ==
          _queryConditionList[_queryConditionList.length - 1]) {
        whereKey = whereKey + queryCondition.key + " = ?";
      } else {
        whereKey = whereKey + queryCondition.key + " = ? and ";
      }

      whereValue.add(queryCondition.value);
    }
    List<Map> maps = await dbManager.db.query(dao.getTableName(),
        where: whereKey,
        whereArgs: whereValue,
        orderBy: _orderBy,
        groupBy: _groupBy);
    List list = List();
    for (Map map in maps) {
      list.add(dao.formMap(map));
    }
    return list;
  }
}

///查询条件
class QueryCondition {
  String key;
  dynamic value;

  QueryCondition({this.value, this.key});
}
