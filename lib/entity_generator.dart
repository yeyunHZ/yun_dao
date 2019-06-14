import 'dart:convert';
import 'package:build/build.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:mustache4dart/mustache4dart.dart';
import 'package:source_gen/source_gen.dart';
import 'package:yun_dao/entity.dart';

import 'package:yun_dao/template.dart';

///代码生成
class EntityGenerator extends GeneratorForAnnotation<Entity> {
  BuilderOptions options;

  EntityGenerator(this.options) : super();

  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    // TODO: implement generateForAnnotatedElement
    String className = element.name + "Dao";
    ConstantReader propertyListConstantReader = annotation.peek('propertyList');
    List<DartObject> dartList = propertyListConstantReader.listValue;
    List<Property> propertyList = List();
    final Function addProperty = (DartObject propertyDartObject) {
      final ConstantReader propertyConstantReader =
          ConstantReader(propertyDartObject);
      String name = propertyConstantReader.peek("name")?.stringValue;
      ConstantReader typeConstantReader =
          ConstantReader(propertyConstantReader.peek("type").objectValue);
      PropertyType type =
          PropertyType(value: typeConstantReader.peek("value").stringValue);
      bool isPrimary = false;
      if (propertyConstantReader.peek("isPrimary") != null) {
        isPrimary = propertyConstantReader.peek("isPrimary").boolValue;
      }
      Property property =
          Property(name: name, type: type, isPrimary: isPrimary);
      propertyList.add(property);
    };
    dartList.forEach(addProperty);
    String jsonStr = json.encode(propertyList);
    String entityName = element.name;
    String formMap = "$entityName entity = $entityName();";
    String toMap = " var map = Map<String, dynamic>();\n";
    String primary = null;
    String propertyClass = "";
    for (Property property in propertyList) {
      String propertyName = property.name;
      propertyClass = propertyClass +
          "static QueryProperty " +
          propertyName.toUpperCase() +
          " = QueryProperty(name: '$propertyName');\n";

      toMap = toMap + "map['$propertyName'] = entity.$propertyName;\n";
      formMap = formMap + "entity.$propertyName = map['$propertyName'];\n";
      if (property.isPrimary) {
        if (primary == null) {
          primary = propertyName;
        } else {
          throw '$entityName不能拥有两个主键!';
        }
      }
    }
    toMap = toMap + "return map;";
    formMap = formMap + "return entity;";

    String createSql = "";
    for (Property property in propertyList) {
      if (property == propertyList[propertyList.length - 1]) {
        createSql = createSql +
            property.name +
            "  " +
            property.type.value +
            (property.isPrimary ? " PRIMARY KEY" : "");
      } else {
        createSql = createSql +
            property.name +
            "  " +
            property.type.value +
            (property.isPrimary ? " PRIMARY KEY" : "") +
            ",";
      }
    }
    if (primary == null) {
      throw '$entityName必须设置主键!';
    }

    return render(clazzTpl, <String, dynamic>{
      'className': className,
      'entityName': entityName,
      'tableName': annotation.peek("nameInDb")?.stringValue,
      "propertyList": "$jsonStr",
      "source": _getSource(element.source.fullName.substring(1)),
      "toMap": toMap,
      "formMap": formMap,
      "createSql": createSql,
      "primary": primary,
      "propertyClass": propertyClass
    });
  }

  String wK(String key) {
    return "'${key}'";
  }

  ///获取要生成的文件的路径
  String _getSource(String fullName) {
    String source = fullName.replaceAll("/lib", "");
    return source;
  }
}
