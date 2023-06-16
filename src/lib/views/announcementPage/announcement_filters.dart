import 'package:flutter/material.dart';
import 'package:pet_share/utils/app_colors.dart';
import 'package:pet_share/utils/form_field.dart';
import 'package:pet_share/views/announcementPage/rounded_container.dart';

class FilterMe {
  final String species;
  final String breeds;
  final String cities;
  final String shelterNames;

  final int minAge;
  final int maxAge;

  final bool isChecked;

  FilterMe({
    this.species = '',
    this.breeds = '',
    this.cities = '',
    this.shelterNames = '',
    this.minAge = 0,
    this.maxAge = 0,
    this.isChecked = false,
  });

  Map<String, String> giveParameterQueries() {
    Map<String, String> maps = {};
    if (species != '') {
      maps['species'] = species;
    }

    if (breeds != '') {
      maps['breeds'] = breeds;
    }

    if (cities != '') {
      maps['cities'] = cities;
    }

    if (shelterNames != '') {
      maps['shelternames'] = shelterNames;
    }

    if (minAge != 0) {
      maps['minAge'] = minAge.toString();
    }

    if (maxAge != 0) {
      maps['maxAge'] = maxAge.toString();
    }

    if (isChecked == true) {
      maps['IsLiked'] = 'true';
    }

    return maps;
  }
}

class AnnouncementFilters extends StatefulWidget {
  const AnnouncementFilters({super.key});

  @override
  State<AnnouncementFilters> createState() => _AnnouncementFiltersState();
}

class _AnnouncementFiltersState extends State<AnnouncementFilters> {
  final Color textColor = const Color.fromARGB(255, 63, 63, 63);
  final _formKey = GlobalKey<FormState>();

  late String species;
  late String breeds;
  late String cities;
  late String shelternames;

  late int minAge;
  late int maxAge;

  late bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            'Filters',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: AppColors.buttons,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    // Information about pet
                    RoundedContainer(
                      logo: const Text(
                        'Pet',
                        style: TextStyle(
                          color: AppColors.buttons,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 5,
                      ),
                      child: Column(
                        children: [
                          MyFormFild2(
                            validator: (val) => null,
                            save: (val) {
                              species = val ?? '';
                            },
                            label: 'Species',
                            fontColor: textColor,
                            labelColor: AppColors.navigation,
                            activeBorder: AppColors.navigation,
                            disactiveBorder: AppColors.buttons,
                          ),
                          MyFormFild2(
                            validator: (val) => null,
                            save: (val) {
                              breeds = val ?? '';
                            },
                            label: 'Breeds',
                            fontColor: textColor,
                            labelColor: AppColors.navigation,
                            activeBorder: AppColors.navigation,
                            disactiveBorder: AppColors.buttons,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: MyFormFild2(
                                  validator: (val) {
                                    if (val == null) return null;
                                    if (val == '') return null;

                                    try {
                                      int.parse(val);
                                    } catch (_) {
                                      return 'It must be a number';
                                    }

                                    return null;
                                  },
                                  save: (val) {
                                    if (val == null) {
                                      minAge = 0;
                                    } else if (val == '') {
                                      minAge = 0;
                                    } else {
                                      minAge = int.parse(val);
                                    }
                                  },
                                  label: 'Min Age',
                                  fontColor: textColor,
                                  labelColor: AppColors.navigation,
                                  activeBorder: AppColors.navigation,
                                  disactiveBorder: AppColors.buttons,
                                ),
                              ),
                              Expanded(
                                child: MyFormFild2(
                                  validator: (val) {
                                    if (val == null) return null;
                                    if (val == '') return null;

                                    try {
                                      int.parse(val);
                                    } catch (_) {
                                      return 'It must be a number';
                                    }

                                    return null;
                                  },
                                  save: (val) {
                                    if (val == null) {
                                      maxAge = 0;
                                    } else if (val == '') {
                                      maxAge = 0;
                                    } else {
                                      maxAge = int.parse(val);
                                    }
                                  },
                                  label: 'Max Age',
                                  fontColor: textColor,
                                  labelColor: AppColors.navigation,
                                  activeBorder: AppColors.navigation,
                                  disactiveBorder: AppColors.buttons,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 21,
                    ),

                    // General information
                    RoundedContainer(
                      logo: const Text(
                        'General',
                        style: TextStyle(
                          color: AppColors.buttons,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 5,
                      ),
                      child: Column(children: [
                        MyFormFild2(
                          validator: (val) => null,
                          save: (val) {
                            cities = val ?? '';
                          },
                          label: 'City',
                          fontColor: textColor,
                          labelColor: AppColors.navigation,
                          activeBorder: AppColors.navigation,
                          disactiveBorder: AppColors.buttons,
                        ),
                        MyFormFild2(
                          validator: (val) => null,
                          save: (val) {
                            shelternames = val ?? '';
                          },
                          label: 'Shelter Name',
                          fontColor: textColor,
                          labelColor: AppColors.navigation,
                          activeBorder: AppColors.navigation,
                          disactiveBorder: AppColors.buttons,
                        ),
                      ]),
                    ),
                    const SizedBox(
                      height: 21,
                    ),

                    // Information of user's choice
                    RoundedContainer(
                      logo: const Text(
                        'IsLiked',
                        style: TextStyle(
                          color: AppColors.buttons,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 5,
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            fillColor: MaterialStateColor.resolveWith(
                              (Set<MaterialState> states) {
                                return AppColors.buttons;
                              },
                            ),
                            value: isChecked,
                            onChanged: (newVal) {
                              setState(() {
                                isChecked = newVal ?? false;
                              });
                            },
                          ),
                          const Text(
                            'Only liked pets',
                            style: TextStyle(color: AppColors.buttons),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 21,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Back button
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              var result = FilterMe(
                                species: species,
                                breeds: breeds,
                                cities: cities,
                                shelterNames: shelternames,
                                minAge: minAge,
                                maxAge: maxAge,
                                isChecked: isChecked,
                              );

                              Navigator.of(context).pop(result);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.buttons,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25))),
                          child: const Text(
                            'Filter Me',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        // Clear button
                        ElevatedButton(
                          onPressed: () {
                            var result = FilterMe();
                            Navigator.of(context).pop(result);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.buttons,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25))),
                          child: const Text(
                            'Clear',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        // Filter button
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(null),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.buttons,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25))),
                          child: const Text(
                            'Back',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
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
