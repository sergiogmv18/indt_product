// dao/person_dao.dart
import 'package:floor/floor.dart';
import 'package:indt_products/models/model_base.dart';

abstract class ReposiroryBaseDao<Model extends ModelBase> {
  @insert
  Future<int> insertLocally(Model object);

  @update
  Future<int> updateLocally(Model object);

  @delete
  Future<int> deleteLocally(Model object);

  Future<int> saveLocally(Model object) async {
    if (object.id != null) {
      await updateLocally(object);
      return object.id!;
    }
    int id = await insertLocally(object);
    return id;
  }
}
