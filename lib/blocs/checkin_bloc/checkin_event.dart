part of 'checkin_bloc.dart';

class CheckinEvent extends Equatable {
  const CheckinEvent();

  @override
  List<Object> get props => null;
}

class LoadCheckinEvent extends CheckinEvent {}

class OnReFreshCheckinEvent extends CheckinEvent {}

class OnPressCheckinEvent extends CheckinEvent {
  final int checkinDate;
  final int checkinTime;
  final BuildContext context;

  OnPressCheckinEvent(
      {@required this.checkinDate,
      @required this.checkinTime,
      @required this.context});
  @override
  List<Object> get props => [checkinDate, checkinTime, context];
}

class OnPressCheckoutEvent extends CheckinEvent {
  final int checkoutTime;
  final int workTime;
  final BuildContext context;

  OnPressCheckoutEvent(
      {@required this.checkoutTime,
      @required this.workTime,
      @required this.context});
  @override
  List<Object> get props => [checkoutTime, workTime, context];
}

class OnRefreshEvent extends CheckinEvent{}