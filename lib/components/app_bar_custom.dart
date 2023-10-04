import 'package:flutter/material.dart';
import 'package:indt_products/components/circular_progress_indicator.dart';
import 'package:indt_products/controllers/product_controller.dart';
import 'package:indt_products/style.dart';

/*
 * Component of appBar defauld, to be used throughout the app
 * @author  SGV - 20231004
 * @version 1.0 - 20231004 - initial release
 * @return  <component> widget
 */
appBarCustom(BuildContext context) {
  return AppBar(
    backgroundColor:CustomColors.activeButtonColor,
    automaticallyImplyLeading: false,
    toolbarHeight: 110,    
    centerTitle: true,
    elevation: 0,
    title:Image.asset(
      'assets/logo_new.png',
      width: 200,
      filterQuality: FilterQuality.high,
    ),
    actions: [
      IconButton(
        onPressed:()async{
          showCircularLoadingDialog(context);
          await ProductController().getProductsOfServer();
          Navigator.of(context).pop();
        }, 
        icon:const Icon(Icons.replay_outlined) 
      )
    ],
  );
}