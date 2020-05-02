import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chamcongapp/data/api/addCalendarApi.dart';
import 'package:chamcongapp/data/api/calendarApi.dart';
import 'package:chamcongapp/data/api/delCalendarApi.dart';
import 'package:chamcongapp/data/api/updateCalendarApi.dart';
import 'package:chamcongapp/data/model/calendarModel.dart';
import 'package:chamcongapp/screens/homeScreen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  @override
  CalendarState get initialState => CalendarInitial();

  @override
  Stream<CalendarState> mapEventToState(
    CalendarEvent event,
  ) async* {
    try {
      if (event is LoadCalendarEvent) {
        yield LoadingState();
        CalendarModel calendarModel = await getCalendar();

        if (calendarModel?.data != null) {
          yield LoadedState(calendarList: calendarModel.data);
        } else {
          yield ErrorState(
              errorTitle: "Thông báo lỗi", errorMessage: "Lỗi không xác định");
        }
      } else if (event is OnPressButtonEvent) {
        yield LoadingState();
        final result = await postCalendar(
            dayOff: event.dayOff,
            specialDay: event.specialDay,
            workDay: event.workDay);
        if (result == 1) {
          yield SuccessState(
              title: "Thông báo", message: "Đăng ký thành công");
        } else {
          yield ErrorState(
              errorTitle: "Đăng ký thất bại", errorMessage: "Đăng ký thất bại");
        }
      } else if (event is OnPressUpdateEvent) {
        final result = await postUpdateCalendar(
            specialDay: event.specialDay,
            dayOff: event.dayOff,
            workDay: event.workDay);
        if (result == 1) {
          yield SuccessState(
              title: "Thông báo", message: "Cập nhật thành công");
        } else {
          yield ErrorState(
              errorTitle: "Thông báo lỗi", errorMessage: "Cập nhật thất bại");
        }
      } else if (event is DelButtonCalendarEvent) {
        final result = await delCalendar(
            workDay: event.workDay,
            dayOff: event.dayOff,
            specialDay: event.specialDay);
        if (result == 1) {
          yield SuccessState(title: "Thông báo", message: "Xóa thành công");
          Navigator.pushReplacement(
            event.context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        } else {
          yield ErrorState(
              errorTitle: "Thông báo lỗi", errorMessage: "Xóa thất bại");
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
