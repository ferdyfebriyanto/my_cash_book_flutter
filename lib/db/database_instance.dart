import 'dart:io';

// Import Model
import 'package:my_cash_book_flutter/models/transaksi_model.dart';
import 'package:my_cash_book_flutter/models/user_model.dart';

// Plugin
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseInstance {
  final String databaseName = "my_cash_book.db";
  final int databaseVersion = 2;

  // Atribut di Model Transaksi
  final String tabel_transaksi = 'transaksi';
  final String id = 'id';
  final String type = 'type';
  final String total = 'total';
  final String name = 'name';
  final String createdAt = 'created_at';
  final String updatedAt = 'updated_at';

  // Atribut di Model User
  final String tabel_user = 'user';
  final String id_user = 'id';
  final String username = 'username';
  final String password = 'password';
  final String created_at = 'created_at';
  final String updated_at = 'updated_at';

  Database? _database;
  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory databaseDirectory = await getApplicationDocumentsDirectory();
    String path = join(databaseDirectory.path, databaseName);
    print('database init');
    return openDatabase(path, version: databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE ${tabel_transaksi} ($id INTEGER PRIMARY KEY, $name TEXT NULL, $type INTEGER, $total INTEGER, $createdAt TEXT NULL, $updatedAt TEXT NULL)');
    'CREATE TABLE ${tabel_user} ($id_user INTEGER PRIMARY KEY, $username TEXT NULL, $password TEXT NULL, $created_at TEXT NULL, $updated_at TEXT NULL)';
  }

  Future<List<TransaksiModel>> getAll() async {
    final data = await _database!.query(tabel_transaksi);
    List<TransaksiModel> result =
        data.map((e) => TransaksiModel.fromJson(e)).toList();
    return result;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    final query = await _database!.insert(tabel_transaksi, row);
    return query;
  }

  Future<int> totalPemasukan() async {
    final query = await _database!.rawQuery(
        "SELECT SUM(total) as total FROM ${tabel_transaksi} WHERE type = 1");
    return int.parse(query.first['total'].toString());
  }

  Future<int> totalPengeluaran() async {
    final query = await _database!.rawQuery(
        "SELECT SUM(total) as total FROM ${tabel_transaksi} WHERE type = 2");
    return int.parse(query.first['total'].toString());
  }

  Future<int> hapus(idTransaksi) async {
    final query = await _database!
        .delete(tabel_transaksi, where: '$id = ?', whereArgs: [idTransaksi]);

    return query;
  }

  Future<int> update(int idTransaksi, Map<String, dynamic> row) async {
    final query = await _database!.update(tabel_transaksi, row,
        where: '$id = ?', whereArgs: [idTransaksi]);
    return query;
  }

  // Future<int> insertUser(Map<String, dynamic> row) async {
  //   final query = await _database!.insert(tabel_user, row);
  //   return query;
  // }

  // _insertUser() async {
  //   await insertUser({
  //     'username': 'admin',
  //     'password': '123456',
  //     'created_at': DateTime.now().toString(),
  //     'updated_at': DateTime.now().toString()
  //   });
  // }

  // Future<int> updateUser(int idUser, Map<String, dynamic> row) async {
  //   final query = await _database!
  //       .update(tabel_user, row, where: '$id_user = ?', whereArgs: [idUser]);
  //   return query;
  // }
}
