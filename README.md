
[中文版](https://github.com/yeyunHZ/yun_dao/blob/master/README_CH.md)
===

Introduction
===

It is an ORM database solution by annotation method which is based on source_gen

Usage
===
1.Create entity file which names `*_entity.dart`,then will generate database operation file which names `*.entity.dao.dart` after compilation.

```Dart
entity file:     student_entity.dart
generated databse file :   student_entity.dao.dart
```

2.Use `@Entity` to annotate **entity class**; use `nameInDb` property to define the database table name of entity class; use `propertyList` to define the columns name in table which must be correspond to the property name of the entity class.And the type of `propertyList` is `List` 


```Dart
@Entity(nameInDb:'student',propertyList:[Property(name:'name',type:PropertyType.STRING)])
class StudentEntity{
   String name;
}
```

3.Entity class must has primary key, and define the property as primary key by the code `isPrimary=true` in `@Property` annotation

```Dart
@Entity(nameInDb:'student',
        propertyList:[
              Property(name:'name',type:PropertyType.STRING),
              Property(name:'id',type:PropertyType.INT,isPrimary:true),
              ])
class StudentEntity{
      String name;
      int id;
}
```

4.Using the command to create database operation file in the command-line: 

```
flutter packages pub run build_runner build
```

5.The gennereated databse operation file includes the CURD methods after compilation.And you should init database when use in project

```Dart
///import database manager class
import 'package:yun_dao/db_manager.dart';

///pass the params include vesion,path,name to init databse. DBManager is a singleton
DBManager dBManager = DBManager();
dBManager.initByPath(1,“dbPath”,"dbName");

///you can also use default path to init database.The method to get default path is `getDatabasesPath()`
dBManager.init(1,"dbName");
```

6.Call the method `init()` of genearated database operation file to create a table in project.However,the method would judge whether create a new table.Then you can don't be afraid of creating repeated tables.

```Dart
StudentEntityDao.init();
```

7.Next,it's convenient to execute CURD operation in databse.And the all operation methods is static.

```Dart
StudentEntityTable.queryAll();
StudentEntityTable.insert(StudentEntity());
```

8.Also you can select data by query builder

```Dart
List list = await StudentEntityDao.queryBuild()
        .where(StudentEntityDao.NAME.equal("李四"))
        .where(StudentEntityDao.AGE.equal(2))
        .list();
```



Install
===

      dev_dependencies:
          yun_dao: 0.0.3
          

[Example](https://github.com/yeyunHZ/yun_dao_test)
===



