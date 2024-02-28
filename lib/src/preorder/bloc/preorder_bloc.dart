import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/preorder_model.dart';
import '../helper/preorder_enum.dart';
import '../helper/preorder_methods.dart';

part 'preorder_event.dart';
part 'preorder_state.dart';

class PreorderBloc extends Bloc<PreorderEvent, PreorderState> {
  PreorderBloc() : super(PreorderInitialState()) {
    on<PreorderInitialEvent>(initialEvent);
    on<PreorderFetchDataEvent>(fetchDataEvent);
    on<PreorderChangeStatusEvent>(changeStatusEvent);
    on<PreorderFilterByIntervalEvent>(filterBySeatEvent);
    on<PreorderPrintButtonEvent>(printButtonEvent);
    on<PreorderSaveButtonEvent>(saveButtonEvent);
    on<PreorderBackButtonEvent>(backButtonEvent);
  }
  List<Preorder> preorderListBloc = [];
  FutureOr<void> initialEvent(
      PreorderInitialEvent event, Emitter<PreorderState> emit) {}

  FutureOr<void> changeStatusEvent(
      PreorderChangeStatusEvent event, Emitter<PreorderState> emit) {
    preorderListBloc
        .where((element) => element.preorderId == event.preorderId)
        .first
        .status = findDbPreorderStatusCode(event.status);
    preorderListBloc = sortPreorderList(preorderListBloc);
    emit(PreorderDataFetchedState(
        preorderList: preorderListBloc, triggerState: getRandomNumber()));
  }

  FutureOr<void> filterBySeatEvent(
      PreorderFilterByIntervalEvent event, Emitter<PreorderState> emit) {
    List<Preorder> tempPreorderList = preorderListBloc;

    //start -> 1-11 | mid -> 11-22 | end -> 22-33
    if (event.seatInterval == PreorderSeatInterval.start) {
      tempPreorderList = tempPreorderList
          .where((element) => getSeatNumber(element.seatNo!) < 11)
          .toList();
    } else if (event.seatInterval == PreorderSeatInterval.mid) {
      tempPreorderList = tempPreorderList
          .where((element) => (getSeatNumber(element.seatNo!) < 22 &&
              getSeatNumber(element.seatNo!) > 10))
          .toList();
    } else if (event.seatInterval == PreorderSeatInterval.end) {
      tempPreorderList = tempPreorderList
          .where((element) => (getSeatNumber(element.seatNo!) < 34 &&
              getSeatNumber(element.seatNo!) > 21))
          .toList();
    }
    tempPreorderList = sortPreorderList(tempPreorderList);
    emit(PreorderDataFetchedState(
        preorderList: tempPreorderList, triggerState: getRandomNumber()));
  }

  FutureOr<void> printButtonEvent(
      PreorderPrintButtonEvent event, Emitter<PreorderState> emit) {
    //TODO[3]: Burada fiş yazdırma işlemi yapılacak
    //  PrintOperations().preorderReport(sortPreorderList(preorderListBloc));
  }

  FutureOr<void> saveButtonEvent(
      PreorderSaveButtonEvent event, Emitter<PreorderState> emit) async {
    if (preorderListBloc.isEmpty) {
    } else {
      //TODO[4]: Burada veritabanına kaydetme işlemi yapılacak
      //await PreorderDaoRepository().updatePreorderList(preorderListBloc);
      emit(PreorderSaveButtonPressedState());
    }
  }

  FutureOr<void> backButtonEvent(
      PreorderBackButtonEvent event, Emitter<PreorderState> emit) {}

  FutureOr<void> fetchDataEvent(
      PreorderFetchDataEvent event, Emitter<PreorderState> emit) async {
    await Future.delayed(const Duration(seconds: 3));

    // TODO[5]: Burada veritabanından veri çekme işlemi yapılacak
    // Şimdilik mock data döndürüyoruz

    List<Preorder> preorderList = <Preorder>[
      Preorder(
        name: "Ahmet",
        pnrNo: "PNR123",
        preorderId: 1,
        seatNo: "1A",
        status: "S",
        flightInfoId: 1013,
        ssrCode: "SSR",
      ),
      Preorder(
        name: "Mehmet",
        pnrNo: "PNR124",
        preorderId: 2,
        seatNo: "1B",
        status: "S",
        flightInfoId: 1013,
        ssrCode: "SSR",
      ),
      Preorder(
        name: "Ali",
        pnrNo: "PNR125",
        preorderId: 3,
        seatNo: "1C",
        status: "S",
        flightInfoId: 1013,
        ssrCode: "SSR",
      ),
      Preorder(
        name: "Veli",
        pnrNo: "PNR126",
        preorderId: 4,
        seatNo: "1D",
        status: "S",
        flightInfoId: 1013,
        ssrCode: "SSR",
      ),
      Preorder(
        name: "Hasan",
        pnrNo: "PNR127",
        preorderId: 5,
        seatNo: "1E",
        status: "S",
        flightInfoId: 1013,
        ssrCode: "SSR",
      ),
      Preorder(
        name: "Hüseyin",
        pnrNo: "PNR128",
        preorderId: 6,
        seatNo: "1F",
        status: "S",
        flightInfoId: 1013,
        ssrCode: "SSR",
      ),
      Preorder(
        name: "Mehmet",
        pnrNo: "PNR129",
        preorderId: 7,
        seatNo: "1G",
        status: "S",
        flightInfoId: 1013,
        ssrCode: "SSR",
      ),
      Preorder(
        name: "Ali",
        pnrNo: "PNR130",
        preorderId: 8,
        seatNo: "1H",
        status: "S",
        flightInfoId: 1013,
        ssrCode: "SSR",
      )
    ];

    if (preorderList.isNotEmpty) {
      for (var element in preorderList) {
        if (element.status == "S") {
          element.status = "T";
        }
      }
      preorderList = sortPreorderList(preorderList);
      preorderListBloc = preorderList;
      emit(PreorderDataFetchedState(
          preorderList: preorderList, triggerState: getRandomNumber()));
    } else {
      emit(PreorderEmptyState());
    }
  }

  int getSeatNumber(String seatNo) {
    return int.tryParse(seatNo.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;
  }

  List<Preorder> sortPreorderList(List<Preorder> list) {
    list.sort((a, b) {
      // Koltuk numaralarının boş olup olmadığını kontrol edin
      bool isANull = a.seatNo == null || a.seatNo!.isEmpty;
      bool isBNull = b.seatNo == null || b.seatNo!.isEmpty;

      // Eğer a'nın koltuk numarası boş ise, b'yi öne al
      if (isANull && !isBNull) {
        return 1;
      }
      // Eğer b'nin koltuk numarası boş ise, a'yı öne al
      else if (!isANull && isBNull) {
        return -1;
      }
      // Her iki koltuk numarası da dolu ise, sıralamayı normal olarak yap
      else {
        // Her iki seatNo'nun sayısal kısmını çıkar
        int numberA =
            int.tryParse(a.seatNo!.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;
        int numberB =
            int.tryParse(b.seatNo!.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;

        // Önce sayısal kısımlara göre karşılaştır
        if (numberA != numberB) {
          return numberA.compareTo(numberB);
        }

        // Sayısal kısımlar eşitse, harf kısımlarına göre karşılaştır
        String letterA = a.seatNo!.replaceAll(RegExp(r'[\d]'), '');
        String letterB = b.seatNo!.replaceAll(RegExp(r'[\d]'), '');

        return letterA.compareTo(letterB);
      }
    });
    return list;
  }
}

int getRandomNumber() {
  return Random().nextInt(100) + 1;
}
