part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

/// The first state which is responsible
/// for showing hello page.
class AppSInitial extends AppState {}

/// This state indicates the user has
/// unassigned role.
class AppSAuthed extends AppState {}

/// This state is using to wait for
/// loading all user's data after logging in.
class AppSLoading extends AppState {}

/// This state is related with user manger
/// part of data flow in app.
class AppSLoaded extends AppState {
  final List<Announcement2> announcements;
  final List<Appplications2> applications;
  final List<Pet2> pets;
  final UserInfo userInfo;

  const AppSLoaded({
    required this.announcements,
    required this.applications,
    required this.pets,
    required this.userInfo,
  });

  @override
  List<Object> get props => [announcements, applications, pets, userInfo];
}

class AppSRefreshing extends AppState {
  // final List<Announcement2>? announcements;
  // final List<Appplications2>? applications;
  // final List<Pet2>? pets;

  // const AppSRefreshing({
  //   // required this.announcements,
  //   // required this.applications,
  //   // required this.pets,
  // });

  // factory AppSRefreshing.announcements(
  //   List<Appplications2> applications,
  //   List<Pet2> pets,
  // ) {
  //   return AppSRefreshing(
  //     announcements: null,
  //     applications: applications,
  //     pets: pets,
  //   );
  // }

  // factory AppSRefreshing.applications(
  //   List<Announcement2> announcements,
  //   List<Pet2> pets,
  // ) {
  //   return AppSRefreshing(
  //     announcements: announcements,
  //     applications: null,
  //     pets: pets,
  //   );
  // }

  // factory AppSRefreshing.pets(
  //   List<Announcement2> announcements,
  //   List<Appplications2> applications,
  // ) {
  //   return AppSRefreshing(
  //     announcements: announcements,
  //     applications: applications,
  //     pets: null,
  //   );
  // }

  @override
  List<Object> get props {
    List<Object> elements = [];
    // if (announcements != null) elements.add(announcements!);
    // if (applications != null) elements.add(applications!);
    // if (pets != null) elements.add(pets!);

    return elements;
  }
}
