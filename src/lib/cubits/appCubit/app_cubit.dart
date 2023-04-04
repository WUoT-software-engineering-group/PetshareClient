import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_share/services/data_services.dart';
import 'package:pet_share/views/loginPage/users.dart';

import '../../models/announcement.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppSInitial());

  final DataServices _dataServices = DataServices();

  void initShelter() async {
    try {
      emit(AppSLoading());
      var res = await _dataServices.getAnnouncements();
      emit(AppSLoaded(res, UserType.shelter));
    } catch (e) {
      log(e.toString());
    }
  }

  void initAdoptingPerson() async {
    try {
      emit(AppSLoading());
      var res = await _dataServices.getAnnouncements();
      emit(AppSLoaded(res, UserType.adoptingPerson));
    } catch (e) {
      log(e.toString());
    }
  }
}
