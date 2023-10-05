import 'package:flutter/material.dart';
import 'package:indt_products/components/alert_custom.dart';
import 'package:indt_products/components/circular_progress_indicator.dart';
import 'package:indt_products/controllers/product_controller.dart';
import 'package:indt_products/controllers/translate_controller.dart';
import 'package:indt_products/services/service_locator.dart';
import 'package:indt_products/services/session.dart';
import 'package:indt_products/style.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';

class SidebarCustom extends StatelessWidget {
  const SidebarCustom({ Key? key,required SidebarXController controller,})  : _controller = controller, super(key: key);
  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color:CustomColors.disabledColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: CustomColors.disabledColor ,
        textStyle: TextStyle(color: CustomColors.backgroundColorDark),
        selectedTextStyle: TextStyle(color: CustomColors.frontColor, fontWeight: FontWeight.bold),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color:CustomColors.frontColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: CustomColors.frontColor
          ),
          
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: CustomColors.backgroundColorDark,
          size: 20,
        ),
        selectedIconTheme: IconThemeData(
          color: CustomColors.frontColor,
          size: 20,
        ),
      ),
      extendedTheme: SidebarXTheme(
        width: MediaQuery.of(context).size.width * 0.45,
        decoration: BoxDecoration(
          color: CustomColors.disabledColor,
        ),
      ),
    // footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: Image.asset('assets/logo.png', width:  MediaQuery.of(context).size.width * 0.23),
          ),
        );
      },
      items:[
        SidebarXItem(
        icon: Icons.download_done,
        label: translate('downloads'),
        onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil('/downloaded/products', (route) => false);
          },
        ),
         SidebarXItem(
          icon:Icons.download,  
          label: translate('download all'),
          onTap: ()async{
            showCircularLoadingDialog(context);
            Map<String, dynamic> response = await ProductController().saveAllProducts();
            if(!response['success']){
              return showMessageErrorServer(
                context, 
                errorServer: response['error'],
                onPressed: (){
                   Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                }
              );
            }
          Provider.of<ProductController>(context, listen: false).productsSaved = serviceLocator<Session>().getValue('productsSaved');
           Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);

          },
        ), 
        
      ],
    );
  }
}