简介
===

一个以注解方式实现的ORM数据库解决方案，基于 source_gen

使用
===
1、创建你的实体类并以*_entity.dart作为文件名,编译后生成的数据库操作文件将以*.entity.dao.dart命名 例:
```Dart
你的实体类文件:               student_entity.dart
编译后生成的数据库操作类文件:   student_entity.dao.dart
```


2、使用 **@Entity** 注解你的 **实体类** ,并且 **nameInDb**属性来定义其在数据库中的表名。
   **propertyList** 的类型为List,通过他来定义表中的字段 
   **注意**表中字段名,必须与实体类中的属性名一一对应

例:
```Dart
@Entity(nameInDb:'student',propertyList:[Property(name:'name',type:PropertyType.STRING)])
class StudentEntity{
   String name;
}
```

3、实体类必须拥有主键,并在 **@Property** 注解中通过 **isPrimary=true** 来声明这个属性为主键
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

4、通过命令来生成数据库操作文件,在命令行中输入下面的命令
         flutter packages pub run build_runner build


5、编译后生成的数据库操作文件中包含当前表的创建、增删改查等方法,在项目中使用需要先进行数据库的初始化
```Dart
///导入数据库管理类
import 'package:yun_dao/db_manager.dart';

///传入数据库版本、数据库路径以及数据库名称来初始化数据库,DBManager为单例,每次创建拿到的都是同一个
DBManager dBManager = DBManager();
dBManager.initByPath(1,“dbPath”,"dbName");
///你也可以使用默认路径来初始化数据库 默认的路径为 getDatabasesPath()
dBManager.init(1,"dbName");
```


6、在项目中调用生成的数据库操作文件的 **init()** 方法来创建表, **init()** 方法中会做相应的判断不会重复创建表格
```Dart
StudentEntityDao.init();
```


7、然后就可以在项目中方便的进行数据库的增删改查操作了,所有的数据库操作方法都是静态
```Dart
StudentEntityTable.queryAll();
StudentEntityTable.insert(StudentEntity());
```

8、你也可以通过构造查询器来查询数据
```Dart
List list = await StudentEntityDao.queryBuild()
        .where(StudentEntityDao.NAME.equal("李四"))
        .where(StudentEntityDao.AGE.equal(2))
        .list();
```



安装
===

      dev_dependencies:
          yun_dao: 0.0.3
          

[示例代码](https://github.com/yeyunHZ/yun_dao_test)
===






