import 'package:flutter/material.dart';
import 'package:indt_products/style.dart';

/*
 * Component of appBar defauld, to be used throughout the app
 * @author  SGV      - 20231004
 * @version 1.0      - 20231004         - initial release
 * @param <bool>     - showButtonReturn - show button to return to the previous page or perform some action
 * @param <bool>     - showactions      - show button action or no
 * @param <Function> - onPressed        - action of button
 * @return  <component> widget
 */
appBarCustom(BuildContext context, {Widget? leading, bool showButtonReturn = false, bool showactions = true, void Function()? onPressed}) {
  return AppBar(
    backgroundColor:CustomColors.disabledColor,
    automaticallyImplyLeading: showButtonReturn,
    leading: showButtonReturn ? leading ?? IconButton(
      onPressed:onPressed, 
      icon:const Icon(Icons.arrow_circle_left), 
      iconSize: 40
    ): null, 
    toolbarHeight: 110,    
    centerTitle: true,
    elevation: 0,
    title:Image.asset(
      'assets/logo_new.png',
      width: 150,
      filterQuality: FilterQuality.high,
    ),
    actions:showactions ? [
      IconButton(
        onPressed:()async{
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false); 
        }, 
        icon:const Icon(Icons.replay_outlined) 
      )
    ]: null,
  );
}