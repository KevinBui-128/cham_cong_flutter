part of 'calendar_bloc.dart';

class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => null;
}

class LoadCalendarEvent extends CalendarEvent {}

class OnReFreshCheckinEvent extends CalendarEvent {}

class OnPressButtonEvent extends CalendarEvent {
  final int specialDay;
  final int workDay;
  final int dayOff;
  final BuildContext context;

  OnPressButtonEvent(
      {@required this.specialDay,
      @required this.workDay,
      @required this.dayOff,
      @required this.context});
  @override
  List<Object> get props => [specialDay, workDay, dayOff, context];
}

class OnPressUpdateEvent extends CalendarEvent {
  final int specialDay;
  final int workDay;
  final int dayOff;
  final BuildContext context;
  OnPressUpdateEvent(
      {@required this.specialDay,
      @required this.workDay,
      @required this.dayOff,
      @required this.context});
  @override
  List<Object> get props => [specialDay, workDay, dayOff, context];
}

class DelButtonCalendarEvent extends CalendarEvent {
  final int specialDay;
  final int workDay;
  final int dayOff;
  final BuildContext context;
  DelButtonCalendarEvent(
      {@required this.specialDay,
      @required this.workDay,
      @required this.dayOff,
      @required this.context});
  @override
  List<Object> get props => [specialDay, workDay, dayOff, context];
}
