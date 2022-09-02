class Canal {
  String? id;
  String name;
  String areas;
  int open;
  int closed;
  List<String>? members;

  Canal({
    this.id,
    required this.name,
    required this.areas,
    this.open = 0,
    this.closed = 0,
  });
  Canal.fromMap(Map<String, dynamic> data)
      : this(
          id: data["id"],
          name: data["name"] as String,
          areas: data["areas"] as String,
          open: data["open"],
          closed: data["closed"],
        );
  Map<String, Object?> toMap() {
    return {
      "id": id,
      "name": name,
      "areas": closed,
      "open": open,
      "closed": closed,
    };
  }
}
