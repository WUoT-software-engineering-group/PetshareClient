import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pet_share/models/pet.dart';
import 'package:pet_share/utils/app_colors.dart';
import 'package:pet_share/utils/form_field.dart';
import 'package:image_picker/image_picker.dart';

class PetFrom extends StatefulWidget {
  const PetFrom({super.key});

  @override
  State<PetFrom> createState() => _PetFromState();
}

class _PetFromState extends State<PetFrom> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  late String name;

  late String species;

  late String breed;

  late SexOfPet sex = SexOfPet.male;

  late DateTime birthday;

  late String description;

  late XFile? image;

  @override
  void initState() {
    super.initState();
    image = null;
    birthday = DateTime.now();
  }

  late Color myCOlor = Colors.black54;

  final lastStep = 2;

  /// Max index of steps
  List<Step> getSteps() => [
        Step(
          state: stateOfStep(0),
          isActive: _currentStep >= 0,
          title: const Text('Information'),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyFormFild2(
                validator: (val) => null,
                save: (val) {
                  name = val ?? '';
                },
                label: "Name",
                labelColor: AppColors.buttons,
                fontColor: myCOlor,
                activeBorder: myCOlor,
                disactiveBorder: myCOlor,
              ),
              MyFormFild2(
                validator: (val) => null,
                save: (val) {
                  species = val ?? '';
                },
                label: "Species",
                labelColor: AppColors.buttons,
                fontColor: myCOlor,
                activeBorder: myCOlor,
                disactiveBorder: myCOlor,
              ),
              MyFormFild2(
                validator: (val) => null,
                save: (val) {
                  breed = val ?? '';
                },
                label: "Breed",
                labelColor: AppColors.buttons,
                fontColor: myCOlor,
                activeBorder: myCOlor,
                disactiveBorder: myCOlor,
              ),
              Stack(
                children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: myCOlor,
                        width: 3,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Row(
                              children: [
                                Radio(
                                  fillColor:
                                      MaterialStateColor.resolveWith((states) {
                                    if (states
                                        .contains(MaterialState.selected)) {
                                      return AppColors.buttons;
                                    }

                                    return myCOlor;
                                  }),
                                  value: SexOfPet.male,
                                  groupValue: sex,
                                  onChanged: (value) {
                                    setState(() {
                                      sex = value ?? SexOfPet.unknown;
                                    });
                                  },
                                ),
                                Text(
                                  'male',
                                  style: GoogleFonts.varelaRound(
                                    color: Colors.black54,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Row(
                              children: [
                                Radio(
                                  fillColor:
                                      MaterialStateColor.resolveWith((states) {
                                    if (states
                                        .contains(MaterialState.selected)) {
                                      return AppColors.buttons;
                                    }

                                    return myCOlor;
                                  }),
                                  value: SexOfPet.female,
                                  groupValue: sex,
                                  onChanged: (value) {
                                    setState(() {
                                      sex = value ?? SexOfPet.unknown;
                                    });
                                  },
                                ),
                                Text(
                                  'female',
                                  style: GoogleFonts.varelaRound(
                                    color: Colors.black54,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 17,
                    top: 3,
                    child: Container(
                      padding:
                          const EdgeInsets.only(bottom: 5, right: 5, left: 3),
                      color: AppColors.background,
                      child: Text(
                        'Sex',
                        style: GoogleFonts.varelaRound(
                          color: AppColors.buttons,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: TextFormField(
                  controller: TextEditingController(
                      text: DateFormat('d MMM y').format(birthday)),
                  onTap: () async {
                    await _showDatePicker();
                  },
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      label: Text(
                        'Birthday',
                        style: GoogleFonts.varelaRound(
                          color: AppColors.buttons,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: myCOlor,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: myCOlor,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      )),
                  style: GoogleFonts.varelaRound(
                    color: myCOlor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  validator: (val) => null,
                  onSaved: (val) {
                    // nothing to do because
                    // _showDatePicker saves date
                  },
                ),
              ),
              MyFormFild2(
                validator: (val) => null,
                save: (val) {
                  description = val ?? '';
                },
                label: "Description",
                labelColor: AppColors.buttons,
                fontColor: myCOlor,
                activeBorder: myCOlor,
                disactiveBorder: myCOlor,
              ),
            ],
          ),
        ),
        Step(
          state: stateOfStep(1),
          isActive: _currentStep >= 1,
          title: const Text('Photo'),
          content: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      image != null ? 'photo: ${image!.name}' : 'photo: none',
                      style: GoogleFonts.varelaRound(
                        color: myCOlor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: image == null
                          ? null
                          : () {
                              setState(() {
                                image = null;
                              });
                            },
                      icon: Icon(
                        Icons.clear,
                        size: 20,
                        color:
                            image == null ? myCOlor : AppColors.darkerButtons,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: const Text(
                          'Add photo',
                        ),
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          XFile? file = await picker.pickImage(
                              source: ImageSource.gallery);

                          setState(() {
                            image = file;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Step(
          state: stateOfStep(2),
          isActive: _currentStep >= 2,
          title: const Text('Complete'),
          content: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Are you sure?',
              style: GoogleFonts.varelaRound(
                color: Colors.black54,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ];

  /// This function set icons for steps in stepper
  StepState stateOfStep(int idx) {
    if (_currentStep == idx) {
      return StepState.editing;
    } else if (_currentStep > idx) {
      return StepState.complete;
    }

    return StepState.indexed;
  }

  Future<void> _showDatePicker() async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((value) {
      setState(() {
        birthday = value ?? birthday;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Theme(
            data: Theme.of(context).copyWith(
              textTheme: TextTheme(
                bodyLarge: GoogleFonts.varelaRound(
                  color: Colors.black54,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              colorScheme: const ColorScheme.light(
                primary: AppColors.buttons,
              ),
            ),
            child: Stepper(
              // Stepper of the whole form
              onStepTapped: (step) => setState(() {
                _currentStep = step;
              }),
              type: StepperType.vertical,
              steps: getSteps(),
              currentStep: _currentStep,
              onStepContinue: _currentStep == getSteps().length - 1 &&
                      image == null
                  ? null
                  : () async {
                      final isLastStep = _currentStep == getSteps().length - 1;
                      if (isLastStep) {
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          // make post for pet
                          CreatingPet2 pet = CreatingPet2(
                            name: name,
                            species: species,
                            breed: breed,
                            birthday: birthday,
                            description: description,
                            sex: sex,
                            image: image!,
                          );

                          Navigator.of(context).pop(pet);
                          // function to add
                          //await BlocProvider.of<AppCubit>(context)
                          //.addPet(pet, image!);
                        }
                      } else {
                        setState(() {
                          _currentStep += 1;
                        });
                      }
                    },
              onStepCancel: _currentStep == 0
                  ? () => Navigator.of(context).pop(null)
                  : (() {
                      setState(() {
                        _currentStep -= 1;
                      });
                    }),
              controlsBuilder: (context, details) {
                // This function create stepper's buttons
                return Row(
                  children: [
                    ElevatedButton(
                      // CONFIRM-CONTINUME button
                      onPressed: details.onStepContinue,
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                      child: Text(
                        _currentStep == lastStep ? 'CONFIRM' : 'CONTINUE',
                        style: GoogleFonts.varelaRound(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    OutlinedButton(
                      // TOMENU - PREVIOUS button
                      onPressed: details.onStepCancel,
                      style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.grey[600],
                          side: BorderSide(
                            color: Colors.grey[400]!,
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                      child: Text(
                        _currentStep == 0 ? 'TO MENU' : 'PREVIOUS',
                        style: GoogleFonts.varelaRound(
                          color: Colors.grey[300],
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
