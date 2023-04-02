part of 'announcements_cubit.dart';

abstract class AnnouncementsState extends Equatable {
  const AnnouncementsState();

  @override
  List<Object> get props => [];
}

class AnnouncementsSInitial extends AnnouncementsState {}

class AnnouncementsSLoaded extends AnnouncementsState {
  final List<Announcement> announcements;

  const AnnouncementsSLoaded({required this.announcements});

  @override
  List<Object> get props => [announcements];
}
