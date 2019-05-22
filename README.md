简介
===

一个以注解方式实现的ORM数据库解决方案，基于 source_gen

使用
===
1、创建你的实体类并以*.entity.dart作为文件名,编译后生成的数据库操作文件将以*.entity.table.dart命名 例:



2、使用 ####@Entity 注解你的实体类 例:
`''dart
@Entity()
class StudentEntity{}
