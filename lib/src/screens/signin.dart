import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/src/reuseables/custom_button.dart';
import 'package:room_finder/src/reuseables/custom_form_field.dart';
import 'package:room_finder/src/reuseables/notification.dart';
import 'package:room_finder/src/screens/home.dart';
import 'package:room_finder/src/screens/register.dart';
import 'package:room_finder/src/values/constants.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  FocusNode _emailFocus;
  FocusNode _passwordFocus;
  final _formKey = GlobalKey<FormState>();
  final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final FirebaseAuth fbAuth = FirebaseAuth.instance;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordFocus = FocusNode();
    _emailFocus = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordFocus.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SpareRoom'),
        bottom: loading
            ? PreferredSize(
                preferredSize: Size.fromHeight(4.0),
                child: LinearProgressIndicator(
                  minHeight: 4.0,
                ),
              )
            : null,
      ),
      body: AbsorbPointer(
        absorbing: loading,
        child: Opacity(
          opacity: loading ? 0.6 : 1.0,
          child: Container(
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: kDefaultPadding,
                        right: kDefaultPadding,
                        left: kDefaultPadding),
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Sign in',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        SizedBox(
                          height: kDefaultPadding / 2,
                        ),
                        Text(
                          'SIGN IN YOUR ACCOUNT',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        SizedBox(
                          height: kDefaultPadding / 4,
                        ),
                      ],
                    ),
                  ),
                  CustomFormField(
                    title: 'Email Address:',
                    hint: 'Email Address',
                    helper: 'eg. email@email.com',
                    controller: _emailController,
                    focus: _emailFocus,
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return 'Fill out your Email first';
                      } else if (!emailRegExp.hasMatch(value.trim())) {
                        return 'Provide valid Email Address';
                      }
                      return null;
                    },
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.emailAddress,
                    submitted: (value) {
                      FocusScope.of(context).requestFocus(_passwordFocus);
                    },
                    pass: false,
                  ),
                  SizedBox(height: kDefaultPadding,),
                  CustomFormField(
                    title: 'Password:',
                    hint: 'Password',
                    helper: '8 or more characters',
                    controller: _passwordController,
                    focus: _passwordFocus,
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return 'Fill out your Password first';
                      } else if (value.length < 8) {
                        return '8 or More character';
                      }
                      return null;
                    },
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.emailAddress,
                    submitted: (value) {
                      signin();
                    },
                    pass: true,
                  ),
                  SizedBox(height: kDefaultPadding),
                  CustomButton(
                    padded: true,
                    title: Text('SIGN IN'),
                    pressed: () {
                      FocusScope.of(context).unfocus();
                      signin();
                    },
                  ),
                  SizedBox(height: kDefaultPadding),
                  Text(
                    'No Account?',
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.center,
                  ),
                  RawMaterialButton(
                    child: Text('Register', style: TextStyle(color: Theme.of(context).accentColor,),),
                    onPressed: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RegisterPage()));
                    },
                  ),
                  Text(
                    'Having Trouble?',
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.center,
                  ),
                  RawMaterialButton(
                    child: Text('Forget Password', style: TextStyle(color: Theme.of(context).accentColor,),),
                    onPressed: (){

                    },
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signin() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      String email = _emailController.text.trim();
      String password = _passwordController.text;
      try {
        UserCredential user = await fbAuth.signInWithEmailAndPassword(email: email, password: password);
        if(user != null){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
        }
        _emailController.text = '';
        _passwordController.text = '';
      } catch (e) {
        if (e.code == 'network-request-failed') {
          CustomNotification(
            title: 'Network Error',
            message:
            'No Network Connection. Check your connection and try again.',
            color: Theme.of(context).errorColor,
          ).show(context);
        } else if(e.code == 'user-not-found'){
          CustomNotification(
            title: 'Sign In Error',
            message: '$email is not Registered.',
            color: Theme.of(context).errorColor,
          ).show(context);
        }else if (e.code == 'user-disabled') {
          CustomNotification(
            title: 'Sign In Error',
            message: 'Your Account is disabled.',
            color: Theme.of(context).errorColor,
          ).show(context);
        }else if(e.code == 'wrong-password'){
          CustomNotification(
            title: 'Sign In Error',
            message: 'Incorrect Password.',
            color: Theme.of(context).errorColor,
          ).show(context);
        }else {
          CustomNotification(
            title: 'Sign In Error',
            message: e.code.toString() + 'An error occurred!',
            color: Theme.of(context).errorColor,
          ).show(context);
        }
      }
      setState(() {
        loading = false;
      });
    }
  }
}
