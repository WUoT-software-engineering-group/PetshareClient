import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_share/models/adopter.dart';
import 'package:pet_share/services/auth_services.dart';
import 'package:pet_share/services/data_services.dart';

import '../../models/announcement.dart';
import '../../views/authPage/users.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppSInitial());

  final DataServices _dataServices = DataServices();
  final AuthService _authService = AuthService();

  void authUser() async {
    try {
      bool signin = await _authService.authApp();

      if (signin) {
        switch (_authService.role) {
          case UserRoles.adopter:
            await initAdopter();
            break;
          case UserRoles.shelter:
            await initShelter();
            break;
          case UserRoles.unassigned:
            await initUnassigned();
            break;
          case UserRoles.unknown:
            log('AppCubit:authUser: unknown role of user');
            break;
          default:
            log('AppCubit: authUser: Somethings went wrong. Wrong role!');
        }
      }
    } catch (e) {
      log('AppCubit: authUser: ${e.toString()}');
    }
  }

  String getEmail() {
    return _authService.getEmail();
  }

  Future<void> setAddopter(Adopter adopter) async {
    var idUser =
        await _dataServices.addAdopter(adopter, _authService.accessToken!);
    await _authService.setRole(UserRoles.adopter, idUser);
    await initAdopter();
  }

  Future<void> initShelter() async {
    try {
      emit(AppSLoading());
      var res = await _dataServices.getAnnouncements();
      emit(AppSLoaded(res, UserType.shelter));
      log('AppCubit: initShelter: init is done correctly.');
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> initAdopter() async {
    try {
      emit(AppSLoading());
      var res = await _dataServices.getAnnouncements();
      emit(AppSLoaded(res, UserType.adopter));
      log('AppCubit: initAdopter: init is done correctly.');
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> initUnassigned() async {
    emit(AppSAuthed());
  }
}
