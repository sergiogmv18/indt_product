import 'package:flutter/material.dart';
import 'package:indt_products/controllers/product_controller.dart';
import 'package:indt_products/controllers/translate_controller.dart';
import 'package:indt_products/indt_products.dart';
import 'package:indt_products/services/service_locator.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: TranslateController.getInstance(),
        ),
        ChangeNotifierProvider<ProductController>(create: (_) => ProductController()),
      ],
      child: const IndtProducts(),
    )
  );
}