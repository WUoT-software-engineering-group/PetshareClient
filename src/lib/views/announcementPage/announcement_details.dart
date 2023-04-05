import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_share/models/announcement.dart';
import 'package:pet_share/utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AnnouncementDetailsPage extends StatefulWidget {
  final bool contactButtons;
  final Announcement announcement;

  const AnnouncementDetailsPage(
      {required this.announcement, required this.contactButtons, Key? key})
      : super(key: key);

  @override
  State<AnnouncementDetailsPage> createState() =>
      _AnnouncementDetailsPageState();
}

class _AnnouncementDetailsPageState extends State<AnnouncementDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 25),
            child: Column(
              children: [
                Material(
                  elevation: 6,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: Colors.white,
                      height: 230,
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/pupic.jpg'))),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12.5,
                ),
                Text(
                  widget.announcement.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 12.5,
                ),
                Material(
                  elevation: 6,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Text(
                              widget.announcement.pet.name,
                              style: const TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              // tu trzeba ifa dodać
                              height: 20,
                              child: Icon(
                                Icons.pets,
                                color: Colors.green,
                              ),
                            ),
                            const Divider(
                              thickness: 2,
                              indent: 40,
                              endIndent: 40,
                              height: 30,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text("Species:"),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Breed:"),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Birthday:")
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(widget.announcement.pet.species),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(widget.announcement.pet.breed),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(DateFormat.yMMMd().format(
                                          widget.announcement.pet.birthday)),
                                    ],
                                  )
                                ]),
                            const Divider(
                              thickness: 2,
                              indent: 40,
                              endIndent: 40,
                              height: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(widget.announcement.description),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12.5,
                ),
                Material(
                    elevation: 6,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: OptionButtons(
                            announcement: widget.announcement,
                            contactButtons: widget.contactButtons,
                          ),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 12.5,
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    backgroundColor: AppColors.buttons,
                    foregroundColor: Colors.white,
                  ),
                  child: const Icon(Icons.home, size: 30),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OptionButtons extends StatelessWidget {
  final Announcement announcement;
  final bool contactButtons;
  const OptionButtons(
      {required this.announcement, required this.contactButtons, super.key});

  Future<void> _makingCall() async {
    var url = Uri.parse("tel:+48${announcement.author.phoneNumer}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _sendingEmails() async {
    var url = Uri.parse("mailto:${announcement.author.email}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _contactButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          elevation: 6,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: AppColors.buttons,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  width: 110,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        iconSize: 30,
                        onPressed: _makingCall,
                        icon: const Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: _sendingEmails,
                        iconSize: 30,
                        icon: const Icon(
                          Icons.mail,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Material(
          elevation: 6,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: AppColors.buttons,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              onPressed: () {},
              iconSize: 30,
              icon: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _editButton() {
    return Material(
        elevation: 6,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: AppColors.buttons,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: IconButton(
            onPressed: () {},
            iconSize: 30,
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return contactButtons ? _contactButtons() : _editButton();
  }
}
