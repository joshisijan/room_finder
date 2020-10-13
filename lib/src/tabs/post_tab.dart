import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:room_finder/src/providers/home_loading_provider.dart';
import 'package:room_finder/src/reuseables/custom_button.dart';
import 'package:room_finder/src/reuseables/custom_chip.dart';
import 'package:room_finder/src/reuseables/custom_form_field.dart';
import 'package:room_finder/src/reuseables/notification.dart';
import 'package:room_finder/src/values/constants.dart';
import 'package:provider/provider.dart';

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
  ScrollController _postAdScrollController;

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
    _postAdScrollController = ScrollController();
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
    _postAdScrollController.dispose();
    super.dispose();
  }

  int _selectedType = 0;
  bool parking = false;
  bool attachedBathroom = false;
  bool separateKitchen = false;
  bool petsAllowed = false;
  bool water = false;
  final FirebaseFirestore fbFirestore = FirebaseFirestore.instance;
  final User user = FirebaseAuth.instance.currentUser;
  File file1;
  File file2;
  File file3;
  File file4;

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;
    return Container(
      child: ListView(
        controller: _postAdScrollController,
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
                        onChange: (value) {
                          setState(() {
                            water = value;
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
                  Text(
                    'Images',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'At least one',
                    style: Theme.of(context).textTheme.overline,
                  ),
                  SizedBox(
                    height: kDefaultPadding * 0.75,
                  ),
                  Wrap(
                    children: [
                      RawMaterialButton(
                        padding: EdgeInsets.zero,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3 - 15.0,
                          height: MediaQuery.of(context).size.width / 3 - 15.0,
                          margin: EdgeInsets.symmetric(
                            vertical: 1.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            image: file1 != null
                                ? DecorationImage(
                                    image: FileImage(file1),
                                  )
                                : null,
                          ),
                          child: file1 == null ? Icon(Icons.add) : null,
                        ),
                        onPressed: () {
                          selectImageAndSave(0);
                        },
                      ),
                      SizedBox(
                        width: 2.0,
                      ),
                      RawMaterialButton(
                        padding: EdgeInsets.zero,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3 - 15.0,
                          height: MediaQuery.of(context).size.width / 3 - 15.0,
                          margin: EdgeInsets.symmetric(
                            vertical: 1.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            image: file2 != null
                                ? DecorationImage(
                                    image: FileImage(file2),
                                  )
                                : null,
                          ),
                          child: file2 == null ? Icon(Icons.add) : null,
                        ),
                        onPressed: () {
                          selectImageAndSave(1);
                        },
                      ),
                      SizedBox(
                        width: 2.0,
                      ),
                      RawMaterialButton(
                        padding: EdgeInsets.zero,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3 - 15.0,
                          height: MediaQuery.of(context).size.width / 3 - 15.0,
                          margin: EdgeInsets.symmetric(
                            vertical: 1.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            image: file3 != null
                                ? DecorationImage(
                                    image: FileImage(file3),
                                  )
                                : null,
                          ),
                          child: file3 == null ? Icon(Icons.add) : null,
                        ),
                        onPressed: () {
                          selectImageAndSave(2);
                        },
                      ),
                      RawMaterialButton(
                        padding: EdgeInsets.zero,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3 - 15.0,
                          height: MediaQuery.of(context).size.width / 3 - 15.0,
                          margin: EdgeInsets.symmetric(
                            vertical: 1.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            image: file4 != null
                                ? DecorationImage(
                                    image: FileImage(file4),
                                  )
                                : null,
                          ),
                          child: file4 == null ? Icon(Icons.add) : null,
                        ),
                        onPressed: () {
                          selectImageAndSave(3);
                        },
                      ),
                      SizedBox(
                        width: 2.0,
                      )
                    ],
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

  selectImageAndSave(int n) async {
    try {
      PickedFile pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        setState(() {
          if (n == 0) {
            file1 = File(pickedFile.path);
          } else if (n == 1) {
            file2 = File(pickedFile.path);
          } else if (n == 2) {
            file3 = File(pickedFile.path);
          } else {
            file4 = File(pickedFile.path);
          }
        });
      }
    } catch (e) {
      CustomNotification(
        color: Colors.red,
        message: 'An error Occurred',
        title: 'Error',
      ).show(context);
    }
  }

  submitAd() async {
    if (formKey.currentState.validate()) {
      if (file1 == null && file2 == null && file3 == null && file4 == null) {
        CustomNotification(
          title: 'Select Image',
          message: 'At least one image must be selected.',
          color: Theme.of(context).errorColor,
        ).show(context);
        return;
      }
      context.read<HomeLoadingProvider>().setLoading(true);
      try {
        int type = _selectedType;
        int rent = int.parse(_rentController.text);
        int deposit = int.parse(_depositController.text);
        String terms = _termsController.text.trim();
        String features = _featuresController.text.trim();
        DocumentReference postReference =
            await fbFirestore.collection('ads').add({
          'userId': user.uid,
          'type': type,
          'rent': rent,
          'deposit': deposit,
          'parking': parking,
          'attachedBathroom': attachedBathroom,
          'separateKitchen': separateKitchen,
          'petsAllowed': petsAllowed,
          'water': water,
          'terms': terms,
          'features': features,
          'file1': '',
          'file2': '',
          'file3': '',
          'file4': '',
          'timestamp': Timestamp.now(),
        });
        // adding image in firebase storage
        FirebaseStorage firebaseStorage = FirebaseStorage.instance;
        var downloadUrl1, downloadUrl2, downloadUrl3, downloadUrl4;
        //for file1 to file4
        if (file1 != null) {
          StorageReference storageReferenc1 =
              firebaseStorage.ref().child('/images/${postReference.id}/1');
          StorageUploadTask storageUploadTask1 =
              storageReferenc1.putFile(file1);
          StorageTaskSnapshot storageTaskSnapshot1 =
              await storageUploadTask1.onComplete;
          downloadUrl1 = await storageTaskSnapshot1.ref.getDownloadURL();
        }
        if (file2 != null) {
          StorageReference storageReference2 =
              firebaseStorage.ref().child('/images/${postReference.id}/2');
          StorageUploadTask storageUploadTask2 =
              storageReference2.putFile(file2);
          StorageTaskSnapshot storageTaskSnapshot2 =
              await storageUploadTask2.onComplete;
          downloadUrl2 = await storageTaskSnapshot2.ref.getDownloadURL();
        }
        if (file3 != null) {
          StorageReference storageReference3 =
              firebaseStorage.ref().child('/images/${postReference.id}/3');
          StorageUploadTask storageUploadTask3 =
              storageReference3.putFile(file3);
          StorageTaskSnapshot storageTaskSnapshot3 =
              await storageUploadTask3.onComplete;
          downloadUrl3 = await storageTaskSnapshot3.ref.getDownloadURL();
        }
        if (file4 != null) {
          StorageReference storageReference4 =
              firebaseStorage.ref().child('/images/${postReference.id}/4');
          StorageUploadTask storageUploadTask4 =
              storageReference4.putFile(file4);
          StorageTaskSnapshot storageTaskSnapshot4 =
              await storageUploadTask4.onComplete;
          downloadUrl4 = await storageTaskSnapshot4.ref.getDownloadURL();
        }
        await postReference.update({
          'file1': downloadUrl1 ?? '',
          'file2': downloadUrl2 ?? '',
          'file3': downloadUrl3 ?? '',
          'file4': downloadUrl4 ?? '',
        });
        // resetting and ending job
        _selectedType = 0;
        parking = false;
        attachedBathroom = false;
        separateKitchen = false;
        petsAllowed = false;
        water = false;
        _rentController.text = '';
        _depositController.text = '';
        _featuresController.text = '';
        _termsController.text = '';
        _postAdScrollController.animateTo(
          _postAdScrollController.position.minScrollExtent,
          curve: Curves.easeIn,
          duration: Duration(milliseconds: 500),
        );
        CustomNotification(
          color: Colors.green,
          message: 'Successfully Posted Ad',
          title: 'Success',
        ).show(context);
      } catch (e) {
        if (e.code == 'network-request-failed') {
          CustomNotification(
            title: 'Network Error',
            message:
                'No Network Connection. Check your connection and try again.',
            color: Theme.of(context).errorColor,
          ).show(context);
        } else {
          CustomNotification(
            color: Colors.red,
            message: 'An error Occurred',
            title: 'Error',
          ).show(context);
        }
      }
      context.read<HomeLoadingProvider>().setLoading(false);
    } else {
      _postAdScrollController.animateTo(
        _postAdScrollController.position.minScrollExtent,
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
      );
    }
  }
}
