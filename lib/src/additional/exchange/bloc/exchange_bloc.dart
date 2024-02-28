import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/exchange.dart';
import '../exchange.dart';

part 'exchange_event.dart';
part 'exchange_state.dart';

class ExchangeBloc extends Bloc<ExchangeEvent, ExchangeState> {
  ExchangeBloc() : super(ExchangeInitialState()) {
    on<ExchangeInitialEvent>(initialEvent);
    on<ExchangeSourceCurrencySelectionEvent>(selectionSourceCurrencyEvent);
    on<ExchangeConvertedCurrencySelectionEvent>(
        selectionConvertedCurrencyEvent);
    on<ExchangeChangeCurrencyValueInputEvent>(changeCurrencyValueInputEvent);
    on<ExchangeFetchListEvent>(exchangeFetchListEvent);
    on<ExchangeBackButtonClickEvent>(exchangeBackButtonClickEvent);
  }

  // TODO[1]: Mock data
  List<Exchange> currencyList = <Exchange>[
    Exchange(
        fromCur: 'USD',
        toCur: 'TRY',
        excRate: 8.5,
        exchangeId: 1,
        currInfo: "USD"),
    Exchange(
        fromCur: 'TRY',
        toCur: 'USD',
        excRate: 0.12,
        exchangeId: 2,
        currInfo: "TRY"),
    Exchange(
        fromCur: 'EUR',
        toCur: 'TRY',
        excRate: 10.0,
        exchangeId: 3,
        currInfo: "EUR"),
    Exchange(
        fromCur: 'TRY',
        toCur: 'EUR',
        excRate: 0.10,
        exchangeId: 4,
        currInfo: "TRY"),
    Exchange(
        fromCur: 'GBP',
        toCur: 'TRY',
        excRate: 12.0,
        exchangeId: 5,
        currInfo: "GBP"),
    Exchange(
        fromCur: 'TRY',
        toCur: 'GBP',
        excRate: 0.08,
        exchangeId: 6,
        currInfo: "TRY"),
  ];
  late Exchange selectedSourceCurrencyBloc;
  late Exchange selectedConvertedCurrencyBloc;
  double amount = 0;
  double result = 0;
  FutureOr<void> initialEvent(
      ExchangeInitialEvent event, Emitter<ExchangeState> emit) {}

  FutureOr<void> exchangeBackButtonClickEvent(
      ExchangeBackButtonClickEvent event, Emitter<ExchangeState> emit) {
    emit(ExchangeBackButtonClickActionState());
  }

  FutureOr<void> selectionSourceCurrencyEvent(
      ExchangeSourceCurrencySelectionEvent event, Emitter<ExchangeState> emit) {
    selectedSourceCurrencyBloc = event.exchange;
    emit(
      ExchangeFetchListState(
        amount: amount,
        selectedSourceExchange: selectedSourceCurrencyBloc,
        selectedConvertedExchange: selectedConvertedCurrencyBloc,
        result: calculateResult(),
        exchangeList: currencyList,
      ),
    );
  }

  FutureOr<void> selectionConvertedCurrencyEvent(
      ExchangeConvertedCurrencySelectionEvent event,
      Emitter<ExchangeState> emit) {
    selectedConvertedCurrencyBloc = event.exchange;
    emit(
      ExchangeFetchListState(
        amount: amount,
        exchangeList: currencyList,
        selectedSourceExchange: selectedSourceCurrencyBloc,
        selectedConvertedExchange: selectedConvertedCurrencyBloc,
        result: calculateResult(),
      ),
    );
  }

  FutureOr<void> changeCurrencyValueInputEvent(
      ExchangeChangeCurrencyValueInputEvent event,
      Emitter<ExchangeState> emit) {
    amount = event.amount;
    emit(
      ExchangeFetchListState(
        amount: amount,
        selectedSourceExchange: selectedSourceCurrencyBloc,
        selectedConvertedExchange: selectedConvertedCurrencyBloc,
        exchangeList: currencyList,
        result: calculateResult(),
      ),
    );
  }

  FutureOr<void> exchangeFetchListEvent(
      ExchangeFetchListEvent event, Emitter<ExchangeState> emit) async {
    await fetchCurrencyList();
    selectedSourceCurrencyBloc = currencyList[0];
    selectedConvertedCurrencyBloc = currencyList[1];
    emit(
      ExchangeFetchListState(
        amount: 0,
        result: 0,
        exchangeList: currencyList,
        selectedSourceExchange: selectedSourceCurrencyBloc,
        selectedConvertedExchange: selectedConvertedCurrencyBloc,
      ),
    );
  }

  Future<void> fetchCurrencyList() async {
    // TODO[2]: Şimdilik mock data olduğu için 2 saniye bekletiyoruz.
    await Future.delayed(const Duration(seconds: 2));
    currencyList = currencyList;
  }

  // Sonuç hesaplama fonksiyonu
  double calculateResult() {
    return amount *
        calculateExchangeRate(
          toCurrency: selectedConvertedCurrencyBloc,
          fromCurrency: selectedSourceCurrencyBloc,
          originalCurrencyListBloc: currencyList,
        );
  }
}
