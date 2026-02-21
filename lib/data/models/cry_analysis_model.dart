class CryAnalysis {
  final String analysis;
  final String fileName;
  final String model;
  final String timestamp;
  final String userId;

  CryAnalysis({
    required this.analysis,
    required this.fileName,
    required this.model,
    required this.timestamp,
    required this.userId,
  });

  factory CryAnalysis.fromJson(Map<String, dynamic> json) {
    return CryAnalysis(
      analysis: json['analysis'] as String? ?? '',
      fileName: json['file_name'] as String? ?? '',
      model: json['model'] as String? ?? '',
      timestamp: json['timestamp'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
    );
  }
}
