import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_share/models/announcement.dart';
import 'package:pet_share/services/data_services.dart';

part 'announcements_state.dart';

class AnnouncementsCubit extends Cubit<AnnouncementsState> {
  AnnouncementsCubit({required List<Announcement> announcements})
      : super(AnnouncementsSInitial()) {
    emit(AnnouncementsSLoaded(announcements: announcements));
  }

  final DataServices _dataServices = DataServices();

  Future<void> refresh() async {
    if (state is AnnouncementsSLoaded) {
      emit(AnnouncementsSRefreshing());
      var announcements = await _dataServices.getAnnouncements();
      emit(AnnouncementsSLoaded(announcements: announcements));
    }
  }
}
