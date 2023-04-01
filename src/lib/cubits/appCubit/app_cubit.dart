import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_share/services/data_services.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppSInitial()) {
    initUser();
  }

  final DataServices _dataServices = DataServices();

  void initUser() async {
    try {
      emit(AppSLoading());
      await Future.delayed(const Duration(seconds: 4));
      emit(AppSLoaded());
    } catch (e) {
      log(e.toString());
    }
  }
}
