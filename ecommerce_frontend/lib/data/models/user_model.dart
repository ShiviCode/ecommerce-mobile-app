class UserModel {
  String? sId;
  late String fullName;
  late String email;
  late String password;
  String? phoneNumber;
  String? address;
  String? city;
  String? state;
  int? profileProgress;
  String? id;
  String? updatedOn;
  String? createdOn;

  UserModel({
    this.sId,
    required this.fullName,
    required this.email,
    required this.password,
    this.phoneNumber,
    this.address,
    this.city,
    this.state,
    this.profileProgress,
    this.id,
    this.updatedOn,
    this.createdOn,
  });

// named constructor
  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    profileProgress = json['profileProgress'];
    id = json['id'];
    updatedOn = json['updatedOn'];
    createdOn = json['createdOn'];
  }

// method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {}; //Map<String, dynamic>();
    data['_id'] = sId;
    data['fullName'] = fullName;
    data['email'] = email;
    data['password'] = password;
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['profileProgress'] = profileProgress;
    data['id'] = id;
    data['updatedOn'] = updatedOn;
    data['createdOn'] = createdOn;
    return data;
  }
}
