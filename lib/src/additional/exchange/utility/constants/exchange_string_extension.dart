extension ExchangeStringX on String {
  double get toAmount {
    return double.tryParse(replaceAll(",", ".")) ?? 0;
  }
}
