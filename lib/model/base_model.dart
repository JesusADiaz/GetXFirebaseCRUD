class WordModel{
  String? title;
  String? meaning;
  String? id;

  WordModel(this.title, this.meaning, this.id);

  WordModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    meaning = json['meaning'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['meaning'] = meaning;
    data['id'] = id;
    return data;
  }

}
