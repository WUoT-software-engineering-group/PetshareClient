part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppSInitial extends AppState {}

class AppSLoading extends AppState {}

class AppSLoaded extends AppState {
  final List<Announcement> announcements;

  const AppSLoaded(this.announcements);

  @override
  List<Object> get props => [announcements];
}
