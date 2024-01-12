class ProductModel {
  late int status;
  late String message;
  late List dataProducts;

  ProductModel({
    required this.status,
    required this.message,
    required this.dataProducts,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    dataProducts = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = dataProducts;
    return data;
  }
}

class ProductDetailModel {
  late int status;
  late String message;
  late Map dataProduct;

  ProductDetailModel({
    required this.status,
    required this.message,
    required this.dataProduct,
  });

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    dataProduct = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = dataProduct;
    return data;
  }
}
