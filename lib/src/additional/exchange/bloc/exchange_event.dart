// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'exchange_bloc.dart';

sealed class ExchangeEvent extends Equatable {
  const ExchangeEvent();
  @override
  List<Object> get props => [];
}

// INITIAL EVENT
class ExchangeInitialEvent extends ExchangeEvent {}

// SOURCE CURRENCY SELECT EVENT
class ExchangeSourceCurrencySelectionEvent extends ExchangeEvent {
  final Exchange exchange;

  const ExchangeSourceCurrencySelectionEvent({
    required this.exchange,
  });
  @override
  List<Object> get props => [exchange];
}

// CONVERTED CURRENCY SELECT EVENT
class ExchangeConvertedCurrencySelectionEvent extends ExchangeEvent {
  final Exchange exchange;

  const ExchangeConvertedCurrencySelectionEvent({
    required this.exchange,
  });
  @override
  List<Object> get props => [exchange];
}

// CHANGE CURRENCY VALUE INPUT EVENT
class ExchangeChangeCurrencyValueInputEvent extends ExchangeEvent {
  final double amount;

  const ExchangeChangeCurrencyValueInputEvent({
    required this.amount,
  });
  @override
  List<Object> get props => [amount];
}

// FETCH CURRRENCY LIST EVENT
class ExchangeFetchListEvent extends ExchangeEvent {}

// BACK BUTTON EVENT
class ExchangeBackButtonClickEvent extends ExchangeEvent {}
