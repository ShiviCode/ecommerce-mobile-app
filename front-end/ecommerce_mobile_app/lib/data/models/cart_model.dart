import 'package:ecommerce_mobile_app/data/models/product_model.dart';

class CartModel {
  ProductModel? product;
  int? quantity;
  String? sId;

  CartModel({this.product, this.quantity, this.sId});

  CartModel.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
    quantity = json['quantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['quantity'] = quantity;
    data['_id'] = sId;
    return data;
  }
}
