class CartModel {
  late int status;
  late String message;
  late List dataCarts;

  CartModel({
    required this.status,
    required this.message,
    required this.dataCarts,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    dataCarts = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = dataCarts;
    return data;
  }
}
