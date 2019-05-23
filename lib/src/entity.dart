///数据库表的注解
class Entity {
  ///表名注解
  final String nameInDb;
  final List<Property> propertyList;

  const Entity({this.nameInDb, this.propertyList});

  @override
  String toString() => 'Entity';
}

///属性model
class Property {
  ///属性名
  final String name;

  ///属性类型
  final PropertyType type;

  ///是否是主键
  final bool isPrimary;

  const Property({this.name, this.type, this.isPrimary});

  @override
  String toString() => "Property";

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
        name: json['name'] as String,
        type: PropertyType.fromJson(json['type'] as Map<String, dynamic>),
        isPrimary: json['isPrimary'] as bool);
  }

  Map<String, dynamic> toJson() =>
      {'name': name, 'type': type, 'isPrimary': isPrimary};
}

///数据类型
class PropertyType {
  final String value;

  const PropertyType({this.value});

  @override
  String toString() => "PropertyType";

  factory PropertyType.fromJson(Map<String, dynamic> json) {
    return PropertyType(value: json['value']);
  }

  Map<String, dynamic> toJson() => {'value': value};

  static const PropertyType INT = PropertyType(value: "INT"),
      STRING = PropertyType(value: "TEXT"),
      DOUBLE = PropertyType(value: "REAL");
}
