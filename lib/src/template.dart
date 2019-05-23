const String clazzTpl = """
///{{{tableName}}}表
import 'package:yun_dao/src/db_manager.dart';
import 'package:yun_dao/src/entity.dart';
import 'dart:convert';
import 'package:{{{source}}}';
import 'package:fluttertoast/fluttertoast.dart';
 class {{{className}}}{
  static List propertyMapList =  {{{propertyList}}};
 
  ///初始化数据库
  static Future<bool> init() async{
      DBManager dbManager = DBManager();
      List<Map> maps = await await dbManager.db.query("sqlite_master", where: " name = '{{{tableName}}}'");
      if(maps == null ||maps.length ==0){
           List<Property> propertyList = List();
         for(Map map in propertyMapList){
            propertyList.add(Property.fromJson(map));
            }
      dbManager.db.execute("CREATE TABLE {{{tableName}}}({{{createSql}}})");
       
      }
      return true;
  
  }
  
  
  ///查询表中所有数据
  static Future<List<{{{entityName}}}>> queryAll() async{
           DBManager dbManager = DBManager();
           List<{{{entityName}}}> entityList = List();
           List<Map> maps = await dbManager.db.query("{{{tableName}}}")  ;
           for(Map map in maps){
              entityList.add(_formMap(map));
           }
           return entityList;
  }
  
  
  ///增加一条数据
  static Future<bool> insert({{{entityName}}} entity) async{
       DBManager dbManager = DBManager();
       await dbManager.db.insert("{{{tableName}}}", _toMap(entity));
       return true;
  }
  
   ///增加多条条数据
  static Future<bool> insertList(List<{{{entityName}}}> entityList) async{
       DBManager dbManager = DBManager();
       List<Map> maps = List();
       for({{{entityName}}} entity in entityList){
            maps.add(_toMap(entity));
       }
       await dbManager.db.rawInsert("{{{tableName}}}", maps);
       return true;
  }
  
  ///更新数据
  static Future<int> update({{{entityName}}} entity) async {
    DBManager dbManager = DBManager();
    return await dbManager.db.update("{{{tableName}}}", _toMap(entity),
        where: '{{{primary}}} = ?', whereArgs: [entity.{{{primary}}}]);
  }
  
  
  ///删除数据
  static Future<int> delete({{{entityName}}} entity) async {
        DBManager dbManager = DBManager();
        return await dbManager.db.delete("{{{tableName}}}", where: '{{{primary}}} = ?', whereArgs: [entity.{{{primary}}}]);
  }
  
  
  ///map转为entity
  static {{{entityName}}} _formMap(Map map){
         {{{formMap}}}
  }
  
  ///entity转为map
  static Map _toMap({{{entityName}}} entity){
         {{{toMap}}}
  
  }
  
  
}
""";

const String instanceCreatedTpl = """
""";
