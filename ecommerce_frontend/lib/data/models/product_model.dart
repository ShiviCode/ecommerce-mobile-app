class ProductModel {
  String? sId;
  late String category;
  late String title;
  late String description;
  late num price;
  late List<String> images;
  String? updatedOn;
  String? createdOn;

  ProductModel(
      {this.sId,
      required this.category,
      required this.title,
      required this.description,
      required this.price,
      required this.images,
      this.updatedOn,
      this.createdOn});

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    category = json['category'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    images = json['images'].cast<String>();
    updatedOn = json['updatedOn'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['category'] = category;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['images'] = images;
    data['updatedOn'] = updatedOn;
    data['createdOn'] = createdOn;
    return data;
  }
}
