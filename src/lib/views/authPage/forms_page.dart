import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_share/models/adopter.dart';
import 'package:pet_share/models/announcement.dart';
import 'package:pet_share/models/shelter.dart';
import 'package:pet_share/views/authPage/form_field.dart';

class ShelterForm extends StatefulWidget {
  /// The field that are parts of Shleter class but it is provided from
  /// user logging account
  final String email;
  const ShelterForm({required this.email, super.key});

  @override
  State<ShelterForm> createState() => _ShelterFormState();
}

class _ShelterFormState extends State<ShelterForm> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  /// The field that are parts of Shleter class
  late String userName;

  /// The field that are parts of Shleter class
  late String phoneNumber;

  /// The field that are parts of Shleter class
  late String fullShelterName;

  /// The field that are parts of Shleter class
  late String street;

  /// The field that are parts of Shleter class
  late String city;

  /// The field that are parts of Shleter class
  late String provice;

  /// The field that are parts of Shleter class
  late String postalCode;

  /// The field that are parts of Shleter class
  late String country;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(145, 131, 222, 1),
            Color.fromRGBO(160, 148, 227, 1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: Image.asset('assets/animal_shelter.png'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Form(
                    // The whole widget is a form with fields in stepper
                    key: _formKey,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        textTheme: TextTheme(
                          bodyLarge: GoogleFonts.varelaRound(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        colorScheme: const ColorScheme.light(),
                      ),
                      child: Stepper(
                        // Stepper of the whole form
                        onStepTapped: (step) => setState(() {
                          _currentStep = step;
                        }),
                        type: StepperType.vertical,
                        steps: getSteps(),
                        currentStep: _currentStep,
                        onStepContinue: () async {
                          // This function changes step to the next one
                          if (_currentStep < lastStep) {
                            setState(() {
                              _currentStep += 1;
                            });
                          } else {
                            // This is for "CONFIRME" button
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Shelter shelter = Shelter(
                                userName: userName,
                                phoneNumber: phoneNumber,
                                fullShelterName: fullShelterName,
                                email: widget.email,
                                address: Address(
                                  street: street,
                                  city: city,
                                  provice: provice,
                                  postalCode: postalCode,
                                  country: country,
                                ),
                              );
                              Navigator.of(context).pop(shelter);
                            }
                          }
                        },
                        onStepCancel: () {
                          // This function changes step to the previous one
                          setState(() {
                            if (_currentStep > 0) {
                              _currentStep -= 1;
                            } else {
                              // go back to main page
                              Navigator.of(context).pop(null);
                            }
                          });
                        },

                        controlsBuilder: (context, details) {
                          // This function create stepper's buttons
                          return Row(
                            children: [
                              ElevatedButton(
                                // CONFIRM-CONTINUME button
                                onPressed: details.onStepContinue,
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25))),
                                child: Text(
                                  _currentStep == lastStep
                                      ? 'CONFIRM'
                                      : 'CONTINUE',
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
                                        borderRadius:
                                            BorderRadius.circular(25))),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// This function set icons for steps in stepper
  StepState stateOfStep(int idx) {
    if (_currentStep == idx) {
      return StepState.editing;
    } else if (_currentStep > idx) {
      return StepState.complete;
    }

    return StepState.indexed;
  }

  /// Max index of steps
  final lastStep = 2;

  /// The list of available steps
  List<Step> getSteps() => [
        Step(
          state: stateOfStep(0),
          isActive: _currentStep >= 0,
          title: const Text('Account'),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyFormFild(
                validator: (val) {},
                save: (val) {
                  userName = val ?? '';
                },
                label: 'Nick',
              ),
              MyFormFild(
                validator: (val) {
                  phoneNumber = val ?? '';
                },
                save: (val) {},
                label: 'Phone Number',
              ),
              MyFormFild(
                validator: (val) {
                  fullShelterName = val ?? '';
                },
                save: (val) {},
                label: 'Full Shelter Name',
              ),
            ],
          ),
        ),
        Step(
          state: stateOfStep(1),
          isActive: _currentStep >= 1,
          title: const Text('Address'),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyFormFild(
                validator: (val) {},
                save: (val) {
                  street = val ?? '';
                },
                label: 'Street',
              ),
              MyFormFild(
                validator: (val) {},
                save: (val) {
                  city = val ?? '';
                },
                label: 'City',
              ),
              MyFormFild(
                validator: (val) {},
                save: (val) {
                  provice = val ?? '';
                },
                label: 'Province',
              ),
              MyFormFild(
                validator: (val) {},
                save: (val) {
                  postalCode = val ?? '';
                },
                label: 'Postal Code',
              ),
              MyFormFild(
                validator: (val) {},
                save: (val) {
                  country = val ?? '';
                },
                label: 'Country',
              ),
            ],
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
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ];
}

class AdopterForm extends StatefulWidget {
  /// The field that are parts of Adopter class but it is provided from
  /// user logging account
  final String email;
  const AdopterForm({required this.email, super.key});

  @override
  State<AdopterForm> createState() => _AdopterFormState();
}

class _AdopterFormState extends State<AdopterForm> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  /// The field that are parts of Adopter class
  late String userName;

  /// The field that are parts of Adopter class
  late String phoneNumber;

  /// The field that are parts of Adopter class
  late String street;

  /// The field that are parts of Adopter class
  late String city;

  /// The field that are parts of Adopter class
  late String provice;

  /// The field that are parts of Adopter class
  late String postalCode;

  /// The field that are parts of Adopter class
  late String country;

  @override
  void initState() {
    super.initState();
    userName = '';
    phoneNumber = '';
    street = '';
    city = '';
    provice = '';
    postalCode = '';
    country = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(145, 131, 222, 1),
            Color.fromRGBO(160, 148, 227, 1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: Image.asset('assets/kitten_adopter.png'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Form(
                    // The whole widget is a form with fields in stepper
                    key: _formKey,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        textTheme: TextTheme(
                          bodyLarge: GoogleFonts.varelaRound(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        colorScheme: const ColorScheme.light(),
                      ),
                      child: Stepper(
                        // Stepper of the whole form
                        onStepTapped: (step) => setState(() {
                          _currentStep = step;
                        }),
                        type: StepperType.vertical,
                        steps: getSteps(),
                        currentStep: _currentStep,
                        onStepContinue: () async {
                          // This function changes step to the next one
                          if (_currentStep < lastStep) {
                            setState(() {
                              _currentStep += 1;
                            });
                          } else {
                            // This is for "CONFIRME" button
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Adopter adopter = Adopter(
                                userName: userName,
                                phoneNumber: phoneNumber,
                                email: widget.email,
                                address: Address(
                                  street: street,
                                  city: city,
                                  provice: provice,
                                  postalCode: postalCode,
                                  country: country,
                                ),
                              );
                              Navigator.of(context).pop(adopter);
                            }
                          }
                        },
                        onStepCancel: () {
                          // This function changes step to the previous one
                          setState(() {
                            if (_currentStep > 0) {
                              _currentStep -= 1;
                            } else {
                              // go back to main page
                              Navigator.of(context).pop(null);
                            }
                          });
                        },

                        controlsBuilder: (context, details) {
                          // This function create stepper's buttons
                          return Row(
                            children: [
                              ElevatedButton(
                                // CONFIRM-CONTINUME button
                                onPressed: details.onStepContinue,
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25))),
                                child: Text(
                                  _currentStep == lastStep
                                      ? 'CONFIRM'
                                      : 'CONTINUE',
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
                                        borderRadius:
                                            BorderRadius.circular(25))),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// This function set icons for steps in stepper
  StepState stateOfStep(int idx) {
    if (_currentStep == idx) {
      return StepState.editing;
    } else if (_currentStep > idx) {
      return StepState.complete;
    }

    return StepState.indexed;
  }

  /// Max index of steps
  final lastStep = 2;

  /// The list of available steps
  List<Step> getSteps() => [
        Step(
          state: stateOfStep(0),
          isActive: _currentStep >= 0,
          title: const Text('Account'),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyFormFild(
                validator: (val) {},
                save: (val) {
                  userName = val ?? '';
                },
                label: 'Nick',
              ),
              MyFormFild(
                validator: (val) {
                  phoneNumber = val ?? '';
                },
                save: (val) {},
                label: 'Phone Number',
              ),
            ],
          ),
        ),
        Step(
          state: stateOfStep(1),
          isActive: _currentStep >= 1,
          title: const Text('Address'),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyFormFild(
                validator: (val) {},
                save: (val) {
                  street = val ?? '';
                },
                label: 'Street',
              ),
              MyFormFild(
                validator: (val) {},
                save: (val) {
                  city = val ?? '';
                },
                label: 'City',
              ),
              MyFormFild(
                validator: (val) {},
                save: (val) {
                  provice = val ?? '';
                },
                label: 'Province',
              ),
              MyFormFild(
                validator: (val) {},
                save: (val) {
                  postalCode = val ?? '';
                },
                label: 'Postal Code',
              ),
              MyFormFild(
                validator: (val) {},
                save: (val) {
                  country = val ?? '';
                },
                label: 'Country',
              ),
            ],
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
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ];
}
