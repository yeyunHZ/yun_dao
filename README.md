简介
===

一个以注解方式实现的ORM数据库解决方案，基于 source_gen

使用
===
1、创建你的实体类并以*.entity.dart作为文件名,编译后生成的数据库操作文件将以*.entity.table.dart命名 例:



2、使用 **@Entity** 注解你的 **实体类** ,并且 **nameInDb**属性来定义其在数据库中的表名 **propertyList** 的类型为List,通过他来定义表中的字段 以例:
```Dart
@Entity(nameInDb:'student',propertyList:[Property(name:'name',type:PropertyType.STRING)])
class StudentEntity{}
```

3、实体类必须拥有主键,并在 **@Property** 注解中通过 **isPrimary=true** 来声明这个属性为主键
```Dart
@Entity(nameInDb:'student',
        propertyList:[
              Property(name:'name',type:PropertyType.STRING),
              Property(name:'id',type:PropertyType.INT,isPrimary:true),
              ])
class StudentEntity{}
```
