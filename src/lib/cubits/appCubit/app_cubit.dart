import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppSInitial()) {
    initUser();
  }

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
