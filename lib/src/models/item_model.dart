import 'dart:convert';

class ItemModel {
  late final int id;
  late final bool deleted;
  late final String type;
  late final String by;
  late final int time;
  late final String text;
  late final bool dead;
  late final int parent;
  late final List<dynamic> kids;
  late final String url;
  late final int score;
  late final String title;
  late int descendants;

  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    deleted = parsedJson['deleted'] ?? false;
    type = parsedJson['type'] ?? '';
    by = parsedJson['by'] ?? '';
    time = parsedJson['time'];
    text = parsedJson['text'] ?? '';
    dead = parsedJson['dead'] ?? false;
    parent = parsedJson['parent'];
    kids = parsedJson['kids'] ?? [];
    url = parsedJson['url'];
    score = parsedJson['score'];
    title = parsedJson['title'];
    descendants = parsedJson['descendants'] ?? 0;
  }
  ItemModel.fromDb(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    deleted = parsedJson['deleted'] == 1;
    type = parsedJson['type'];
    by = parsedJson['by'] ?? '';
    time = parsedJson['time'];
    text = parsedJson['text'];
    dead = parsedJson['dead'] == 1;
    parent = parsedJson['parent'];
    kids = jsonDecode(parsedJson['kids']);
    url = parsedJson['url'];
    score = parsedJson['score'];
    title = parsedJson['title'];
    descendants = parsedJson['descendants'] ?? 0;
  }
  //Create a new map to insert into the database
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "type": type,
      "by": by,
      "time": time,
      "text": text,
      "parent": parent,
      "url": url,
      "score": score,
      "title": title,
      "descendants": descendants,
      "dead": dead ? 1 : 0,
      "deleted": deleted ? 1 : 0,
      "kids": jsonEncode(kids)
    };
  }
}
