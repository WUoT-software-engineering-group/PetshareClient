import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:pet_share/models/announcement.dart';
import 'package:pet_share/utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AnnouncementDetailsPage extends StatefulWidget {
  final Announcement2 announcement;
  final bool isAdoptingPerson;
  final Color color1;
  final Color color2;
  final Color color3;
  final void Function()? onPressed;

  const AnnouncementDetailsPage({
    required this.announcement,
    required this.isAdoptingPerson,
    required this.color1,
    required this.color2,
    required this.color3,
    required this.onPressed,
    super.key,
  });

  @override
  State<AnnouncementDetailsPage> createState() =>
      _AnnouncementDetailsPageState();
}

class _AnnouncementDetailsPageState extends State<AnnouncementDetailsPage> {
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

  @override
  Widget build(BuildContext context) {
    Widget followAnnouncement = LikeButton(
      size: 30,
      circleColor: CircleColor(start: widget.color2, end: widget.color1),
      bubblesColor: BubblesColor(
        dotPrimaryColor: widget.color2,
        dotSecondaryColor: widget.color3,
      ),
      likeBuilder: (bool isLiked) {
        return Icon(
          Icons.favorite,
          color: isLiked ? widget.color1 : Colors.grey[400],
          size: 30,
        );
      },
    );

    Widget countFollowers = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.favorite, size: 30, color: widget.color1),
        const Text('0',
            style:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.bold))
      ],
    );

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: widget.color1,
      body: Stack(
        children: [
          Positioned(
            /// image container
            left: 0,
            top: 0,
            child: Container(
              height: 370,
              width: width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/pupic.jpg'), fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned(
            /// gradient that spred image with background
            top: 200,
            child: Container(
              height: height - 200,
              width: width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      widget.color3,
                      widget.color2,
                      widget.color1,
                      widget.color1.withOpacity(0)
                    ],
                    stops: const [
                      0,
                      0.2,
                      0.72,
                      1
                    ]),
              ),
            ),
          ),
          Positioned(
            /// description container
            top: 300,
            width: width,
            height: height - 300,
            child: Container(
              margin: const EdgeInsets.all(25),
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(28),
                color: AppColors.field,
                child: Column(children: [
                  Padding(
                    /// Over divider
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
                    child: Column(children: [
                      Row(
                        /// first row with name and age of pet
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.announcement.pet.name.toUpperCase(),
                              style: TextStyle(
                                color: widget.color1,
                                fontWeight: FontWeight.w700,
                                fontSize: 21,
                              )),
                          Text(_ageOfPet(widget.announcement.pet.birthday),
                              style: TextStyle(
                                  color: widget.color1,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17))
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        /// second row with breed, species and sex of pet
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '${widget.announcement.pet.species} : ${widget.announcement.pet.breed}',
                              style: TextStyle(
                                  color: widget.color1.withAlpha(200),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15)),
                          Text('male',
                              style: TextStyle(
                                  color: widget.color1.withAlpha(200),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15))
                        ],
                      ),
                    ]),
                  ),
                  const Divider(
                    height: 0,
                    thickness: 3,
                  ),
                  Expanded(
                    /// belove divider
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              /// Calendar and (counter/favourite)
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  /// Calendar
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/calendar_cloud.png'),
                                      width: 40,
                                      height: 40,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      _convertDateTime(
                                          widget.announcement.creationDate),
                                      style: const TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                // (counter/favourite)
                                widget.isAdoptingPerson
                                    ? followAnnouncement
                                    : countFollowers,
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Expanded(
                              /// description of announcement
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Text(
                                  '${widget.announcement.title.toUpperCase()}\n${widget.announcement.description}',
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 117, 117, 117),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            BarOptions(
                              /// low bar with navigation options
                              color: widget.color2,
                              email: widget.announcement.pet.shelter.email,
                              phoneNumber:
                                  widget.announcement.pet.shelter.phoneNumber,
                              isAdoptingPerson: widget.isAdoptingPerson,
                              onPressed: widget.onPressed,
                            ),
                          ]),
                    ),
                  )
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BarOptions extends StatelessWidget {
  final Color color;
  final String email;
  final String phoneNumber;
  final bool isAdoptingPerson;
  final void Function()? onPressed;

  const BarOptions({
    required this.color,
    required this.email,
    required this.phoneNumber,
    required this.isAdoptingPerson,
    this.onPressed,
    super.key,
  });

  Widget _menuAdoptingPerson() {
    return Row(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(), backgroundColor: color),
          onPressed: _makingCall,
          child: const Icon(Icons.phone),
        ),
        const SizedBox(
          width: 10,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(), backgroundColor: color),
          onPressed: onPressed,
          child: const Icon(Icons.check),
        ),
        const SizedBox(
          width: 10,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(), backgroundColor: color),
          onPressed: _sendingEmails,
          child: const Icon(Icons.mail),
        ),
      ],
    );
  }

  Future<void> _makingCall() async {
    var url = Uri.parse("tel:+48$phoneNumber");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _sendingEmails() async {
    var url = Uri.parse("mailto:$email");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _menuShelter() {
    return Row(children: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(), backgroundColor: color),
        onPressed: () {},
        child: const Icon(Icons.edit),
      ),
      const SizedBox(
        width: 10,
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(), backgroundColor: color),
        onPressed: () {},
        child: const Icon(Icons.delete),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(), backgroundColor: color),
        onPressed: () => Navigator.pop(context),
        child: const Text('Back'),
      ),
      isAdoptingPerson ? _menuAdoptingPerson() : _menuShelter(),
    ]);
  }
}
