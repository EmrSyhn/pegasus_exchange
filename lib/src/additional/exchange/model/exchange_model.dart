// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class ExchangeModel extends Equatable {
  String? fromCur;
  String? toCur;
  double? excRate;
  int? exchangeId;
  String? currInfo;
  ExchangeModel(
      {this.fromCur, this.toCur, this.excRate, this.exchangeId, this.currInfo});

  ExchangeModel.fromJson(Map<String, dynamic> json) {
    fromCur = json['FROM_CUR'];
    toCur = json['TO_CUR'];
    excRate = json['EXC_RATE'];
    exchangeId = json['EXCHANGE_ID'];
    currInfo = json['CURR_INFO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FROM_CUR'] = fromCur;
    data['TO_CUR'] = toCur;
    data['EXC_RATE'] = excRate;
    data['EXCHANGE_ID'] = exchangeId;
    data['CURR_INFO'] = currInfo;

    return data;
  }

  static List<ExchangeModel> get exchangeList => [
        ExchangeModel(
          fromCur: "EUR",
          toCur: "TL",
          excRate: 29,
          exchangeId: 2,
          currInfo: "2",
        ),
        ExchangeModel(
          fromCur: "TL",
          toCur: "EUR",
          excRate: 30,
          exchangeId: 1,
          currInfo: "1",
        ),
        ExchangeModel(
          fromCur: "TL",
          toCur: "USD",
          excRate: 29,
          exchangeId: 3,
          currInfo: "3",
        ),
        ExchangeModel(
          fromCur: "USD",
          toCur: "TL",
          excRate: 28.6,
          exchangeId: 4,
          currInfo: "4",
        ),
      ];

  @override
  List<Object?> get props => [exchangeId, excRate, toCur, fromCur, currInfo];
}

extension ExchangeListX on List<ExchangeModel> {
  List<ExchangeModel> filterByIsNotNull() {
    return where(
            (exchange) => exchange.fromCur != null && exchange.toCur != null)
        .toList();
  }

  List<ExchangeModel> filter() {
    return filterByIsNotNull();
  }

  List<ExchangeModel> filterByFromCur() {
    Set<String> uniqueFromCurs = {};
    List<ExchangeModel> copyList = List.from(this);

    return copyList.where((exchange) {
      if (!uniqueFromCurs.contains(exchange.fromCur)) {
        uniqueFromCurs.add(exchange.fromCur!);
        return true;
      }
      return false;
    }).toList();
  }

  List<ExchangeModel> filterByToCur() {
    Set<String> uniqueFromCurs = {};
    List<ExchangeModel> copyList = List.from(this);
    return copyList.where((exchange) {
      if (!uniqueFromCurs.contains(exchange.toCur)) {
        uniqueFromCurs.add(exchange.toCur!);
        return true;
      }
      return false;
    }).toList();
  }
}
