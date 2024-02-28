part of 'exchange_bloc.dart';

@immutable
sealed class ExchangeState {}

@immutable
sealed class ExchangeActionState extends ExchangeState {}

// INITIAL EVENT
final class ExchangeInitialState extends ExchangeState {}

// SOURCE CURRENCY SELECT STATE
@immutable
final class ExchangeSelectionSourceCurrencyState extends ExchangeState {
  final ExchangeModel exchange;
  final double amount;
  final ExchangeModel selectedConvertedCurrency;
  ExchangeSelectionSourceCurrencyState({
    required this.exchange,
    required this.amount,
    required this.selectedConvertedCurrency,
  });
}

// CONVERTED CURRENCY SELECT STATE
@immutable
final class ExchangeSelectionConvertedCurrencyState extends ExchangeState {
  final ExchangeModel exchange;
  final double amount;
  final ExchangeModel selectedSourceCurrency;

  ExchangeSelectionConvertedCurrencyState({
    required this.exchange,
    required this.amount,
    required this.selectedSourceCurrency,
  });
}

// CHANGE CURRENCY VALUE INPUT STATE
final class ExchangeChangeCurrencyValueInputState extends ExchangeState {
  final ExchangeModel selectedConvertedCurrency;
  final double amount;
  final ExchangeModel selectedSourceCurrency;

  ExchangeChangeCurrencyValueInputState({
    required this.selectedConvertedCurrency,
    required this.amount,
    required this.selectedSourceCurrency,
  });
}

// FETCH CURRRENCY LIST STATE
final class ExchangeFetchListState extends ExchangeState {
  final List<Exchange> exchangeList;
  final Exchange selectedSourceExchange;
  final Exchange selectedConvertedExchange;
  final double amount;
  final double result;

  ExchangeFetchListState({
    required this.exchangeList,
    required this.selectedSourceExchange,
    required this.selectedConvertedExchange,
    required this.amount,
    required this.result,
  });
}

// BACK BUTTON ACTION STATE
final class ExchangeBackButtonClickActionState extends ExchangeActionState {}
