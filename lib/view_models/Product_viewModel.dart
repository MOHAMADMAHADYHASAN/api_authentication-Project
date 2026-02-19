import 'package:authenticationfire/model/ProductModel.dart';
import 'package:authenticationfire/repository/Product_Repo.dart';
import 'package:authenticationfire/data/response/api_response.dart';
import 'package:flutter/material.dart';

class ProductViewModel with ChangeNotifier {
  final _myRepo = ProductRepo();

  // Alll data here
  ApiResponse<ProductModel> productList = ApiResponse.loading();

  // ডাটা সেট করার ফাংশন এবং UI আপডেট করা
  void setProductList(ApiResponse<ProductModel> response) {
    productList = response;
    notifyListeners();
  }

  // API কল করার ফাংশন
  Future<void> fetchProductListApi() async {
    // প্রথমে লোডিং দেখাবো
    setProductList(ApiResponse.loading());

    _myRepo.featch_productModel().then((value) {
      // সফল হলে ডাটা সেট করবো
      setProductList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      // এরর হলে মেসেজ দেখাবো
      setProductList(ApiResponse.error(error.toString()));
    });
  }
}