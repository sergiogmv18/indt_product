
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:indt_products/components/circular_progress_indicator.dart';
import 'package:indt_products/database/database.dart';
import 'package:indt_products/models/product.dart';
import 'package:indt_products/services/request.dart';
import 'package:indt_products/services/service_locator.dart';
import 'package:indt_products/services/session.dart';

class ProductController{


  /*
  * Get all product of server
  * @author SGV
  * @version 1.0 - 20231004 - initial release
  * @return  void
  */
  Future<Map<String, dynamic>> getProductsOfServer()async{
    Map<String, dynamic> response = await Request().httpGet(url:'https://dummyjson.com/products');
    if(response['success']){
     Map<String, dynamic> listOfAllProduct = jsonDecode(response['payload']);
      List allProducts = await convertJsonInObj(dataJson: listOfAllProduct['products']);
      response['payload'] = allProducts;
    }
    return response;
  }


 /*
  * Convert json in obj Product
  * @author SGV
  * @version 1.0 - 20231004 - initial release
  * @return  void
  */
 Future<List> convertJsonInObj({required List dataJson})async{
  List products = [];
    for(int product = 0; product < dataJson.length; product++){
      Map<String, dynamic> currentProduct = dataJson[product];
      Product productWk = Product();
      productWk.setServerId(currentProduct['id']);
      productWk.setTitle(currentProduct['title']);
      productWk.setDescription(currentProduct['description']);
      productWk.setPrice(double.parse(currentProduct['price'].toString()));
      productWk.setDiscountPercentage(double.parse( currentProduct['discountPercentage'].toString()));
      productWk.setRating(double.parse(currentProduct['rating'].toString()));
      productWk.setStock(int.parse(currentProduct['stock'].toString()));
      productWk.setBrand(currentProduct['brand']);
      productWk.setCategory(currentProduct['category']);
      productWk.setThumbnail(currentProduct['thumbnail']);
      productWk.setImages(currentProduct['images']);
     products.add(productWk);
    }
  return products;
 }



/*
  * save Project
  * @author SGV
  * @version 20230314 initial release 
  * @param <Product> productWk 
  * @return  Widget
  */
  Future<void> save({required Product productWk})async{
    await serviceLocator<IndtProductsDataBase>().productDao.saveLocally(productWk);
    await startSession();
  }


/*
  * save Project
  * @author SGV
  * @version 20230314 initial release 
  * @param <Product> productWk 
  * @return  Widget
  */
  Future<void> delete({required Product productWk})async{
    await serviceLocator<IndtProductsDataBase>().productDao.deleteLocally(productWk);
    await startSession();
  }


 /*
  * check if the product has already been saved
  * @author SGV
  * @version 20230314 initial release 
  * @param <int> serverId 
  * @return  Widget
  */
  static productIsSaved(int serverId){
   List allProducts = serviceLocator<Session>().getValue('Products');
   if(allProducts.isNotEmpty){
      for(Product product in allProducts){
        if(serverId == product.getServerId()){
          return true;
        }
      }
   }
   return false;
  }


 /*
  * get  widget primary img of product
  * @author SGV
  * @version 20230314 initial release 
  * @param <String> logo 
  * @param <double> width
  * @param <double> height
  * @return  Widget
  */
  static getImgProduct(BuildContext context, {required String url, double? width, double? height}) {
    return Image.network(
      url,
      width:width,
      height: height,
      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Image.asset(
          'assets/logo_new.png',
          width:width,
          height: height,
          filterQuality: FilterQuality.high,
        );
      },
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        return child;
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return Center(
            child: circularProgressIndicator(context),
          );
        }
      }
    );
  }

  
}