import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:pet_share/models/announcement.dart';
import 'package:pet_share/utils/app_colors.dart';
import 'package:pet_share/views/announcementPage/announcement_details.dart';

class AnnouncementTile extends StatefulWidget {
  final Announcement2 announcement;
  final bool descriptionOnLeft;
  final bool isAdoptingPerson;
  final List<Color> colors;
  final void Function()? onPressed;
  final void Function(String, bool) addLike;

  /// colors - colors of description 0: text 1: ring 2: bubbles
  const AnnouncementTile({
    required this.announcement,
    required this.isAdoptingPerson,
    required this.descriptionOnLeft,
    required this.colors,
    required this.onPressed,
    required this.addLike,
    super.key,
  });

  @override
  State<AnnouncementTile> createState() => _AnnouncementTileState();
}

class _AnnouncementTileState extends State<AnnouncementTile> {
  ImageProvider getImage(String photo) {
    if (photo == '') {
      return const AssetImage('assets/pupic.jpg');
    }

    return NetworkImage(photo);
  }

  Widget _photoBlock() {
    return Expanded(
      flex: 5,
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(23),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(23),
          child: Container(
            height: 220,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: getImage(widget.announcement.pet.photoUrl),
              ),
            ),
          ),
        ),
      ),
    );
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
                MaterialPageRoute(builder: (context) {
                  return AnnouncementDetailsPage(
                    isAdoptingPerson: widget.isAdoptingPerson,
                    announcement: widget.announcement,
                    color1: widget.colors[0],
                    color2: widget.colors[1],
                    color3: widget.colors[2],
                    onPressed: widget.onPressed,
                    addLike: widget.addLike,
                  );
                }),
              );
            },
            child: ClipRRect(
              borderRadius: _raundedDescription(isLeft),
              child: SizedBox(
                  height: 150,
                  child: PetDescription(
                    announcement: widget.announcement,
                    isFollowIcon: widget.isAdoptingPerson,
                    color: widget.colors[0],
                    ring: widget.colors[1],
                    bubbles: widget.colors[2],
                    addLike: widget.addLike,
                  )),
            ),
          ),
        ),
      ),
    );
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
  final Announcement2 announcement;
  final bool isFollowIcon;
  final Color color;
  final Color ring;
  final Color bubbles;
  final void Function(String, bool) addLike;

  /// announcement - display infromation in this class
  const PetDescription({
    required this.announcement,
    required this.isFollowIcon,
    required this.color,
    required this.ring,
    required this.bubbles,
    required this.addLike,
    super.key,
  });

  String _ageOfPet(DateTime? dateTime) {
    if (dateTime == null) return "";
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

  String _convertDateTime(DateTime? dateTime) {
    if (dateTime == null) return "";

    return DateFormat.yMMMd().format(dateTime);
  }

  Widget followAnnouncement(bool isFollowIcon) {
    if (!isFollowIcon) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite, size: 21, color: color),
          const Text(
            '0',
            style: TextStyle(
              color: Color.fromARGB(200, 141, 139, 139),
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      );
    }

    return LikeButton(
      size: 26,
      circleColor: CircleColor(start: ring, end: color),
      bubblesColor: BubblesColor(
        dotPrimaryColor: ring,
        dotSecondaryColor: bubbles,
      ),
      isLiked: announcement.isLiked,
      likeBuilder: (bool isLiked) {
        if (isLiked != announcement.isLiked) {
          addLike(announcement.id, isLiked);
          announcement.isLiked = isLiked;
        }
        return Icon(
          Icons.favorite,
          color: isLiked ? color : Colors.grey[400],
          size: 26,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 25, 25, 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                announcement.pet.name,
                style: TextStyle(
                    color: color, fontWeight: FontWeight.bold, fontSize: 21),
              ),
              followAnnouncement(isFollowIcon),
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
              fontSize: 10,
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
                _convertDateTime(announcement.creationDate),
                style: const TextStyle(
                    color: Color.fromARGB(255, 121, 119, 119),
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              )
            ],
          ),
        ],
      ),
    );
  }
}
