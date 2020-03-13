import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/custom_pluging/custom_button.dart';
import 'package:room_finder/custom_pluging/custom_error.dart';
import 'package:room_finder/custom_pluging/custom_form_field.dart';
import 'package:room_finder/functions/constants.dart';
import 'package:room_finder/pages/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;


class EditProfile extends StatefulWidget {

  final FirebaseUser cUser;

  EditProfile({@required this.cUser});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final FirebaseAuth _fbAuth = FirebaseAuth.instance;

  final FirebaseStorage _fStorage = FirebaseStorage.instance;

  final Firestore _fireStore = Firestore.instance;

  final _formKey = GlobalKey<FormState>();

  final RegExp nameReg = RegExp(r"^[a-zA-Z]+\s[a-zA-Z]+$");

  bool submittedPressed = false;

  bool _hasError = false;

  String _error = '';

  TextEditingController _nameController;

  File _image;

  String _imgUrl = '';

  String _name = '';

  bool _imageSelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imgUrl = this.widget.cUser.photoUrl ?? '';
    _nameController = TextEditingController();
    _nameController.text = this.widget.cUser.displayName ?? '';
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
                              backgroundImage: _imageSelected ? FileImage(_image) : NetworkImage(_imgUrl ?? ''),
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
                          padded: true,
                          title: Text('Save Changes'),
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
    _name = _nameController.text.trim();
    FocusScope.of(context).unfocus();
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image){
      setState(() {
        if(image != null){
          _image = image;
          _imageSelected = true;
          _nameController.text = _name.trim();
        }
      });
    });
  }

  void submitted() async {
    if(_formKey.currentState.validate()){
      FocusScope.of(context).unfocus();
      _name = _nameController.text.toString().trim();
      setState(() {
        submittedPressed = true;
      });
      UserUpdateInfo info = UserUpdateInfo();
      info.displayName = _nameController.text.toString().trim().toLowerCase();
      if(_image != null){
        if(this.widget.cUser.photoUrl != null){
          StorageReference stoRefDel = await _fStorage.getReferenceFromUrl(this.widget.cUser.photoUrl);
          stoRefDel.delete().then((value){ }).catchError((error){

          });
        }
        StorageReference stoRef = _fStorage.ref().child('profile_image/${Path.basename(_image.path)}');
        StorageUploadTask uTask = stoRef.putFile(_image);
        await uTask.onComplete;
        await stoRef.getDownloadURL().then((fileUrl){
          setState(() {
            _imgUrl = fileUrl;
          });
          info.photoUrl = fileUrl;
        }).catchError((error){
          _hasError = true;
          _error = error.message.toString();
          submittedPressed = false;
        });
      }
      this.widget.cUser.updateProfile(info).then((value){
        _fireStore.collection('userDetail').where('userId',isEqualTo: this.widget.cUser.uid).getDocuments().then((snapshot){
          if(snapshot.documents.isEmpty){
            _fireStore.collection('userDetail').add({
              'userId' : this.widget.cUser.uid,
              'photoUrl': _imgUrl,
              'displayName': _name,
            }).then((value){

            }).catchError((error){

            });
          }else{
            snapshot.documents.forEach((doc){
              _fireStore.collection('userDetail').document(doc.documentID).updateData({
                'photoUrl': _imgUrl,
                'displayName': _name,
              }
              ).catchError((error){

              });
            });
          }
        });

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
