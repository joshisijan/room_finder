import 'package:flutter/material.dart';
import 'package:room_finder/src/reuseables/custom_button.dart';
import 'package:room_finder/src/reuseables/custom_error.dart';
import 'package:room_finder/src/reuseables/custom_form_field.dart';
import 'package:room_finder/src/values/constants.dart';

class EditProfile extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('edit profile'),
      ),
      body: Form(
        child: ListView(
          children: <Widget>[
            CustomError(
              title: 'this is error message',
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Theme.of(context).accentColor,
                  radius: kDefaultPadding * 2,
                  backgroundImage: NetworkImage(''),
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
              pass: false,
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            CustomFormField(
              enabled: true,
              title: 'Display Name:',
              inputType: TextInputType.text,
              helper: 'eg. Peter Parker',
              hint: 'Display Name',
              validator: (value){
                if(value.toString().isEmpty){
                  return 'fill out this field first';
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
    );
  }

  Future chooseImage()async{
    print('chose image function');
  }

  void submitted() async {
    print('submitted');
  }
}
