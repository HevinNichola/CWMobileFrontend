class ComplaintStatusData {
  final int incidentId;
  final String name;
  final String incident;
  final String status;
  final String location;
  final String timeframe;
  final String comment;
  final String progress;
  final List<String> image1;


  ComplaintStatusData({
    required this.incidentId,
    required this.status,
    required this.name,
    required this.incident,
    required this.location,
    required this.timeframe,
    required this.comment,
    required this.progress,
    required this.image1

  });

  factory ComplaintStatusData.fromJson(Map<String, dynamic> json) {
    // Check for null values and provide defaults if necessary
    final int incidentId = json['incidentId'];
    final String name = json['name'] ?? 'N/A';
    final String incident = json['incident'] ?? 'N/A';
    final String status = json['status'] ?? 'N/A';
    final String location = json['location'] ?? 'N/A';
    final String timeframe = json['timeframe'] ?? 'N/A';
    final String comment = json['comment'] ?? 'N/A';
    final String progress = json['progress'] ?? 'N/A';
    final List<String> images = (json['images1'] as List<dynamic>?)
        ?.map<String>((dynamic images) => images.toString())
        .toList() ??
        <String>[];


    return ComplaintStatusData(
      incidentId: incidentId,
      name: name,
      incident : incident,
      status: status,
      location: location,
      timeframe: timeframe,
      comment: comment,
      progress: progress,
      image1: images,
    );
  }
}