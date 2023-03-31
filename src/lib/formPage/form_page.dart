import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_share/utils/app_colors.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.background,
              AppColors.background.withOpacity(0.0)
            ],
            stops: const [0.91, 1],
            tileMode: TileMode.mirror,
          ).createShader(bounds);
        },
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "Add new announcement",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.smallElements['reddish'],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  // Enter title
                  padding: const EdgeInsets.all(10.0),
                  child: Material(
                    color: Colors.white,
                    elevation: 10,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          icon: const Icon(Icons.title),
                          hintText: 'Enter the title of your announcement',
                          labelText: 'Title',
                          iconColor: AppColors.smallElements['reddish'],
                          hoverColor: AppColors.smallElements['reddish'],
                          focusColor: AppColors.darkerNavigation,
                        ),
                        maxLength: 50,
                        // keyboardType: TextInputType.multiline,
                        // maxLines: null,
                        onSaved: (String? value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                        },
                        validator: (String? value) {
                          return (value == "") ? 'Title cannot be null.' : null;
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  // Enter name
                  padding: const EdgeInsets.all(10.0),
                  child: Material(
                    color: Colors.white,
                    elevation: 10,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          icon: const Icon(Icons.title),
                          hintText: 'Enter a name',
                          labelText: 'Name',
                          iconColor: AppColors.smallElements['reddish'],
                          hoverColor: AppColors.smallElements['reddish'],
                          focusColor: AppColors.darkerNavigation,
                        ),
                        maxLength: 50,
                        onSaved: (String? value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                        },
                        validator: (String? value) {
                          return (value == "") ? 'Name cannot be null.' : null;
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  // Enter birthdate
                  padding: const EdgeInsets.all(10.0),
                  child: Material(
                    color: Colors.white,
                    elevation: 10,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller:
                              dateController, //editing controller of this TextField
                          decoration: const InputDecoration(
                              icon: Icon(
                                  Icons.calendar_today), //icon of text field
                              labelText: "Enter Date" //label text of field
                              ),
                          readOnly: true, // when true user cannot edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(), //get today's date
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: AppColors.form,
                                      onPrimary:
                                          (AppColors.smallElements['reddish'])!,
                                      onSurface: AppColors.tile[1],
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        foregroundColor:
                                            AppColors.smallElements[
                                                'reddish'], // button text color
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );

                            if (pickedDate != null) {
                              // ignore: avoid_print
                              print(
                                  pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                              String formattedDate = DateFormat('yyyy-MM-dd')
                                  .format(
                                      pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                              // ignore: avoid_print
                              print(
                                  formattedDate); //formatted date output using intl package =>  2022-07-04
                              //You can format date as per your need

                              setState(() {
                                dateController.text =
                                    formattedDate; //set foratted date to TextField value.
                              });
                            } else {
                              // ignore: avoid_print
                              print("Date is not selected");
                            }
                          },
                        )),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        // Enter title
                        padding: const EdgeInsets.all(10.0),
                        child: Material(
                          color: Colors.white,
                          elevation: 10,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                icon: const Icon(Icons.title),
                                labelText: 'Breed',
                                iconColor: AppColors.smallElements['reddish'],
                                hoverColor: AppColors.smallElements['reddish'],
                                focusColor: AppColors.darkerNavigation,
                              ),
                              maxLength: 30,
                              // keyboardType: TextInputType.multiline,
                              // maxLines: null,
                              onSaved: (String? value) {
                                // This optional block of code can be used to run
                                // code when the user saves the form.
                              },
                              validator: (String? value) {
                                return (value == null)
                                    ? 'Title cannot be null.'
                                    : null;
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Padding(
                        // Enter title
                        padding: const EdgeInsets.all(10.0),
                        child: Material(
                          color: Colors.white,
                          elevation: 10,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                icon: const Icon(Icons.title),
                                labelText: 'Species',
                                iconColor: AppColors.smallElements['reddish'],
                                hoverColor: AppColors.smallElements['reddish'],
                                focusColor: AppColors.darkerNavigation,
                              ),
                              maxLength: 30,
                              // keyboardType: TextInputType.multiline,
                              // maxLines: null,
                              onSaved: (String? value) {
                                // This optional block of code can be used to run
                                // code when the user saves the form.
                              },
                              validator: (String? value) {
                                return (value == null)
                                    ? 'Title cannot be null.'
                                    : null;
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  // Enter title
                  padding: const EdgeInsets.all(10.0),
                  child: Material(
                    color: Colors.white,
                    elevation: 10,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          icon: const Icon(Icons.title),
                          labelText: 'Description',
                          iconColor: AppColors.smallElements['reddish'],
                          hoverColor: AppColors.smallElements['reddish'],
                          focusColor: AppColors.darkerNavigation,
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        maxLength: 1000,
                        // keyboardType: TextInputType.multiline,
                        // maxLines: null,
                        onSaved: (String? value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                        },
                        validator: (String? value) {
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkerNavigation,
                      minimumSize: const Size(75, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 10,
                    ),
                    icon: const Icon(Icons.check),
                    label: const Text(
                      "Add",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    // child: const Padding(
                    //   padding: EdgeInsets.all(8.0),
                    //   child: Text(
                    //     'Add announcement!',
                    //     style: TextStyle(
                    //       fontSize: 20,
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
