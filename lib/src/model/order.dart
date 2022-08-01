enum Status { open, closed }

class Order {
  String? id;
  String patrimony;
  String when;
  Status status;
  String description;
  String? solution;
  String? closedAt;

  Order({
    this.id,
    required this.patrimony,
    required this.when,
    this.status = Status.open,
    required this.description,
    this.solution,
    this.closedAt,
  });

  Order.fromMap(Map<String, Object?> data)
      : this(
          id: data['id'] as String?,
          patrimony: data['patrimony'] as String,
          when: data['when'] as String,
          status: data['status'] == 'open' ? Status.open : Status.closed,
          description: data['description'] as String,
          solution: data['solution'] as String?,
          closedAt: data['closedAt'] as String?,
        );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'patrimony': patrimony,
      'when': when,
      'status': status.name,
      'description': description,
      'solution': solution,
      'closedAt': closedAt,
    };
  }
}
