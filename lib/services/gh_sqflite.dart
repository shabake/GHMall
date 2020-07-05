import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

String dbPath = "";

/// 数据库名称
String dbName = "user.db";

/// 用户表
String userTable = "user";

/// 用户表SQL
String userTableSQL =
    "create table user (id integer primary key, objectId text, username text,mobilePhone text)";

class GHSqflite {
  /// 判断表是否存在
  Future<List> isTableExits(String tableName) async {
    await getDatabasesPath();
    Database db = await openDatabase(dbPath);
    var res = await db.rawQuery(
        "select * from Sqlite_master where type = 'table' and name = '$tableName'");
    return res;
  }

  /// 创建数据库
  create() async {
    dbPath = await createNewDb(dbName);
    Database db = await openDatabase(dbPath);
    await this.isTableExits("user").then((value) {
      if (value.length == 0) {
        db.execute(userTableSQL);
      }
      db.close();
    });
  }

  /// 打开数据库
  open() async {
    if (null == dbPath) {
      var path = await getDatabasesPath();
      dbPath = join(path, dbName);
      print('dbPath:' + dbPath);
    }
    return await openDatabase(dbPath);
  }

  /// 创建数据库
  Future<String> createNewDb(String dbName) async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, dbName);
    if (await new Directory(dirname(path)).exists()) {
      print("存在数据库");
    } else {
      try {
        await new Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        print(e);
      }
    }
    return path;
  }

  /// 添加数据
  add(String objectId, String username, String mobilePhone) async {
    Database db = await open();
    String sql =
        "insert into user(objectId,username,mobilePhone) values('$objectId', '$username','$mobilePhone')";
    await db.transaction((txn) async {
      int id = await txn.rawInsert(sql);
      print('插入数据成功');
    });
    await db.close();
  }

  /// 查询所有数据
  Future<List> query() async {
    Database db = await open();
    List<Map> list = await db.rawQuery("select * from user");
    await db.close();
    return list;
  }

  /// 根据id删除指定数据
  delete(Map info) async {
    var id = info["id"];
    Database db = await open();
    String sql = "DELETE FROM user where id = $id";
    await db.rawDelete(sql);
    await db.close();
    print('删除数据成功');
  }

  /// 更新数据
  update(int id, String account, String pwd) async {
    Database db = await open();
    String sql = "Update user set password = ?, username = ? where id = ?";
    int count = await db.rawUpdate(sql, [pwd, account, id]);
    await db.close();
    print('更新数据成功');
  }

  /// 删除当前表所有数据
  Future deletedAllData() async {
    Database db = await open();
    int count = await db.delete("user");
    await db.close();
    print('删除数据成功');
  }
}
