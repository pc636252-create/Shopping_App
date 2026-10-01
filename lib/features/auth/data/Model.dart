class LoginResponse {
  User? user;
  String? token;

  LoginResponse({this.user, this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}
class User {
  int? id;
  String? name;
  String? email;
  String? createdAt;
  String? updatedAt;
  int? companyId;
  String? type;
  String? title;
  String? signatureImage;
  String? initialsImage;
  int? isDelete;
  String? licenseType;
  String? licenseNumber;
  String? wdoCity;
  String? wdoState;
  String? wdoPincode;
  String? avatar;
  String? companyLogo;
  Company? company;

  User(
      {this.id,
        this.name,
        this.email,
        this.createdAt,
        this.updatedAt,
        this.companyId,
        this.type,
        this.title,
        this.licenseNumber,
        this.licenseType,
        this.signatureImage,
        this.initialsImage,
        this.isDelete,
        this.wdoCity,
        this.wdoState,
        this.wdoPincode,
        this.avatar,
        this.companyLogo,
        this.company});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    licenseType = json['license_type'];
    licenseNumber = json['license_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    companyId = json['company_id'];
    type = json['type'];
    title = json['title'];
    signatureImage = json['signature_image'];
    initialsImage = json['initials_image'];
    isDelete = json['is_delete'];
    wdoCity = json['wdo_city'];
    wdoState = json['wdo_state'];
    wdoPincode = json['wdo_pincode'];
    avatar = json['avatar'];
    companyLogo = json['company_logo'];
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['license_type'] = this.licenseType;
    data['license_number'] = this.licenseNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['company_id'] = this.companyId;
    data['type'] = this.type;
    data['title'] = this.title;
    data['signature_image'] = this.signatureImage;
    data['initials_image'] = this.initialsImage;
    data['is_delete'] = this.isDelete;
    data['wdo_city'] = this.wdoCity;
    data['wdo_state'] = this.wdoState;
    data['wdo_pincode'] = this.wdoPincode;
    data['avatar'] = this.avatar;
    data['company_logo'] = this.companyLogo;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    return data;
  }
}
class Company {
  String? uuid;
  String? name;
  String? phone;
  String? email;
  String? createdAt;
  String? updatedAt;
  String? logo;

  Company(
      {this.uuid,
        this.name,
        this.phone,
        this.email,
        this.createdAt,
        this.updatedAt,
        this.logo});

  Company.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    logo = json['logo'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    data['logo'] = this.logo;

    return data;
  }
}