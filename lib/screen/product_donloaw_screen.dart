

import 'package:flutter/material.dart';
import 'package:indt_products/components/app_bar_custom.dart';
import 'package:indt_products/components/circular_progress_indicator.dart';
import 'package:indt_products/controllers/product_controller.dart';
import 'package:indt_products/controllers/translate_controller.dart';
import 'package:indt_products/database/database.dart';
import 'package:indt_products/services/service_locator.dart';
import 'package:indt_products/style.dart';

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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor:CustomColors.frontColor,
        appBar:appBarCustom(context, ),
        body:FutureBuilder(
          future:   serviceLocator<IndtProductsDataBase>().productDao.fetchAll(),
          builder: (context, app){
            if(app.connectionState == ConnectionState.done){
              return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 30),
                  itemCount: app.data!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child:Card(
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ProductController.getImgProduct(context, url: app.data![index]!.getThumbnail()!, width: 50, height: 50),
                              GestureDetector(
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.65,
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                       app.data![index]!.getTitle()!,
                                        style:Theme.of(context).textTheme.titleMedium,
                                      ),
                                      Text(
                                        translate('see details'),
                                        style:Theme.of(context).textTheme.titleLarge!.copyWith(color: CustomColors.activeButtonColor),
                                      ),
                                    ]
                                  )
                                ),
                                onTap: (){
                                  Navigator.of(context).pushNamedAndRemoveUntil('/product', (route) => false, arguments:app.data![index]!);
                                },
                              ),
                              IconButton(
                                onPressed:()async{
                                  showCircularLoadingDialog(context);
                                  await ProductController().delete(productWk:app.data![index]!);
                                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false, arguments: app.data![index]!);
                                }, 
                                icon: const Icon(Icons.delete)
                              )
                            ],
                          ),
                        )
                    );
                  }
                );
            }
            if(app.hasError){
             return showMessageUser();
            }
            return circularProgressIndicator(context);
          }
        )
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
            translate('product list is empty, please update'),
            style:Theme.of(context).textTheme.titleLarge!
          ),
           IconButton(
            onPressed:()async{
              showCircularLoadingDialog(context);
              await ProductController().getProductsOfServer();
              Navigator.of(context).pop();
            }, 
            icon:const Icon(Icons.replay_outlined) 
          )
        ],
      )
    );
  }
}