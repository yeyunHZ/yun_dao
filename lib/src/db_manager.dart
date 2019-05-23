import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

///数据库管理类
class DBManager {
  ///数据库连接
  Database _db;

  Database get db => _db;

  ///单例
  static DBManager _instance;

  static DBManager _getInstance() {
    if (_instance == null) {
      _instance = new DBManager._internal();
    }
    return _instance;
  }

  DBManager._internal() {}

  ///创建单例的数据库管理
  factory DBManager() => _getInstance();

  ///数据库版本号
  int _version;

  int get version => _version;

  ///数据库文件路径
  String _dbPath;

  String get dbPath => _dbPath;

  ///数据库名称
  String _dbName;

  String get dbName => _dbName;

  ///初始化数据库
  void initByPath(int version, String dbPath, String dbName) async {
    this._version = version;
    this._dbPath = dbPath;
    this._dbName = dbName;
    var databasesPath = await _createNewDb(dbName, dbPath);
    _db = await openDatabase(databasesPath, version: version);
  }

  void init(int version, String dbName) async {
    var dbPath = await getDatabasesPath();
    initByPath(version, dbPath, dbName);
  }

  Future<String> _createNewDb(String dbName, String dbPath) async {
    String path = join(dbPath, dbName);
    if (await new Directory(dirname(path)).exists()) {
    } else {
      try {
        await new Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        print(e);
      }
    }
    return path;
  }

  void close() {
    db.close();
  }
}
