import 'dart:io';

import 'package:Store/db/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:intl/intl.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance; // Singleton Database

  String productTable = 'Product_Table';
  String colProductNum = 'produtNum';
  String colProductId = 'productId';
  String colProductName = 'productName';
  String colManufactureName = 'manufactureName';
  String colModel = 'model';
  String colSize = 'size';
  String colPrice = 'price';
  String colDescription = 'description';
  String colInStock = 'inStock';
  String colPicture1 = 'picture1';
  String colPicture2 = 'picture2';
  String colPicture3 = 'picture3';

  static Database _db;
  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'products.db';

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $productTable($colProductNum INTEGER PRIMARY KEY AUTOINCREMENT,$colProductId INTEGER ,$colProductName TEXT,$colManufactureName TEXT,$colModel TEXT,$colSize TEXT,$colPrice INTEGER,$colDescription TEXT,$colInStock INTEGER,$colPicture1 STRING, $colPicture2 STRING, $colPicture3 STRING)');
  }

  Future<int> saveProduct(Product model) async {
    var dbClient = await db;
    var result = await dbClient.insert(productTable, model.toMap());
//    var result = await dbClient.rawInsert(
//        'INSERT INTO $tableNote ($columnTitle, $columnDescription) VALUES (\'${note.title}\', \'${note.description}\')');

    return result;
  }

  Future<List> getAllProducts() async {
    var dbClient = await db;
    var result = await dbClient.query(productTable, columns: [
      colProductNum,
      colProductId,
      colProductName,
      colManufactureName,
      colModel,
      colSize,
      colPrice,
      colDescription,
      colInStock,
      colPicture1,
      colPicture2,
      colPicture3
    ]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote');

    return result.toList();
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
