import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_share/models/announcement.dart';
import 'package:pet_share/models/pet.dart';
import 'package:pet_share/utils/app_colors.dart';
import 'package:pet_share/utils/form_field.dart';

class AnnouncementForm extends StatefulWidget {
  final Pet2 pet;

  const AnnouncementForm({required this.pet, super.key});

  @override
  State<AnnouncementForm> createState() => _AnnouncementFormState();
}

class _AnnouncementFormState extends State<AnnouncementForm> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  late String title;

  late String description;

  final Color myColor = Colors.black54;

  /// This function set icons for steps in stepper
  StepState stateOfStep(int idx) {
    if (_currentStep == idx) {
      return StepState.editing;
    } else if (_currentStep > idx) {
      return StepState.complete;
    }

    return StepState.indexed;
  }

  final int lastStep = 1;

  List<Step> getSteps() => [
        Step(
          state: stateOfStep(0),
          isActive: _currentStep >= 0,
          title: const Text('Information'),
          content: Column(
            children: [
              MyFormFild2(
                validator: (val) => null,
                save: (val) {
                  title = val ?? 'title';
                },
                label: 'Title',
                labelColor: AppColors.buttons,
                fontColor: myColor,
                activeBorder: myColor,
                disactiveBorder: myColor,
              ),
              MyFormFild2(
                validator: (val) => null,
                save: (val) {
                  description = val ?? 'title';
                },
                label: 'Title',
                maxLines: 10,
                labelColor: AppColors.buttons,
                fontColor: myColor,
                activeBorder: myColor,
                disactiveBorder: myColor,
              ),
            ],
          ),
        ),
        Step(
          state: stateOfStep(1),
          isActive: _currentStep >= 1,
          title: const Text('Complete'),
          content: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Are you sure?',
              style: GoogleFonts.varelaRound(
                color: myColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ];

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
              onStepContinue: () async {
                final isLastStep = _currentStep == getSteps().length - 1;
                if (isLastStep) {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    var result = CreatingAnnouncement2(
                      title: title,
                      description: description,
                      petId: widget.pet.id,
                    );

                    Navigator.of(context).pop(result);
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
                        _currentStep == 0 ? 'CANCEL' : 'PREVIOUS',
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
