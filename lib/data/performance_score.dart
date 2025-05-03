class PerformanceScore {
  final String userId;
  final num productivityScore;
  final String summary;

  PerformanceScore({
    required this.userId,
    required this.productivityScore,
    required this.summary,
  });

  factory PerformanceScore.fromJson(Map<String, dynamic> json) =>
      PerformanceScore(
        userId: json['userId'],
        productivityScore: json['productivity'] as num,
        summary: json['summary'].toString(),
      );
}
