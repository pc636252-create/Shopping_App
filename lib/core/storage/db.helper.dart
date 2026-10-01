import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper getInstance = DBHelper._();
/// Product table
  static const String TABLE_CART = "cart";

  static const String COLUMN_ID = "id";
  static const String COLUMN_TITLE = "title";
  static const String COLUMN_PRICE = "price";
  static const String COLUMN_DESC = "description";
  static const String COLUMN_CATEGORY = "category";
  static const String COLUMN_IMAGE = "image";
  static const String COLUMN_QTY = "qty";

  /// Wine table
  static const String TABLE_WINE_CART = "wine_cart";

  static const String COLUMN_WINE_ID = "wine_id"; // wine name used as key
  static const String COLUMN_WINE_NAME = "wine";
  static const String COLUMN_WINERY = "winery";
  static const String COLUMN_RATING = "rating";
  static const String COLUMN_WINE_IMAGE = "image";
  static const String COLUMN_WINE_QTY = "qty";


  Database? myDB;

  Future<Database> getDB() async {
    myDB ??= await openDB();
    return myDB!;
  }

  Future<Database> openDB() async {
    Directory appPath = await getApplicationDocumentsDirectory();
    String dbPath = join(appPath.path, "Product.db");
    return await openDatabase(
      dbPath,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $TABLE_CART (
            $COLUMN_ID INTEGER PRIMARY KEY,
            $COLUMN_TITLE TEXT,
            $COLUMN_PRICE REAL,
            $COLUMN_DESC TEXT,
            $COLUMN_CATEGORY TEXT,
            $COLUMN_IMAGE TEXT,
            $COLUMN_QTY INTEGER DEFAULT 1
          )
        ''');

        await db.execute('''
          CREATE TABLE $TABLE_WINE_CART (
            $COLUMN_WINE_ID TEXT PRIMARY KEY,
            $COLUMN_WINE_NAME TEXT,
            $COLUMN_WINERY TEXT,
            $COLUMN_RATING REAL,
            $COLUMN_WINE_IMAGE TEXT,
            $COLUMN_WINE_QTY INTEGER DEFAULT 1
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS $TABLE_WINE_CART (
              $COLUMN_WINE_ID TEXT PRIMARY KEY,
              $COLUMN_WINE_NAME TEXT,
              $COLUMN_WINERY TEXT,
              $COLUMN_RATING REAL,
              $COLUMN_WINE_IMAGE TEXT,
              $COLUMN_WINE_QTY INTEGER DEFAULT 1
            )
          ''');
        }
      },
      version: 2,
    );
  }

  Future<void> addToCartDB(Map<String, dynamic> product) async {
    var db = await getDB();

    final existing = await db.query(
      TABLE_CART,
      where: '$COLUMN_ID = ?',
      whereArgs: [product[COLUMN_ID]],
    );

    if (existing.isNotEmpty) {
      int currentQty = existing.first[COLUMN_QTY] as int? ?? 1;
      await db.update(
        TABLE_CART,
        {COLUMN_QTY: currentQty + 1},
        where: '$COLUMN_ID = ?',
        whereArgs: [product[COLUMN_ID]],
      );
    } else {
      final data = {
        COLUMN_ID: product[COLUMN_ID],
        COLUMN_TITLE: product[COLUMN_TITLE],
        COLUMN_PRICE: product[COLUMN_PRICE],
        COLUMN_DESC: product[COLUMN_DESC],
        COLUMN_CATEGORY: product[COLUMN_CATEGORY],
        COLUMN_IMAGE: product[COLUMN_IMAGE],
        COLUMN_QTY: 1,
      };
      await db.insert(TABLE_CART, data);
    }
  }

  Future<List<Map<String, dynamic>>> getAllCartItems() async {
    var db = await getDB();
    return await db.query(TABLE_CART);
  }

  Future<void> updateCartQty(dynamic id, int qty) async {
    var db = await getDB();
    await db.update(
      TABLE_CART,
      {COLUMN_QTY: qty},
      where: '$COLUMN_ID = ?',
      whereArgs: [id],
    );
  }

  Future<void> removeFromCartDB(dynamic id) async {
    var db = await getDB();
    await db.delete(TABLE_CART, where: '$COLUMN_ID = ?', whereArgs: [id]);
  }

  Future<void> clearCartDB() async {
    var db = await getDB();
    await db.delete(TABLE_CART);
  }

/// Wine db methods
  Future<void> addToWineCartDB(Map<String, dynamic> wine) async {
    var db = await getDB();
    final wineId = wine[COLUMN_WINE_NAME].toString(); // no real id in wine JSON, name as key

    final existing = await db.query(
      TABLE_WINE_CART,
      where: '$COLUMN_WINE_ID = ?',
      whereArgs: [wineId],
    );

    if (existing.isNotEmpty) {
      int currentQty = existing.first[COLUMN_WINE_QTY] as int? ?? 1;
      await db.update(
        TABLE_WINE_CART,
        {COLUMN_WINE_QTY: currentQty + 1},
        where: '$COLUMN_WINE_ID = ?',
        whereArgs: [wineId],
      );
    } else {
      final data = {
        COLUMN_WINE_ID: wineId,
        COLUMN_WINE_NAME: wine[COLUMN_WINE_NAME],
        COLUMN_WINERY: wine[COLUMN_WINERY],
        COLUMN_RATING: wine[COLUMN_RATING],
        COLUMN_WINE_IMAGE: wine[COLUMN_WINE_IMAGE],
        COLUMN_WINE_QTY: 1,
      };
      await db.insert(TABLE_WINE_CART, data);
    }
  }

  Future<List<Map<String, dynamic>>> getAllWineCartItems() async {
    var db = await getDB();
    return await db.query(TABLE_WINE_CART);
  }

  Future<void> updateWineCartQty(String wineId, int qty) async {
    var db = await getDB();
    await db.update(
      TABLE_WINE_CART,
      {COLUMN_WINE_QTY: qty},
      where: '$COLUMN_WINE_ID = ?',
      whereArgs: [wineId],
    );
  }

  Future<void> removeFromWineCartDB(String wineId) async {
    var db = await getDB();
    await db.delete(TABLE_WINE_CART, where: '$COLUMN_WINE_ID = ?', whereArgs: [wineId]);
  }

  Future<void> clearWineCartDB() async {
    var db = await getDB();
    await db.delete(TABLE_WINE_CART);
  }
}