class Cryptocurrency {
  Cryptocurrency({
    required this.tickerCode,
    required this.lastPrice,
    required this.quantityTrade,
    required this.dailyChange,
    required this.dailyDiff,
    required this.dateTime,
    required this.timestamp,
  });
  final String tickerCode;
  final double lastPrice;
  final double quantityTrade;
  final double dailyChange;
  final double dailyDiff;
  final DateTime dateTime;
  final int timestamp;

  factory Cryptocurrency.fromMap(Map<String, dynamic> data) => Cryptocurrency(
        tickerCode: data["s"],
        lastPrice: data["p"] is double ? data["p"] : double.parse(data["p"]),
        quantityTrade: data["q"] is double ? data["q"] : double.parse(data["q"]),
        dailyChange: data["dc"] is double ? data["dc"] : double.parse(data["dc"]),
        dailyDiff: data["dd"] is double ? data["dd"] : double.parse(data["dd"]),
        dateTime: DateTime.fromMillisecondsSinceEpoch(data["t"]),
        timestamp: data["t"],
      );
}
