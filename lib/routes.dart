
import 'package:flutter/material.dart';
import 'package:indt_products/models/product.dart';
import 'package:indt_products/screen/home_screen.dart';
import 'package:indt_products/screen/product_donloaw_screen.dart';
import 'package:indt_products/screen/specific_product_screen.dart';



final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/' : (BuildContext context) => const HomeScreen(),
  '/product': (BuildContext context) => SpecificProductScreen(productWk: ModalRoute.of(context)!.settings.arguments as Product),
  '/downloaded/products': (BuildContext context) => const DownloadedProductstScreen(), 
};