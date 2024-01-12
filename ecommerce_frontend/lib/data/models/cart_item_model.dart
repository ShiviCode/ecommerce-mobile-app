import 'package:ecommerce_mobile_app/data/models/product_model.dart';

class CartItemModel {
  ProductModel? product;
  int? quantity;
  String? sId;

  CartItemModel({this.product, this.quantity, this.sId});

  CartItemModel.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
    quantity = json['quantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (product != null) {
      data['product'] = product!.sId;
    }
    data['quantity'] = quantity;
    data['_id'] = sId;
    return data;
  }
}
