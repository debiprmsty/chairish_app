// import 'package:project_furniture/models/product.dart';
// import 'package:sqflite/sqflite.dart';
// import 'dart:async';

// // ignore: depend_on_referenced_packages
// import 'package:path/path.dart';

// class DatabaseHelper {
//   DatabaseHelper._myConn();
//   static final DatabaseHelper instance = DatabaseHelper._myConn();
//   Database?  _db;

//   String productTable = 'product';
//   String colId = 'id';
//   String colTitle = 'title';
//   String colDesc = 'desc';
//   String colImage = 'image';
//   String colPrice = 'price';

//   Future<Database> get db async {
//     if (_db == null) {
//       _db = await _initDb();
//     }
//     return _db!;
//   }

//   Future<Database> _initDb() async {
//     String dbPath = join(await getDatabasesPath(), 'my_database.db');
//     final database = await openDatabase(dbPath, version: 1, onCreate: _createDb);
//     return database;
//   }

//   void _createDb(Database db, int version) async {
//     await db.execute(
//         'CREATE TABLE $productTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, '
//         '$colTitle TEXT, $colDesc TEXT, $colImage TEXT, $colPrice REAL)');
//   }

//   Future<List<Map<String, dynamic>>> getProductMapList() async {
//     Database db = await this.db;
//     final List<Map<String, dynamic>> result = await db.query(productTable);
//     return result;
//   }

//   Future<int> insertProduct(Product product) async {
//     Database db = await this.db;
//     final int result = await db.insert(productTable, product.toMap());
//     return result;
//   }

//   Future<int> updateProduct(Product product) async {
//     Database db = await this.db;
//     final int result = await db.update(productTable, product.toMap(),
//         where: '$colId = ?', whereArgs: [product.id]);
//     return result;
//   }

//   Future<int> deleteProduct(int id) async {
//     Database db = await this.db;
//     final int result =
//         await db.delete(productTable, where: '$colId = ?', whereArgs: [id]);

//     return result;
//   }

//   Future<List<Product>> getProductList() async {
//     final List<Map<String, dynamic>> productMapList = await getProductMapList();
//     final List<Product> productList = [];
//     productMapList.forEach((productMap) {
//       productList.add(Product.fromMap(productMap));
//     });
//     return productList;
//   }

//   Future<Product> getProductById(int productId) async {
//     Database db = await this.db;
//     final List<Map<String, dynamic>> maps = await db.query(productTable, where: '$colId = ?', whereArgs: [productId]);

//     if (maps.isNotEmpty) {
//       return Product.fromMap(maps.first);
//     }
//     throw Exception('Product not found');
//   }
// }

























// // class DatabaseHelper {
// //   static final DatabaseHelper _databaseHelper = DatabaseHelper._();

// //   DatabaseHelper._();

// //   late Database db;

// //   factory DatabaseHelper() {
// //     return _databaseHelper;
// //   }
// //   Future<void> initDB() async {
// //     String path = await getDatabasesPath();
// //     db = await openDatabase(
// //       join(path, 'products.db'),
// //       onCreate: (database, version) async {
// //         await database.execute(
// //           """
// //             CREATE TABLE products (
// //               id INTEGER PRIMARY KEY AUTOINCREMENT,              
// //               name TEXT NOT NULL,
// //               code TEXT NOT NULL, 
// //               category TEXT NOT NULL, 
// //               description TEXT NOT NULL
// //             )
// //           """,
// //         );
// //       },
// //       version: 1,
// //     );
// //   }

// //   Future<int> insertProduct(Product product) async {
// //     int result = await db.insert('products', product.toMap());
// //     return result;
// //   }

// //   Future<int> updateProduct(Product product) async {
// //     int result = await db.update(
// //       'products',
// //       product.toMap(),
// //       where: "id = ?",
// //       whereArgs: [product.id],
// //     );
// //     return result;
// //   }

// //   Future<List<Product>> retrieveProducts() async {
// //     final List<Map<String, Object?>> queryResult = await db.query('products');
// //     return queryResult.map((e) => Product.fromMap(e)).toList();
// //   }

// //   Future<void> deleteProduct(int id) async {
// //     await db.delete(
// //       'products',
// //       where: "id = ?",
// //       whereArgs: [id],
// //     );
// //   }
// // }