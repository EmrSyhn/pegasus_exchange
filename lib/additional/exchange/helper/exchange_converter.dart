import '../../model/exchange.dart';

double calculateExchangeRate({
  required Exchange toCurrency,
  required Exchange fromCurrency,
  required List<Exchange> originalCurrencyListBloc,
}) {
  const String baseCurrency = "TRY";

  if ((fromCurrency.fromCur == toCurrency.fromCur)) {
    return 1;
  }
  if ((fromCurrency.fromCur == baseCurrency ||
      toCurrency.fromCur == baseCurrency)) {
    Exchange exchange = originalCurrencyListBloc.singleWhere(
      (element) =>
          element.fromCur == fromCurrency.fromCur &&
          element.toCur == toCurrency.fromCur,
      orElse: () => Exchange(),
    );

    return exchange.excRate ?? -1;
  } else {
    //fromCur to TRY
    Exchange exchangeTRY = originalCurrencyListBloc.singleWhere(
      (element) =>
          element.fromCur == fromCurrency.fromCur &&
          element.toCur == baseCurrency,
      orElse: () => Exchange(),
    );

    //TRY to toCur
    Exchange exchangeResult = originalCurrencyListBloc.singleWhere(
      (element) =>
          element.fromCur == baseCurrency &&
          element.toCur == toCurrency.fromCur,
      orElse: () => Exchange(),
    );
    return (exchangeTRY.excRate ?? -1) * (exchangeResult.excRate ?? -1);
  }
}
