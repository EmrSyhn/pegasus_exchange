part of 'preorder_bloc.dart';

sealed class PreorderEvent extends Equatable {
  const PreorderEvent();

  @override
  List<Object> get props => [];
}

final class PreorderInitialEvent extends PreorderEvent {}

final class PreorderFetchDataEvent extends PreorderEvent {}

final class PreorderChangeStatusEvent extends PreorderEvent {
  final int preorderId;
  final PreorderStatus status;

  const PreorderChangeStatusEvent({required this.preorderId, required this.status});
}

@immutable
final class PreorderFilterByIntervalEvent extends PreorderEvent {
  final PreorderSeatInterval seatInterval;
  const PreorderFilterByIntervalEvent({required this.seatInterval});
}

final class PreorderPrintButtonEvent extends PreorderEvent {}

final class PreorderSaveButtonEvent extends PreorderEvent {}

final class PreorderBackButtonEvent extends PreorderEvent {}
