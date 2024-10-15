class TickerSymbol {
  TickerSymbol(this.name, this.imageUrl);
  final String name;
  final String imageUrl;
}

final tickerSymbols = [
  TickerSymbol("BTC-USD", "https://cryptologos.cc/logos/bitcoin-btc-logo.png"),
  TickerSymbol("ETH-USD", "https://seeklogo.com/images/E/ethereum-blue-logo-8BC914153E-seeklogo.com.png")
];
