class InfoDialogModel {
  final double average;
  final String time;
  final double high;
  final double low;

  InfoDialogModel({
    required this.average,
    required this.time,
    required this.high,
    required this.low,
  });

  factory InfoDialogModel.fromJson(json) {
    return InfoDialogModel(
      average: json['average'],
      time: json['time'],
      high: json['high'],
      low: json['low'],
    );
  }
}
