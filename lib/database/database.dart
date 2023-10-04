// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:indt_products/dao/product_dao.dart';
import 'package:indt_products/models/product.dart';
import 'package:indt_products/services/date_time_converter.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@TypeConverters([DateTimeConverter])
@Database(entities: [
  Product,
], version: 1)
abstract class IndtProductsDataBase extends FloorDatabase {
  ProductDao get productDao;
}
