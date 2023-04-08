import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:pet_share/models/announcement.dart';
import 'package:pet_share/utils/app_colors.dart';
import 'package:pet_share/views/announcementPage/announcement_details.dart';

class PetTile extends StatefulWidget {
  final Announcement announcement;
  final bool descriptionOnLeft;
  final bool isFollowIcon;
  final List<Color> colors;

  /// colors - colors of description 0: text 1: ring 2: bubbles
  const PetTile(
      {required this.announcement,
      required this.isFollowIcon,
      required this.descriptionOnLeft,
      required this.colors,
      super.key});

  @override
  State<PetTile> createState() => _PetTileState();
}

class _PetTileState extends State<PetTile> {
  Widget _photoBlock() {
    return Expanded(
        flex: 5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(23),
          child: Container(
            height: 220,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage('assets/pupic.jpg'))),
          ),
        ));
  }

  Widget _descriptionBlock(bool isLeft) {
    return Expanded(
        flex: 7,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
          child: Material(
            color: AppColors.field,
            borderRadius: _raundedDescription(isLeft),
            elevation: 6,
            child: InkWell(
              borderRadius: _raundedDescription(isLeft),
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
                borderRadius: _raundedDescription(isLeft),
                child: SizedBox(
                    height: 150,
                    child: PetDescription(
                      announcement: widget.announcement,
                      isFollowIcon: widget.isFollowIcon,
                      color: widget.colors[0],
                      ring: widget.colors[1],
                      bubbles: widget.colors[2],
                    )),
              ),
            ),
          ),
        ));
  }

  BorderRadius _raundedDescription(bool isLeft) {
    if (isLeft) {
      return const BorderRadius.horizontal(left: Radius.circular(28));
    }

    return const BorderRadius.horizontal(right: Radius.circular(28));
  }

  Widget _putElements() {
    if (widget.descriptionOnLeft) {
      return Row(children: [
        _descriptionBlock(true),
        _photoBlock(),
      ]);
    }

    return Row(children: [
      _photoBlock(),
      _descriptionBlock(false),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12.5),
      child: _putElements(),
    );
  }
}

class PetDescription extends StatelessWidget {
  final Announcement announcement;
  final bool isFollowIcon;
  final Color color;
  final Color ring;
  final Color bubbles;

  /// announcement - display infromation in this class
  const PetDescription(
      {required this.announcement,
      required this.isFollowIcon,
      required this.color,
      required this.ring,
      required this.bubbles,
      super.key});

  String _ageOfPet(DateTime dateTime) {
    int years = DateTime.now().year - dateTime.year;
    if (years == 0) {
      int months = DateTime.now().month - dateTime.month;

      if (months == 0) {
        int days = DateTime.now().day - dateTime.day;
        if (days == 1) return '$days day old';
        return '$days days old';
      }

      if (months == 1) return '$months month old';
      return '$months months old';
    }

    if (years == 1) return '$years year old';
    return '$years years old';
  }

  @override
  Widget build(BuildContext context) {
    Widget followAnnouncement = LikeButton(
      size: 26,
      circleColor: CircleColor(start: ring, end: color),
      bubblesColor: BubblesColor(
        dotPrimaryColor: ring,
        dotSecondaryColor: bubbles,
      ),
      likeBuilder: (bool isLiked) {
        return Icon(
          Icons.favorite,
          color: isLiked ? color : Colors.grey[400],
          size: 26,
        );
      },
    );

    Widget countFollowers = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.favorite, size: 21, color: color),
        const Text('0',
            style: TextStyle(
                color: Color.fromARGB(200, 141, 139, 139),
                fontWeight: FontWeight.bold))
      ],
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 25, 25, 25),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              announcement.pet.name,
              style: TextStyle(
                  color: color, fontWeight: FontWeight.bold, fontSize: 21),
            ),
            isFollowIcon ? followAnnouncement : countFollowers,
          ],
        ),
        const SizedBox(
          height: 14,
        ),
        Text(
          'bread: ${announcement.pet.breed}',
          style: const TextStyle(
              color: Color.fromARGB(255, 121, 119, 119),
              fontWeight: FontWeight.bold,
              fontSize: 14),
        ),
        const SizedBox(
          height: 7,
        ),
        Text(
          _ageOfPet(announcement.pet.birthday),
          style: const TextStyle(
            color: Color.fromARGB(200, 141, 139, 139),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Row(
          children: [
            Icon(
              Icons.calendar_month,
              color: color,
              size: 16,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              DateFormat.yMMMd().format(announcement.creationDate),
              style: const TextStyle(
                  color: Color.fromARGB(255, 121, 119, 119),
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            )
          ],
        ),
      ]),
    );
  }
}
