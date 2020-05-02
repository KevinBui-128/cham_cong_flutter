import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chamcongapp/configs/config.dart';
import 'package:chamcongapp/data/api/addCheckinApi.dart';
import 'package:chamcongapp/data/api/checkinApi.dart';
import 'package:chamcongapp/data/api/updateCheckinApi.dart';
import 'package:chamcongapp/data/model/checkinModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'checkin_event.dart';
part 'checkin_state.dart';

class CheckinBloc extends Bloc<CheckinEvent, CheckinState> {
  @override
  CheckinState get initialState => CheckinInitial();

  @override
  Stream<CheckinState> mapEventToState(
    CheckinEvent event,
  ) async* {
    try {
      if (event is LoadCheckinEvent) {
        yield LoadingState();
        CheckinModel checkinModel = await getCheckin();

        if (checkinModel?.data != null) {
          yield LoadedState(checkinList: checkinModel.data);
        } else {
          yield ErrorState(
              errorTitle: "Thông báo lỗi", errorMessage: "Lỗi không xác định");
        }
      } else if (event is OnPressCheckinEvent) {
        yield LoadingState();
        final result = await postCheckin(
            checkinDate: event.checkinDate, checkinTime: event.checkinTime);
        if (result == 1) {
          ConfigsApp.checkin = event.checkinDate;
          ConfigsApp.checkinFormat = DateTime.now();
          // prefs.setString('stringValue', "abc");
          yield SuccessState(title: "Thông báo", message: "Check in thành công");
        } else {
          yield ErrorState(
              errorTitle: "Thông báo", errorMessage: "Check in thất bại");
        }
      } else if (event is OnPressCheckoutEvent) {
        yield LoadingState();
        final result = await postUpdateCheckin(
            checkoutTime: event.checkoutTime, workTime: event.workTime);
        if (result == 1) {
          yield SuccessState(title: "Thông báo", message: "Check out thành công");
        } else {
          yield ErrorState(
              errorTitle: "Thông báo", errorMessage: "Check out thất bại");
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
