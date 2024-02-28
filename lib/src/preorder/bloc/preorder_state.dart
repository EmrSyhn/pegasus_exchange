part of 'preorder_bloc.dart';

sealed class PreorderState extends Equatable {
  const PreorderState();

  @override
  List<Object> get props => [];
}

sealed class PreorderActionState extends PreorderState {
  const PreorderActionState();
}

final class PreorderInitialState extends PreorderState {}

@immutable
final class PreorderDataFetchedState extends PreorderState {
  final List<Preorder> preorderList;
  final int triggerState;
  const PreorderDataFetchedState(
      {required this.triggerState, required this.preorderList});

  @override
  List<Object> get props => [preorderList, triggerState];

  //preorder modeli al
  //status u props da belirt
  //filtre geldiği zaman için tetikleyici yi props da belirt
}

final class PreorderChangeStatusState extends PreorderActionState {}

final class PreorderFilterBySeatState extends PreorderActionState {}

final class PreorderPrintButtonPressedState extends PreorderActionState {}

final class PreorderSaveButtonPressedState extends PreorderActionState {}

final class PreorderBackButtonPressedState extends PreorderActionState {}

final class PreorderEmptyState extends PreorderState {}
