const String clazzTpl = """
///{{{tableName}}}表
import 'package:yun_dao/db_manager.dart';
import 'package:yun_dao/entity.dart';
import 'package:{{{source}}}';
import 'package:yun_dao/Dao.dart';
import 'package:yun_dao/query.dart';

 class {{{className}}} extends Dao<{{{entityName}}}>{
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
            {{{className}}} entityDao = {{{className}}}();
           List<Map> maps = await dbManager.db.query("{{{tableName}}}")  ;
           for(Map map in maps){
              entityList.add(entityDao.formMap(map));
           }
           return entityList;
  }
  
  
  ///增加一条数据
  static Future<bool> insert({{{entityName}}} entity) async{
       DBManager dbManager = DBManager();
        {{{className}}} entityDao = {{{className}}}();
       await dbManager.db.insert("{{{tableName}}}", entityDao.toMap(entity));
       return true;
  }
  
   ///增加多条条数据
  static Future<bool> insertList(List<{{{entityName}}}> entityList) async{
       DBManager dbManager = DBManager();
       List<Map> maps = List();
       {{{className}}} entityDao = {{{className}}}();
       for({{{entityName}}} entity in entityList){
            maps.add(entityDao.toMap(entity));
       }
       await dbManager.db.rawInsert("{{{tableName}}}", maps);
       return true;
  }
  
  ///更新数据
  static Future<int> update({{{entityName}}} entity) async {
    DBManager dbManager = DBManager();
     {{{className}}} entityDao = {{{className}}}();
    return await dbManager.db.update("{{{tableName}}}", entityDao.toMap(entity),
        where: '{{{primary}}} = ?', whereArgs: [entity.{{{primary}}}]);
  }
  
  
  ///删除数据
  static Future<int> delete({{{entityName}}} entity) async {
        DBManager dbManager = DBManager();
        return await dbManager.db.delete("{{{tableName}}}", where: '{{{primary}}} = ?', whereArgs: [entity.{{{primary}}}]);
  }
  
  
  ///map转为entity
  @override
  {{{entityName}}} formMap(Map map){
         {{{formMap}}}
  }
  
  ///entity转为map
  @override
  Map toMap({{{entityName}}} entity){
         {{{toMap}}}
 
  }
  
  @override
  String getTableName(){
      return "{{{tableName}}}";
  }
  
    {{{propertyClass}}}
  
  static Query queryBuild(){
       Query query = Query({{{className}}}());
       return query;
  }
}

///查询条件生成
class QueryProperty{
      String name;
      QueryProperty({this.name});
      QueryCondition equal(dynamic queryValue){
           QueryCondition queryCondition = QueryCondition();
           queryCondition.key= name;
           queryCondition.value = queryValue;
           return queryCondition;
      }
  }
  

""";

const String instanceCreatedTpl = """
""";
