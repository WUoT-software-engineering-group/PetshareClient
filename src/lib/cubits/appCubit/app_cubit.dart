import 'dart:developer';

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_share/models/adopter.dart';
import 'package:pet_share/models/announcement.dart';
import 'package:pet_share/models/applications.dart';
import 'package:pet_share/models/pet.dart';
import 'package:pet_share/models/shelter.dart';
import 'package:pet_share/models/user_info.dart';
import 'package:pet_share/services/auth_services.dart';
import 'package:pet_share/services/data_services.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final DataServices2 _dataServices2;
  final AuthService _authService;
  final void Function(String) reaction;

  // ----------------------------------
  // Gets & Sets
  // ----------------------------------

  String get getEmail => _authService.getEmail;

  // ----------------------------------
  // Contstructors
  // ----------------------------------

  AppCubit(
    this._dataServices2,
    this._authService, {
    required this.reaction,
  }) : super(AppSInitial());

  // ----------------------------------
  // Auth methods
  // ----------------------------------

  void authUser() async {
    try {
      bool signin = await _authService.authApp();

      if (signin) {
        await _authService.selectAuthFlow(
          initAdopter: initAdopter,
          initShelter: initShelter,
          initUnassigned: initUnassigned,
        );
      }
    } on WebAuthenticationException catch (e) {
      emit(AppSInitial());
      _authService.clearSettings();
      if (e.code != 'a0.authentication_canceled') {
        log(e.code);
        reaction(e.message);
      }
    } on AuthServicesException catch (e) {
      emit(AppSInitial());
      _authService.clearAll();
      log(e.message);
      reaction(e.message);
    }
  }

  void logoutUser() async {
    emit(AppSLoading());
    try {
      await _authService.logoutUser();
      emit(AppSInitial());
    } on DataServicesException catch (e) {
      log('AppCubit: logoutUser: ${e.toString()}');
      emit(AppSInitial());
      _authService.clearAll();
      reaction(e.message);
    } on WebAuthenticationException catch (e) {
      log('AppCubit: logoutUser: ${e.toString()}');
      emit(AppSInitial());
      _authService.clearAll();
      reaction(e.message);
    }
  }

  // ----------------------------------
  //  Set account methods
  // ----------------------------------

  Future<void> setAddopter(CreatingAdopter adopter) async {
    try {
      emit(AppSLoading());
      var idUser = await _dataServices2.postAdopter(
        adopter,
        _authService.accessToken,
      );
      await _authService.setRole(UserRoles.adopter, idUser);
      await initAdopter();
    } on DataServicesUnloggedException catch (e) {
      log(e.message);
      emit(AppSAuthed());
      reaction(e.message);
    } on AuthServicesException catch (e) {
      log(e.message);
      emit(AppSAuthed());
      reaction(e.message);
    }
  }

  Future<void> setShelter(CreatingShelter shelter) async {
    try {
      emit(AppSLoading());
      var idUser = await _dataServices2.postShelter(
        shelter,
        _authService.accessToken,
      );
      await _authService.setRole(UserRoles.shelter, idUser);
      await initShelter();
    } on DataServicesUnloggedException catch (e) {
      log(e.message);
      emit(AppSAuthed());
      reaction(e.message);
    } on AuthServicesException catch (e) {
      log(e.message);
      emit(AppSAuthed());
      reaction(e.message);
    }
  }

  // ----------------------------------
  // Init account methods
  // ----------------------------------

  Future<void> initShelter() async {
    try {
      emit(AppSLoading());
      emit(
        AppSLoaded(
          userInfo: _authService.userInfo,
        ),
      );
      log('AppCubit: initShelter: init is done correctly.');
    } on DataServicesLoggedException catch (e) {
      _authService.clearAll();
      log(e.toString());
      emit(AppSInitial());
      reaction(e.message);
    }
  }

  Future<void> initAdopter() async {
    try {
      emit(AppSLoading());
      emit(
        AppSLoaded(
          userInfo: _authService.userInfo,
        ),
      );
      log('AppCubit: initAdopter: init is done correctly.');
    } on DataServicesLoggedException catch (e) {
      _authService.clearAll();
      log(e.toString());
      emit(AppSInitial());
      reaction(e.message);
    }
  }

  Future<void> initUnassigned() async {
    emit(AppSAuthed());
  }

  // ----------------------------------------------
  // ----------------------------------------------
  /*  METHODS FOR PROCESS OF ADOPTION MANAGEMENT */
  // ----------------------------------------------
  // ----------------------------------------------

  Future<List<Announcement2>?> getAnnouncements(
    Map<String, String> queryParam,
  ) async {
    if (state is AppSLoaded) {
      AppSLoaded st = state as AppSLoaded;
      //emit(AppSRefreshing());

      try {
        // make query
        List<Announcement2> newAnnouncements = [];
        if (st.userInfo.role == UserRoles.adopter) {
          newAnnouncements = await _dataServices2.getAnnouncements(
            _authService.accessToken,
            queryParm: queryParam,
          );
        } else {
          newAnnouncements = await _dataServices2.getShelterAnnouncements(
            _authService.accessToken,
            queryParm: queryParam,
          );
        }

        //emit(AppSLoaded());
        return newAnnouncements;
      } on DataServicesLoggedException catch (e) {
        reaction(e.message);
      }
    }

    return null;
  }

  Future<List<Pet2>?> getPets(
    Map<String, String> queryParam,
  ) async {
    if (state is AppSLoaded) {
      try {
        return await _dataServices2.getShelterPets(
          _authService.accessToken,
          queryParm: queryParam,
        );
      } on DataServicesLoggedException catch (e) {
        reaction(e.message);
      }
    }

    return null;
  }

  Future<List<Appplications2>?> getApplications(
    Map<String, String> queryParam,
  ) async {
    if (state is AppSLoaded) {
      try {
        return await _dataServices2.getApplications(
          _authService.accessToken,
          queryParm: queryParam,
        );
      } on DataServicesLoggedException catch (e) {
        reaction(e.message);
      }
    }

    return null;
  }

  // Methods to add pets by any shelter
  Future<void> addPet(CreatingPet2 pet) async {
    try {
      return await _dataServices2.postPet(_authService.accessToken, pet);
    } on DataServicesLoggedException catch (e) {
      reaction(e.message);
    }
  }

  // Methods to add announcement by any shelter
  Future<void> addAnnouncement(CreatingAnnouncement2 announcement) async {
    try {
      return await _dataServices2.postAnnouncement(
          _authService.accessToken, announcement);
    } on DataServicesLoggedException catch (e) {
      reaction(e.message);
    }
  }

  // Methods to add application by any adopter
  Future<void> addApplication(String announcementId) async {
    try {
      return await _dataServices2.postApplication(
          _authService.accessToken, announcementId, _authService.userInfo.id);
    } on DataServicesLoggedException catch (e) {
      reaction(e.message);
    }
  }

  // Methods to accept application by a shelter
  Future<void> acceptApplication(String applicationId) async {
    try {
      return await _dataServices2.putAcceptApplication(
          _authService.accessToken, applicationId);
    } on DataServicesLoggedException catch (e) {
      reaction(e.message);
    }
  }

  // Methods to reject application by a shelter
  Future<void> rejectApplication(String applicationId) async {
    try {
      return await _dataServices2.putRejectApplication(
          _authService.accessToken, applicationId);
    } on DataServicesLoggedException catch (e) {
      reaction(e.message);
    }
  }

  Future<void> putLikeAnnouncement(String announcementId, bool isLiked) async {
    try {
      return await _dataServices2.putLikeAnnouncement(
        _authService.accessToken,
        announcementId,
        isLiked,
      );
    } on DataServicesLoggedException catch (e) {
      reaction(e.message);
    }
  }
}
