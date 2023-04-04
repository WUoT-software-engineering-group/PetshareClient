import 'package:flutter/material.dart';
import 'package:pet_share/models/announcement.dart';
import 'package:pet_share/utils/app_colors.dart';

class AnnouncementDetailsPage extends StatefulWidget {
  final Announcement announcement;

  const AnnouncementDetailsPage({required this.announcement, Key? key})
      : super(key: key);

  @override
  State<AnnouncementDetailsPage> createState() =>
      _AnnouncementDetailsPageState();
}

class _AnnouncementDetailsPageState extends State<AnnouncementDetailsPage> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.5, horizontal: 25),
                // delete and edit action on tile
                child: Material(
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
              ),
              Text(
                widget.announcement.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.5, horizontal: 25),
                // delete and edit action on tile
                child: Material(
                  elevation: 6,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
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
                          const SizedBox(height: 10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  children: [
                                    Text(widget.announcement.pet.species),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(widget.announcement.pet.breed),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(widget.announcement.pet.birthday
                                        .toString()),
                                  ],
                                )
                              ]),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: Text(widget.announcement.description))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Material(
                elevation: 6,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: AppColors.buttons,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                      onTap: () => setState(() => expanded = !expanded),
                      child: DecoratedBox(
                          decoration: const BoxDecoration(
                            color: AppColors.buttons,
                          ),
                          child: AnimatedCrossFade(
                            duration: const Duration(milliseconds: 200),
                            crossFadeState: expanded
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                            firstChild: Column(
                              children: [
                                const Text(
                                  "Show contact details",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: 100,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      Icon(
                                        Icons.phone,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.mail,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            secondChild: SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: const [
                                      Text(
                                        "Phone number:",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "E-mail address:",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(width: 5),
                                  Column(
                                    children: [
                                      const Text(
                                        // widget.announcement.author.phoneNumer, // problem, nullowalne
                                        "999 999 999",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        widget.announcement.author.email,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ))),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
