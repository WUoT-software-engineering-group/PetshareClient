import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_share/services/data_services.dart';

import '../../models/announcement.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppSInitial()) {
    initUser();
  }

  final DataServices _dataServices = DataServices();

  void initUser() async {
    try {
      emit(AppSLoading());
      var res = await _dataServices.getAnnouncements();
      emit(AppSLoaded(res));
    } catch (e) {
      log(e.toString());
    }
  }
}
