class UserBean {
  String status;
  String message;
  List<Result> result;

  UserBean({this.status, this.message, this.result});

  UserBean.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String id;
  String name;
  String email;
  String mobile;
  String password;
  String passwordString;
  String otp;
  String role;
  String lat;
  String lang;
  String serviceId;
  String created;

  Result(
      {this.id,
        this.name,
        this.email,
        this.mobile,
        this.password,
        this.passwordString,
        this.otp,
        this.role,
        this.lat,
        this.lang,
        this.serviceId,
        this.created});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    password = json['password'];
    passwordString = json['password_string'];
    otp = json['otp'];
    role = json['role'];
    lat = json['lat'];
    lang = json['lang'];
    serviceId = json['service_id'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['password_string'] = this.passwordString;
    data['otp'] = this.otp;
    data['role'] = this.role;
    data['lat'] = this.lat;
    data['lang'] = this.lang;
    data['service_id'] = this.serviceId;
    data['created'] = this.created;
    return data;
  }
}