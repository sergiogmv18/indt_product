import 'package:get_it/get_it.dart';
import 'package:indt_products/database/database.dart';
import 'package:indt_products/services/session.dart';

GetIt serviceLocator = GetIt.instance;

/*
  * Register global instance of session and database
  * @author  SGV
  * @version 1.0 - 20231004 - initial release
  * @return  void
  */
Future<void> setupLocator() async {
  if (!serviceLocator.isRegistered<IndtProductsDataBase>()) {
    IndtProductsDataBase databaseInstance = await $FloorIndtProductsDataBase.databaseBuilder('intd_database.db').build();
    serviceLocator.registerSingleton<IndtProductsDataBase>(databaseInstance);
  }
  if (!serviceLocator.isRegistered<Session>()) {
    Session session = Session();
    serviceLocator.registerSingleton<Session>(session);
  }
  await startSession();
}

/*
  * set data session
  * @author  SGV
  * @version 1.0 - 20231004 - initial release
  * @return  void
  */
Future startSession() async {
  List allProducts = await serviceLocator<IndtProductsDataBase>().productDao.fetchAll();
  serviceLocator<Session>().setValue('productsSaved', allProducts);
}