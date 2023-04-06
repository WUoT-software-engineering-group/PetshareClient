import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:pet_share/models/announcement.dart';
import 'package:pet_share/views/announcementPage/announcement_details.dart';
import 'package:pet_share/views/announcementPage/labeled_icon.dart';
import 'package:pet_share/utils/app_colors.dart';

class PetTile extends StatefulWidget {
  final Announcement announcement;
  final bool isFollowIcon;

  const PetTile(this.announcement, {this.isFollowIcon = false, Key? key})
      : super(key: key);

  @override
  State<PetTile> createState() => _PetTileState();
}

class _PetTileState extends State<PetTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 25),
      // delete and edit action on tile
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        child: Material(
          elevation: 6,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AnnouncementDetailsPage(
                          announcement: widget.announcement,
                          contactButtons: widget.isFollowIcon,
                        )),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                height: 315,
                child: Column(
                  children: [
                    Container(
                      height: 225,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/pupic.jpg'))),
                    ),
                    DescriptionTile(
                        announcement: widget.announcement,
                        isFollowIcon: widget.isFollowIcon),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DescriptionTile extends StatelessWidget {
  final Announcement announcement;
  final bool isFollowIcon;
  const DescriptionTile(
      {required this.announcement, required this.isFollowIcon, Key? key})
      : super(key: key);

  String _ageOfPet(DateTime dateTime) {
    int years = DateTime.now().year - dateTime.year;
    if (years == 0) {
      int months = DateTime.now().month - dateTime.month;
      if (months == 1) return '$months month';
      return '$months months';
    }

    if (years == 1) return '$years year';
    return '$years years';
  }

  @override
  Widget build(BuildContext context) {
    Widget followAnnouncement = LikeButton(
      size: 40,
      circleColor: CircleColor(
          start: AppColors.buttons, end: AppColors.smallElements['reddish']!),
      bubblesColor: BubblesColor(
        dotPrimaryColor: AppColors.buttons,
        dotSecondaryColor: AppColors.smallElements['reddish']!,
      ),
      likeBuilder: (bool isLiked) {
        return Icon(
          Icons.favorite,
          color:
              isLiked ? AppColors.animationColor['center'] : Colors.grey[400],
          size: 40,
        );
      },
    );

    Widget countFollowers = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.favorite,
            size: 30, color: AppColors.smallElements['reddish']),
        const Text('0', style: TextStyle(fontSize: 16))
      ],
    );

    return Expanded(
      child: Container(
          padding: const EdgeInsets.fromLTRB(25, 8, 0, 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: [
                          TextSpan(
                            text: announcement.pet.name,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 70, 70, 70),
                                fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: '    ${_ageOfPet(announcement.pet.birthday)}',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: AppColors.smallElements['reddish'],
                          size: 15,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          DateFormat.yMMMd().format(announcement.creationDate),
                          style: TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        LabeledIcon(Icons.pets, announcement.pet.breed),
                        const LabeledIcon(Icons.female, 'Female'),
                      ],
                    )
                  ],
                ),
              ),
              const VerticalDivider(
                thickness: 2,
                indent: 10,
                endIndent: 10,
                width: 0,
              ),
              SizedBox(
                width: 120,
                child: Center(
                  child: isFollowIcon ? followAnnouncement : countFollowers,
                ),
              )
            ],
          )),
    );
  }
}
