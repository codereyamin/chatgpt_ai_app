class ChatModel {
  final String msg;
  final int chartIndex;
  ChatModel({required this.msg, required this.chartIndex});
  factory ChatModel.formJson(Map<String, dynamic> json) => ChatModel(
        chartIndex: json['chatIndex'],
        msg: json['msg'],
      );
}
