import 'package:authenticationfire/model/ProductModel.dart';
import 'package:authenticationfire/utils/apiUrl/AppUrl.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';

class ProductRepo {
  BaseApiServices _apiServices = NetworkApiServices();

  Future<ProductModel> featch_productModel() async {
    try {
      dynamic response = await _apiServices.getGetApiServices(
        AppUrl.productUrl,
      );
      return response = ProductModel.fromJson(response);
    } catch (e) {
      throw e.toString();
    }
  }
}
