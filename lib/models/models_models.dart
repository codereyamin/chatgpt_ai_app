class ModelsModel {
  final String id;
  final int created;
  final String root;

  ModelsModel({required this.id, required this.created, required this.root});
  factory ModelsModel.fromjson(Map<String, dynamic> json) => ModelsModel(
        id: json["id"],
        created: json["created"],
        root: json["root"],
      );

  static List<ModelsModel> modelsFromSnapshot(List modelSnapshot) {
    return modelSnapshot.map((data) => ModelsModel.fromjson(data)).toList();
  }
}