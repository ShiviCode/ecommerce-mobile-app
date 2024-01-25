import 'package:ecommerce_mobile_app/data/models/cart_item_model.dart';
import 'package:ecommerce_mobile_app/data/models/user_model.dart';

class OrderModel {
  String? sId;
  UserModel? user;
  List<CartItemModel>? items;
  String? status;
  DateTime? updatedOn;
  DateTime? createdOn;

  OrderModel(
      {this.sId,
      this.user,
      this.items,
      this.status,
      this.updatedOn,
      this.createdOn});

  OrderModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    if (json['items'] != null) {
      items = <CartItemModel>[];
      json['items'].forEach((v) {
        items!.add(CartItemModel.fromJson(v));
      });
    }
    status = json['status'];
    updatedOn = DateTime.tryParse(json['updatedOn']);
    createdOn = DateTime.tryParse(json['createdOn']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (items != null) {
      data['items'] =
          items!.map((v) => v.toJson(isWholeProduct: true)).toList();
    }
    data['status'] = status;
    data['updatedOn'] = updatedOn?.toIso8601String();
    data['createdOn'] = createdOn?.toIso8601String();
    return data;
  }
}
