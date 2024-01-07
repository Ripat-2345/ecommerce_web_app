class AuthModel {
  late int status;
  late String message;
  late Map dataUser;
  late String token;

  AuthModel({
    required this.status,
    required this.message,
    required this.dataUser,
    required this.token,
  });

  AuthModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    dataUser = json['data'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = dataUser;
    data['token'] = token;
    return data;
  }
}
