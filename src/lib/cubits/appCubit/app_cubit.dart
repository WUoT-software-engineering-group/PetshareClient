import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_share/models/adopter.dart';
import 'package:pet_share/models/announcement.dart';
import 'package:pet_share/models/shelter.dart';
import 'package:pet_share/models/user_info.dart';
import 'package:pet_share/services/auth_services.dart';
import 'package:pet_share/services/data_services.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final DataServices _dataServices = DataServices();
  final AuthService _authService = AuthService();

  // ----------------------------------
  // Gets & Sets
  // ----------------------------------

  String get getEmail => _authService.getEmail;

  // ----------------------------------
  // Contstructors
  // ----------------------------------

  AppCubit() : super(AppSInitial());

  // ----------------------------------
  // Auth methods
  // ----------------------------------

  void authUser() async {
    bool signin = await _authService.authApp();
    try {
      if (signin) {
        await _authService.selectAuthFlow(
          initAdopter: initAdopter,
          initShelter: initShelter,
          initUnassigned: initUnassigned,
        );
      }
    } catch (e) {
      log('AppCubit: authUser: ${e.toString()}');
    }
  }

  void logoutUser() async {
    emit(AppSLoading());
    await _authService.logoutUser();
    Future.delayed(const Duration(seconds: 2));
    emit(AppSInitial());
  }

  // ----------------------------------
  //  Set account methods
  // ----------------------------------

  Future<void> setAddopter(Adopter adopter) async {
    emit(AppSLoading());
    var idUser = await _dataServices.addAdopter(
      adopter,
      _authService.accessToken,
    );
    await _authService.setRole(UserRoles.adopter, idUser);
    await initAdopter();
  }

  Future<void> setShelter(Shelter shelter) async {
    emit(AppSLoading());
    var idUser = await _dataServices.addShelter(
      shelter,
      _authService.accessToken,
    );
    await _authService.setRole(UserRoles.shelter, idUser);
    await initShelter();
  }

  // ----------------------------------
  // Init account methods
  // ----------------------------------

  Future<void> initShelter() async {
    try {
      emit(AppSLoading());
      var res = await _dataServices.getAnnouncements(_authService.accessToken);
      emit(
        AppSLoaded(
          announcements: res,
          userInfo: _authService.userInfo,
        ),
      );
      log('AppCubit: initShelter: init is done correctly.');
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> initAdopter() async {
    try {
      emit(AppSLoading());
      var res = await _dataServices.getAnnouncements(_authService.accessToken);
      emit(
        AppSLoaded(
          announcements: res,
          userInfo: _authService.userInfo,
        ),
      );
      log('AppCubit: initAdopter: init is done correctly.');
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> initUnassigned() async {
    emit(AppSAuthed());
  }
}
