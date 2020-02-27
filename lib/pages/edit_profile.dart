import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/custom_pluging/custom_button.dart';
import 'package:room_finder/custom_pluging/custom_error.dart';
import 'package:room_finder/custom_pluging/custom_form_field.dart';
import 'package:room_finder/functions/constants.dart';
import 'package:room_finder/pages/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as Path;


class EditProfile extends StatefulWidget {

  final FirebaseUser cUser;

  EditProfile({@required this.cUser});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final FirebaseAuth _fbAuth = FirebaseAuth.instance;

  final Firestore _fstore = Firestore.instance;

  final _formKey = GlobalKey<FormState>();

  final RegExp nameReg = RegExp(r"^[a-zA-Z]+\s[a-zA-Z]+$");

  bool submittedPressed = false;

  bool _hasError = false;

  String _error = '';

  TextEditingController _nameController;

  File _image;

  String _uploadFileUrl;
  
  String _imgUrl = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imgUrl = this.widget.cUser.photoUrl ?? 'https://picsum.photos/seed/picsum/300/300';
    _nameController = TextEditingController();
    _nameController.text = this.widget.cUser.displayName;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: _fbAuth.onAuthStateChanged,
      builder: (context, snapshot1) {
        if(snapshot1.hasData){
          return Scaffold(
            appBar: AppBar(
              title: Text('edit profile'),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(double.minPositive),
                child: Opacity(
                  opacity: submittedPressed ? 1 : 0,
                  child: LinearProgressIndicator(),
                ),
              ),
            ),
            body: AbsorbPointer(
              absorbing: submittedPressed,
              child: Opacity(
                opacity: submittedPressed ? 0.5 : 1,
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      _hasError ? CustomError(
                        title: _error,
                      ) : SizedBox(),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Theme.of(context).accentColor,
                            radius: kDefaultPadding * 2,
                            backgroundImage: NetworkImage(_imgUrl),
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
                        title: 'Phone Number:',
                        value: this.widget.cUser.phoneNumber,
                        pass: false,
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      CustomFormField(
                        enabled: true,
                        title: 'Display Name:',
                        controller: _nameController,
                        inputType: TextInputType.text,
                        helper: 'eg. Peter Parker',
                        hint: 'Display Name',
                        validator: (value){
                          if(value.toString().isEmpty){
                            return 'fill out this field first';
                          }else if(!nameReg.hasMatch(value.toString().trim())){
                            return 'Enter valid name';
                          }
                          return null;
                        },
                        submitted: (x){
                          submitted();
                        },
                        pass: false,
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      CustomButton(
                        title: 'Save Changes',
                        pressed: (){
                          submitted();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }else{
          return LoginPage();
        }
      }
    );
  }

  Future chooseImage()async{
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image){
      setState(() {
        _image = image;
        _imgUrl = _image.path;
      });
    });
  }

  void submitted() async {
    if(_formKey.currentState.validate()){
      setState(() {
        submittedPressed = true;
      });
      if(_image != null){
        final DocumentReference docRef = _fstore.document('profile_image/${Path.basename(_image.path)}');
      }
      UserUpdateInfo info = UserUpdateInfo();
      info.displayName = _nameController.text.toString().trim().toLowerCase();
      this.widget.cUser.updateProfile(info).then((value){
        Navigator.of(context).pop();
      }).catchError((error){
        setState(() {
          _error = error.message.toString();
          submittedPressed = false;
          _hasError = true;
        });
      });
     }
  }
}
