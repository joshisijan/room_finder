import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/src/reuseables/custom_button.dart';
import 'package:room_finder/src/reuseables/custom_chip.dart';
import 'package:room_finder/src/reuseables/custom_form_field.dart';
import 'package:room_finder/src/values/constants.dart';

class PostTab extends StatefulWidget {
  @override
  _PostTabState createState() => _PostTabState();
}

class _PostTabState extends State<PostTab> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _rentController;
  FocusNode _rentFocus;
  TextEditingController _depositController;
  FocusNode _depositFocus;
  TextEditingController _termsController;
  FocusNode _termsFocus;
  TextEditingController _featuresController;
  FocusNode _featuresFocus;

  @override
  void initState() {
    super.initState();
    _rentController = TextEditingController();
    _rentFocus = FocusNode();
    _depositController = TextEditingController();
    _depositFocus = FocusNode();
    _termsController = TextEditingController();
    _termsFocus = FocusNode();
    _featuresController = TextEditingController();
    _featuresFocus = FocusNode();
  }

  @override
  void dispose() {
    _rentController.dispose();
    _rentFocus.dispose();
    _depositController.dispose();
    _depositFocus.dispose();
    _termsController.dispose();
    _termsFocus.dispose();
    _featuresController.dispose();
    _featuresFocus.dispose();
    super.dispose();
  }

  int _selectedType = 0;
  bool parking = false;
  bool attachedBathroom = false;
  bool separateKitchen = false;
  bool petsAllowed = false;
  bool water = false;

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;
    return Container(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Hello ${user.displayName},',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  Text(
                    'Post ads for rooms and roommates!',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  SizedBox(
                    height: kDefaultPadding / 4,
                  ),
                  Text(
                    'SpareRoom helps you to get a prefect room partner or just a perfect room.',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  Text(
                    'Type',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton(
                    value: _selectedType,
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value;
                      });
                    },
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(
                        child: Text('Room/Flat'),
                        value: 0,
                      ),
                      DropdownMenuItem(
                        child: Text('Flatmate'),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text('Paying Guest'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  CustomFormField(
                    controller: _rentController,
                    focus: _rentFocus,
                    title: 'Rent',
                    hint: 'Enter rent per month',
                    helper: 'eg. 15000',
                    inputAction: TextInputAction.next,
                    prefixText: 'Rs.',
                    inputType: TextInputType.number,
                    padded: false,
                    digitsOnly: true,
                    maxLines: 20,
                    validator: (value) {
                      if (value.toString().trim().length <= 0) {
                        return 'Fill out rent first';
                      }
                      return null;
                    },
                    submitted: (value) {
                      FocusScope.of(context).requestFocus(_depositFocus);
                    },
                  ),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  CustomFormField(
                    controller: _depositController,
                    focus: _depositFocus,
                    title: 'Deposit',
                    hint: 'Enter deposit',
                    helper: 'eg. 25000',
                    inputAction: TextInputAction.next,
                    prefixText: 'Rs.',
                    inputType: TextInputType.number,
                    padded: false,
                    digitsOnly: true,
                    validator: (value) {
                      if (value.toString().trim().length <= 0) {
                        return 'Fill out deposit first';
                      }
                      return null;
                    },
                    submitted: (value) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  Text(
                    'Features',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Wrap(
                    children: [
                      CustomChip(
                        label: 'Parking',
                        selected: parking,
                        onChange: (value) {
                          setState(() {
                            parking = value;
                          });
                        },
                      ),
                      CustomChip(
                        selected: attachedBathroom,
                        label: 'Attached Bathroom',
                        onChange: (value) {
                          setState(() {
                            attachedBathroom = value;
                          });
                        },
                      ),
                      CustomChip(
                          label: 'Pets Allowed',
                          selected: petsAllowed,
                          onChange: (value) {
                            setState(
                              () {
                                petsAllowed = value;
                              },
                            );
                          }),
                      CustomChip(
                        label: 'Water',
                        selected: water,
                        onChange: (value){
                          setState(() {
                            water  = value;
                          });
                        },
                      ),
                      CustomChip(
                        label: 'Separate Kitchen',
                        selected: separateKitchen,
                        onChange: (value) {
                          setState(() {
                            separateKitchen = value;
                          });
                        },
                      ),
                    ],
                  ),
                  CustomFormField(
                    controller: _featuresController,
                    focus: _featuresFocus,
                    title: 'Additional Features',
                    hint: 'Additional Features',
                    helper: 'Press enter for new line.',
                    inputAction: TextInputAction.newline,
                    inputType: TextInputType.multiline,
                    minLines: 2,
                    maxLength: 100,
                    maxLines: 5,
                    padded: false,
                    validator: (value) {
                      return null;
                    },
                  ),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  CustomFormField(
                    controller: _termsController,
                    focus: _termsFocus,
                    title: 'Terms & Conditions',
                    hint: 'Terms & Conditions',
                    helper: 'Press enter for new line.',
                    inputAction: TextInputAction.newline,
                    inputType: TextInputType.multiline,
                    minLines: 5,
                    maxLength: 200,
                    maxLines: 10,
                    padded: false,
                    validator: (value) {
                      return null;
                    },
                  ),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  CustomButton(
                    padded: false,
                    title: Text('Post Ad'),
                    pressed: () {
                      FocusScope.of(context).unfocus();
                      submitAd();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  submitAd() async {
    if (formKey.currentState.validate()) {
      print('submitted');
    }
  }
}
