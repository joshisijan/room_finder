import 'package:flutter/material.dart';
import 'package:room_finder/src/reuseables/custom_button.dart';
import 'package:room_finder/src/reuseables/custom_form_field.dart';
import 'package:room_finder/src/values/constants.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SpareRoom'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              child: Form(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(kDefaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            'Hello people,',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          SizedBox(
                            height: kDefaultPadding / 2,
                          ),
                          Text(
                            'Welcome to SpareRoom!',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          SizedBox(
                            height: kDefaultPadding / 4,
                          ),
                          Text(
                            'SpareRoom helps you to get a prefect room partner or just a perfect room.',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          CustomButton(
                            padded: false,
                            bgColor: Theme.of(context).accentColor,
                            title: Text('Search rooms'),
                            pressed: (){

                            },
                          ),
                          CustomButton(
                            padded: false,
                            title: Text('Search flatmates'),
                            pressed: (){

                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(kDefaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Join us',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          SizedBox(
                            height: kDefaultPadding / 2,
                          ),
                          Text(
                            'START YOUR ADVENTURE WITH US',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          SizedBox(
                            height: kDefaultPadding / 4,
                          ),
                          Text(
                            'No need to register in tradational way just put in your phone number and you are good to go. Unlock some more features by just signing in.',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    CustomFormField(
                      title: 'Phone number:',
                      hint: 'phone number',
                      helper: 'eg. +977 9860073492',
                      prefixText: '+977 ',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Fill out your phone number first';
                        }
                        return null;
                      },
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.phone,
                      submitted: (value) {
                      },
                      pass: false,
                    ),
                    CustomButton(
                      padded: true,
                      title: Text('SIGN IN'),
                      pressed: () {

                      },
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
