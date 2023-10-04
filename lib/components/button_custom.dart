import 'package:flutter/material.dart';

/*
 * Component of button defauld, to be used throughout the app
 * @author  SGV         - 20230217
 * @version 1.0         - 20230217    - initial release
 * @param   <Key>       - Key         - key to know state of component
 * @param   <Function>  - onPressed   - Function to define action of button  
 * @param   <Widget>    - child       - show child of elevatedButton 
 * @param   <Color>     - customColor - define color 
 * @param  <double>     - width       - width of button 
 * @param  <double>     - elevation   - elevarion of button, standard = 1 
 * @return  <component> ElevatedButton
 */
ElevatedButton buttonCustom(BuildContext context, {Key? key, required void Function() onPressed, double ?width,  required Widget child, Color? customCollor, double elevation = 1}) {
  return ElevatedButton(
    key: key,
    clipBehavior: Clip.hardEdge,
    style: ElevatedButton.styleFrom(
      backgroundColor: customCollor,
      elevation: elevation,
     // textStyle: const TextStyle(fontSize: 20),
     // shape: RoundedRectangleBorder(borderRadius: ),
    ),
    onPressed: onPressed,
    child: Container(
      width: width,
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: child,
    ),
  );
}
