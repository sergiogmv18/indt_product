import 'package:flutter/material.dart';
import 'package:indt_products/components/app_bar_custom.dart';
import 'package:indt_products/components/circular_progress_indicator.dart';
import 'package:indt_products/controllers/product_controller.dart';
import 'package:indt_products/controllers/translate_controller.dart';
import 'package:indt_products/services/service_locator.dart';
import 'package:indt_products/services/session.dart';
import 'package:indt_products/style.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
 const  HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
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
        drawer: Container(
          width:  MediaQuery.of(context).size.width * 0.45,
          color: CustomColors.disabledColor,
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menú',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.download_done),
            title: Text(translate('download done')),
            onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/downloaded/products', (route) => false);
            },
          ),
         
        ],
      ),
        ),
         
        appBar:appBarCustom(context, showButtonReturn: true, leading:  Builder(
    builder: (BuildContext context) {
      return IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () { Scaffold.of(context).openDrawer(); },
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
    },
  ),),
        body:FutureBuilder(
          future: ProductController().getProductsOfServer(),
          builder: (context, app){
            if(app.connectionState == ConnectionState.done){
              if(app.data!['success']){
                List  allProducts = app.data!['payload'];
                return Container(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child:Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      alignment:WrapAlignment.center,
                      children: List.generate(allProducts.length, (index) {
                        return Card(
                          color: CustomColors.frontColor,
                          elevation: 4,
                          child:Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child:Column(
                              children: [
                                ProductController.getImgProduct(context, url: allProducts[index].getThumbnail()!, width: MediaQuery.of(context).size.width * 0.45, height: MediaQuery.of(context).size.width * 0.40),
                                const SizedBox(height: 10),
                                Text(
                                  allProducts[index].getTitle()!,
                                  style:Theme.of(context).textTheme.titleMedium,
                                  maxLines: 1,
                                  overflow:TextOverflow.ellipsis,
                                ),
                                Text(
                                  allProducts[index].getPrice().toString(),
                                  style:Theme.of(context).textTheme.titleMedium!.copyWith(color: CustomColors.activeButtonColor),
                                  maxLines: 1,
                                  overflow:TextOverflow.ellipsis,
                                ), 
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed:(){
                                        Navigator.of(context).pushNamedAndRemoveUntil('/product', (route) => false, arguments: allProducts[index]);
                                      }, 
                                      child:Text(
                                        translate('see details'),
                                        style:Theme.of(context).textTheme.titleSmall!.copyWith(color: CustomColors.activeButtonColor),
                                      ),
                                    ),
                                    StatefulBuilder(builder:(BuildContext context, StateSetter setState) {
                                      return ProductController.productIsSaved(allProducts[index].getServerId()) ?  const Icon(Icons.check) : 
                                      IconButton(
                                        onPressed:()async{
                                          showCircularLoadingDialog(context);
                                          await ProductController().save(productWk:allProducts[index]);
                                          Provider.of<ProductController>(context, listen: false).productsSaved = serviceLocator<Session>().getValue('productsSaved');
                                          Navigator.of(context).pop();
                                          setState(() {});
                                        }, 
                                        icon: const Icon(Icons.download)
                                      );
                                    })
                                  ],
                                )
                              ],
                            )
                          )
                        );
                      }),
                    ),
                  )
                );
              }
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