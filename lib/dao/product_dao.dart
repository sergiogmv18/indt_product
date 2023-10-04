
import 'package:floor/floor.dart';
import 'package:indt_products/models/product.dart';
import 'reposirory_base_dao.dart';

@dao
abstract class ProductDao extends ReposiroryBaseDao<Product> {
  @Query('SELECT * FROM Product')
  Future<List<Product?>> fetchAll();
  
}