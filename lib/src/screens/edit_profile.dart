import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/src/reuseables/custom_button.dart';
import 'package:room_finder/src/reuseables/custom_form_field.dart';
import 'package:room_finder/src/reuseables/notification.dart';
import 'package:room_finder/src/screens/home.dart';
import 'package:room_finder/src/screens/photo_view.dart';
import 'package:room_finder/src/values/constants.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  final int currentIndex;
  const EditProfile({Key key, this.currentIndex = 4}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool loading = false;
  File imageFile;
  TextEditingController _nameController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;
    _nameController.text = user.displayName ?? '';
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: loading
            ? PreferredSize(
                preferredSize: Size.fromHeight(4.0),
                child: LinearProgressIndicator(
                  minHeight: 4.0,
                ),
              )
            : null,
        title: Text('edit profile'),
        leading: BackButton(
          onPressed: () {
            if (user.displayName == '' || user.displayName == null) {
              CustomNotification(
                color: Colors.red,
                title: 'Account Detail',
                message: 'Name is compulsory.',
              ).show(context);
            } else {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                            currentIndex: widget.currentIndex,
                          )));
            }
          },
        ),
      ),
      body: AbsorbPointer(
        absorbing: loading,
        child: Opacity(
          opacity: loading ? 0.6 : 1.0,
          child: Form(
            key: formKey,
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: kDefaultPadding,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    user.photoURL == null
                        ? imageFile == null
                            ? CircleAvatar(
                                backgroundColor: Theme.of(context).accentColor,
                                radius: kDefaultPadding * 2,
                              )
                            : GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return PhotoViewerPage(file: imageFile);
                                    },
                                  ));
                                },
                                child: CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).accentColor,
                                  backgroundImage: FileImage(imageFile),
                                  radius: kDefaultPadding * 2,
                                ),
                              )
                        : imageFile == null
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return NetworkPhotoViewPage(
                                          url: user.photoURL);
                                    },
                                  ));
                                },
                                child: CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).accentColor,
                                  radius: kDefaultPadding * 2,
                                  backgroundImage: NetworkImage(user.photoURL),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return PhotoViewerPage(file: imageFile);
                                    },
                                  ));
                                },
                                child: CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).accentColor,
                                  backgroundImage: FileImage(imageFile),
                                  radius: kDefaultPadding * 2,
                                ),
                              ),
                  ],
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                RawMaterialButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.edit),
                      SizedBox(
                        width: kDefaultPadding,
                      ),
                      Text('choose new image'),
                    ],
                  ),
                  onPressed: chooseImage,
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                CustomFormField(
                  enabled: false,
                  title: 'Email:',
                  value: user.email,
                  pass: false,
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                CustomFormField(
                  enabled: true,
                  title: 'Display Name:',
                  inputType: TextInputType.text,
                  helper: user.displayName == null || user.displayName == ''
                      ? 'eg. Peter Parker'
                      : 'Current Name: ${user.displayName.toUpperCase()}',
                  hint: 'New Display Name',
                  controller: _nameController,
                  validator: (value) {
                    if (value.toString().trim().isEmpty) {
                      return 'fill out Name first';
                    }
                    return null;
                  },
                  submitted: (x) {
                    submitted();
                  },
                  pass: false,
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                CustomButton(
                  padded: true,
                  title: Text('Save Changes'),
                  pressed: () {
                    FocusScope.of(context).unfocus();
                    submitted();
                  },
                ),
                SizedBox(
                  width: kDefaultPadding,
                ),
                Container(
                  padding: EdgeInsets.all(kDefaultPadding),
                  child: Text(
                    'Note: Larger image will take more time to upload and load.',
                    style: Theme.of(context).textTheme.overline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future chooseImage() async {
    try {
      setState(() {
        loading = true;
      });
      PickedFile pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      CustomNotification(
        title: 'Error',
        message: 'An error occurred',
        color: Colors.red,
      ).show(context);
    }
  }

  void submitted() async {
    if (formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      try {
        FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
        String name = _nameController.text.trim();
        User user = FirebaseAuth.instance.currentUser;
        if (imageFile == null) {
          await user.updateProfile(
            displayName: name,
          );
          // saving data making a user collection
          await firebaseFirestore.collection('users').doc(user.uid).update({
            'displayName': name,
          });
          CustomNotification(
            title: 'Profile Update',
            message: 'Profile Update Successful',
            color: Colors.green,
          ).show(context);
        } else {
          FirebaseStorage firebaseStorage = FirebaseStorage.instance;
          StorageReference storageReference =
              firebaseStorage.ref().child('/images/${user.uid}');
          StorageUploadTask storageUploadTask =
              storageReference.putFile(imageFile);
          StorageTaskSnapshot storageTaskSnapshot =
              await storageUploadTask.onComplete;
          var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
          await user.updateProfile(
            displayName: name,
            photoURL: downloadUrl,
          );
          // saving data making a user collection
          await firebaseFirestore.collection('users').doc(user.uid).update({
            'displayName': name,
            'photoURL': downloadUrl,
          });
          CustomNotification(
            title: 'Profile Update',
            message: 'Profile Update Successful',
            color: Colors.green,
          ).show(context);
        }
        _nameController.text = '';
        await user.reload();
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
            title: 'Error',
            message: 'An error occurred',
            color: Colors.red,
          ).show(context);
        }
      }
      setState(() {
        loading = false;
      });
    }
  }
}
