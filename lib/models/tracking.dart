

class Tracking {
  final String courierId;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Tracking({this.courierId, this.status, this.createdAt, this.updatedAt});

  factory Tracking.fromJSON(Map<String, dynamic> jsonData) {
    return Tracking(
      courierId: jsonData['courier_id'].toString(),
      status: jsonData['status'],
      createdAt: jsonData['createdAt'] != null
          ? DateTime.parse(jsonData['createdAt'])
          : null,
      updatedAt: jsonData['updatedAt'] != null
          ? DateTime.parse(jsonData['updatedAt'])
          : null,
    );
  }
}
