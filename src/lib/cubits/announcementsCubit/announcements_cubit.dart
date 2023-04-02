import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_share/models/announcement.dart';

part 'announcements_state.dart';

class AnnouncementsCubit extends Cubit<AnnouncementsState> {
  AnnouncementsCubit({required List<Announcement> announcements})
      : super(AnnouncementsSInitial()) {
    emit(AnnouncementsSLoaded(announcements: announcements));
  }
}
