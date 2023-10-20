class TodoMOdel {
  final int? id;
  final String? title;
  final String? desc;
  final String? dateandtime;

  TodoMOdel({this.id, this.title, this.desc, this.dateandtime});

  TodoMOdel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        desc = res['desc'],
        dateandtime = res['dateandtime'];

  Map<String, Object?> toMap() => {
        'id': id,
        'title': title,
        'desc': desc,
        'dateandtime': dateandtime,
      };
}
