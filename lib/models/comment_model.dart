class CommentModel {
  late int status;
  late String message;
  late List dataComments;

  CommentModel({
    required this.status,
    required this.message,
    required this.dataComments,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    dataComments = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = dataComments;
    return data;
  }
}
