class CategoryModel {
  String? sId;
  late String title;
  late String description;
  String? updatedOn;
  String? createdOn;

  CategoryModel({
    this.sId,
    required this.title,
    required this.description,
    this.updatedOn,
    this.createdOn,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    updatedOn = json['updatedOn'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['updatedOn'] = updatedOn;
    data['createdOn'] = createdOn;
    return data;
  }
}
