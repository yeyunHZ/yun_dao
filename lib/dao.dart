///dao的抽象类
abstract class Dao<E> {
  String getTableName();

  E formMap(Map map);

  Map toMap(E entity);
}
