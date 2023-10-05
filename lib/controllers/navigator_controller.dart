import 'package:flutter/material.dart';

class NavigatorContoller{

  /*
  * Activate or not be able to go back to the previous page
  * @author  SGVx
  * @version 20230510 - initial release
  * @param   <bool>   - backToScreen -> true  - redirect to specific routeName  
  *                                  -> false -  does not make changes
  * @param   <String> -[routeName]    -> specific route 
  * @param   <Object> - arguments    -> if the screen needs parameters it is sent in the arguments
  * @return  bool;
  */
  Future<bool> onWillPop(BuildContext context,{ bool backToScreen = false, Object? arguments, String? routeName}) async {
    if (backToScreen) {
      Navigator.pushNamedAndRemoveUntil(context, routeName!, (route) => false, arguments: arguments);
      return backToScreen;
    }

    return backToScreen;
  }

  

}