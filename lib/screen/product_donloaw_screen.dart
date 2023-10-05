

import 'package:flutter/material.dart';
import 'package:indt_products/components/app_bar_custom.dart';
import 'package:indt_products/components/circular_progress_indicator.dart';
import 'package:indt_products/controllers/navigator_controller.dart';
import 'package:indt_products/controllers/product_controller.dart';
import 'package:indt_products/controllers/translate_controller.dart';
import 'package:indt_products/services/service_locator.dart';
import 'package:indt_products/services/session.dart';
import 'package:indt_products/style.dart';
import 'package:provider/provider.dart';

class DownloadedProductstScreen extends StatefulWidget {
 const  DownloadedProductstScreen({super.key});
  @override
  State<DownloadedProductstScreen> createState() => _DownloadedProductstScreenState();
}
class _DownloadedProductstScreenState extends State<DownloadedProductstScreen> {
  @override
  void initState() { 
    super.initState();
  }  
  @override
  Widget build(BuildContext context) {
    final allProductsSaved = Provider.of<ProductController>(context).allProductSaved;
    return WillPopScope(
      onWillPop: () => NavigatorContoller().onWillPop(context,backToScreen: true, routeName: '/'),
      child: Scaffold(
        backgroundColor:CustomColors.frontColor,
        appBar:appBarCustom(
          context,
          showButtonReturn: true,
          onPressed: (){
            Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);                            
          }
        ),
        body: allProductsSaved.isNotEmpty ? Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child:Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              alignment:WrapAlignment.center,
              children: List.generate(allProductsSaved.length, (index) {
                return Card(
                  color: CustomColors.frontColor,
                  elevation: 4,
                  child:Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child:Column(
                      children: [
                        ProductController.getImgProduct(context, url: allProductsSaved[index]!.getThumbnail()!, width: MediaQuery.of(context).size.width * 0.45, height: MediaQuery.of(context).size.width * 0.40),
                        const SizedBox(height: 10),
                        Text(
                          allProductsSaved[index]!.getTitle()!,
                          style:Theme.of(context).textTheme.titleMedium,
                          maxLines: 1,
                          overflow:TextOverflow.ellipsis,
                        ),
                        Text(
                          allProductsSaved[index]!.getPrice().toString(),
                          style:Theme.of(context).textTheme.titleMedium!.copyWith(color: CustomColors.activeButtonColor),
                          maxLines: 1,
                          overflow:TextOverflow.ellipsis,
                        ), 
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed:(){
                                Navigator.of(context).pushNamedAndRemoveUntil('/product', (route) => false, arguments: allProductsSaved[index]);
                              }, 
                              child:Text(
                                translate('see details'),
                                style:Theme.of(context).textTheme.titleSmall!.copyWith(color: CustomColors.activeButtonColor),
                              ),
                            ),
                            IconButton(
                              onPressed:()async{
                                showCircularLoadingDialog(context);
                                await ProductController().delete(productWk:allProductsSaved[index]!);
                                Provider.of<ProductController>(context, listen: false).productsSaved = serviceLocator<Session>().getValue('productsSaved');
                                Navigator.of(context).pop();
                              }, 
                              icon: const Icon(Icons.delete)
                            )
                          ],
                        )
                      ],
                    )
                  )
                );
              }),
            ),
          )
        ) :showMessageUser()
      )
    );
  }


  /*
  * show widget case product list is empty 
  * @author SGV
  * @version 1.0 - 20231004 - initial release
  * @return  void
  */
  showMessageUser(){
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child:Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            translate('list of saved products is empty, go back to the previous page see the products, and save the one that is most interesting to you'),
            style:Theme.of(context).textTheme.titleLarge!
          ),
           IconButton(
            onPressed:(){
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);   
            }, 
            icon:const Icon(Icons.arrow_circle_left),
            iconSize: 60,
          )
        ],
      )
    );
  }
}