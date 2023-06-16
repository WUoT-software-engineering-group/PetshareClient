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
  final UserInfo userInfo;

  const AppSLoaded({
    required this.userInfo,
  });

  @override
  List<Object> get props => [userInfo];
}

class AppSRefreshing extends AppState {
  @override
  List<Object> get props {
    List<Object> elements = [];

    return elements;
  }
}
