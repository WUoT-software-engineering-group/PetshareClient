import 'dart:developer';

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

  // ----------------------------------
  // Gets & Sets
  // ----------------------------------

  String get getEmail => _authService.getEmail;

  // ----------------------------------
  // Contstructors
  // ----------------------------------

  AppCubit(this._dataServices2, this._authService) : super(AppSInitial());

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
    emit(AppSInitial());
  }

  // ----------------------------------
  //  Set account methods
  // ----------------------------------

  Future<void> setAddopter(CreatingAdopter adopter) async {
    emit(AppSLoading());
    var idUser = await _dataServices2.postAdopter(
      adopter,
      _authService.accessToken,
    );
    await _authService.setRole(UserRoles.adopter, idUser);
    await initAdopter();
  }

  Future<void> setShelter(CreatingShelter shelter) async {
    emit(AppSLoading());
    var idUser = await _dataServices2.postShelter(
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
      var resAnn = await _dataServices2
          .getShelterAnnouncements(_authService.accessToken);
      var resApp =
          await _dataServices2.getApplications(_authService.accessToken);
      var resPet =
          await _dataServices2.getShelterPets(_authService.accessToken);
      emit(
        AppSLoaded(
          announcements: resAnn,
          applications: resApp,
          pets: resPet,
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
      var resAnn =
          await _dataServices2.getAnnouncements(_authService.accessToken);
      emit(
        AppSLoaded(
          announcements: resAnn,
          applications: const [],
          pets: const [],
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

  // ----------------------------------------------
  // ----------------------------------------------
  /*  METHODS FOR PROCESS OF ADOPTION MANAGEMENT */
  // ----------------------------------------------
  // ----------------------------------------------

  Future<void> refreshPets() async {
    if (state is AppSLoaded) {
      AppSLoaded st = state as AppSLoaded;
      List<Appplications2> applications = st.applications;
      List<Announcement2> announcements = st.announcements;
      UserInfo userInfo = st.userInfo;

      // change state
      emit(AppSRefreshing());

      // make query
      var pets = await _dataServices2.getShelterPets(_authService.accessToken);

      // change state
      emit(
        AppSLoaded(
          announcements: announcements,
          applications: applications,
          pets: pets,
          userInfo: userInfo,
        ),
      );
    }
  }

  Future<void> refreshAnnouncements() async {
    if (state is AppSLoaded) {
      AppSLoaded st = state as AppSLoaded;
      List<Appplications2> applications = st.applications;
      List<Pet2> pets = st.pets;
      UserInfo userInfo = st.userInfo;

      // change state
      emit(AppSRefreshing());

      // make query
      var announcements = <Announcement2>[];
      if (userInfo.role == UserRoles.adopter) {
        announcements =
            await _dataServices2.getAnnouncements(_authService.accessToken);
      } else {
        announcements = await _dataServices2
            .getShelterAnnouncements(_authService.accessToken);
      }

      // change state
      emit(
        AppSLoaded(
          announcements: announcements,
          applications: applications,
          pets: pets,
          userInfo: userInfo,
        ),
      );
    }
  }

  Future<void> refreshApplications() async {
    if (state is AppSLoaded) {
      AppSLoaded st = state as AppSLoaded;
      List<Announcement2> announcements = st.announcements;
      List<Pet2> pets = st.pets;
      UserInfo userInfo = st.userInfo;

      // change state
      emit(AppSRefreshing());

      // make query
      var applications =
          await _dataServices2.getApplications(_authService.accessToken);

      // change state
      emit(
        AppSLoaded(
          announcements: announcements,
          applications: applications,
          pets: pets,
          userInfo: userInfo,
        ),
      );
    }
  }

  // Methods to add pets by any shelter
  Future<bool> addPet(CreatingPet2 pet) async {
    return await _dataServices2.postPet(_authService.accessToken, pet);
  }

  // Methods to add announcement by any shelter
  Future<bool> addAnnouncement(CreatingAnnouncement2 announcement) async {
    return await _dataServices2.postAnnouncement(
        _authService.accessToken, announcement);
  }

  // Methods to add application by any adopter
  Future<bool> addApplication(String announcementId) async {
    return await _dataServices2.postApplication(
        _authService.accessToken, announcementId, _authService.userInfo.id);
  }

  // Methods to accept application by a shelter
  Future<bool> acceptApplication(String applicationId) async {
    return await _dataServices2.putAcceptApplication(
        _authService.accessToken, applicationId);
  }

  // Methods to reject application by a shelter
  Future<bool> rejectApplication(String applicationId) async {
    return await _dataServices2.putRejectApplication(
        _authService.accessToken, applicationId);
  }
}
