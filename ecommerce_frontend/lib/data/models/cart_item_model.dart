import 'package:ecommerce_mobile_app/data/models/product_model.dart';

class CartItemModel {
  late ProductModel product;
  late int quantity;
  String? sId;

  CartItemModel({required this.product, required this.quantity, this.sId});

  CartItemModel.fromJson(Map<String, dynamic> json) {
    product =
       // json['product'] != null ? 
        ProductModel.fromJson(json['product']);
       //  : null;
    quantity = json['quantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson({bool isWholeProduct = false}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    //if (product != null) {
      data['product'] = isWholeProduct ? product.sId : product;
    //}
    data['quantity'] = quantity;
    data['_id'] = sId;
    return data;
  }
}
