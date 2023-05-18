// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:pet_share/models/announcement.dart';
// import 'package:pet_share/models/user_info.dart';
// import 'package:pet_share/services/data_services.dart';

// part 'announcements_state.dart';

// class AnnouncementsCubit extends Cubit<AnnouncementsState> {
//   AnnouncementsCubit({required List<Announcement2> announcements})
//       : super(AnnouncementsSInitial()) {
//     emit(AnnouncementsSLoaded(announcements: announcements));
//   }

//   final DataServices _dataServices = DataServices();
//   final DataServices2 _dataServices2 = DataServices2();

//   Future<void> refresh(UserInfo user) async {
//     if (state is AnnouncementsSLoaded) {
//       emit(AnnouncementsSRefreshing());
//       var announcements =
//           await _dataServices2.getAnnouncements(user.accessToken);
//       emit(AnnouncementsSLoaded(announcements: announcements));
//     }
//   }

//   Future<void> add(AnnouncementPost post, UserInfo user) async {
//     if (state is AnnouncementsSLoaded) {
//       await _dataServices.addAnnouncement(post, user.accessToken);
//     }
//   }
// }
