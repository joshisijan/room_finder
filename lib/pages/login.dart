import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_finder/custom_pluging/custom_button.dart';
import 'package:room_finder/custom_pluging/custom_error.dart';
import 'package:room_finder/custom_pluging/custom_form_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _fbAuth = FirebaseAuth.instance;

  bool _loggedPressed = false;

  bool _hasError = false;

  String _error = '';

  String _phone = '';

  String _verificationId = '';

  String _code;

  bool _sent = false;

  TextEditingController _phoneController;

  TextEditingController _codeController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phoneController = TextEditingController();
    _codeController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Opacity(
              opacity: _loggedPressed ? 1 : 0,
              child: Container(child: LinearProgressIndicator()),
            ),
            _hasError ? CustomError(
              title: _error,
            ) : SizedBox(),
            Expanded(
              child: Opacity(
                opacity: _loggedPressed ? 0.5 : 1.0,
                child: AbsorbPointer(
                  absorbing: _loggedPressed,
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          CustomFormField(
                            title: _sent ? 'Verification code:' : 'Phone number:',
                            hint: _sent ? 'verification code' : 'phone number',
                            helper: _sent ? 'If not auto verified fill this for verification.' : 'eg. +977 9860073492',
                            controller: _sent ? _codeController : _phoneController,
                            prefixText: _sent ? 'code ' : '+977 ',
                            validator: (value) {
                              if (value.isEmpty) {
                                return _sent ? 'Fill the verification code first' : 'Fill out your phone number first';
                              }
                              return null;
                            },
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.phone,
                            submitted: (value) {
                              loginPressed();
                            },
                            pass: false,
                          ),
                          CustomButton(
                            title: _sent ? 'Verify' : 'Log in',
                            pressed: () {
                              _sent ? selfVerification() : loginPressed();
                            },
                          ),
                          _sent ? CustomButton(
                            title: 'Resend verification code',
                            pressed: (){
                              resendCode();
                            }
                          )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loginPressed() {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      setState(() {
        _hasError = false;
        _loggedPressed = true;
      });
      _phone = _phoneController.text.toString().trim();
      _phone = '+977' + _phone;
      _fbAuth.verifyPhoneNumber(
          phoneNumber: _phone,
          timeout: Duration(seconds: 90),
          verificationCompleted: (authCredential) {
            verificationComplete(authCredential);
          },
          verificationFailed: (authException) {
            errorMessage(authException);
          },
          codeSent: (verificationId, [code]) {
            codeSent(verificationId, [code]);
          },
          codeAutoRetrievalTimeout: (value) {

          });
    }
  }

  void resendCode() {
    setState(() {
      _hasError = false;
      _error = '';
      _sent = false;
      _code = '';
      _codeController.text = '';
      _verificationId = '';
    });
  }


  void errorMessage(AuthException e){
    switch(e.code.toString()){
      case 'invalidCredential':
        setState(() {
          _loggedPressed = false;
          _hasError = true;
          _error = 'Please enter a valid phone number to login.';
        });
        break;
      default:
        setState(() {
          _loggedPressed = false;
          _hasError = true;
          _error = e.message.toString();
        });
    }
  }

  void codeSent(String verificationId, List<int> code){
    setState(() {
      _verificationId = verificationId;
      _sent = true;
      _loggedPressed = false;
      _hasError = false;
    });
  }

  void verificationComplete(AuthCredential authCredential){
    _fbAuth.signInWithCredential(authCredential).then((value){
      Navigator.pushReplacementNamed(context, '/home');
    }).catchError((error){
      setState(() {
        _loggedPressed = false;
        _hasError = true;
        _error = error.message.toString();
        _codeController.text = '';
      });
    });
  }

  void selfVerification() {
    FocusScope.of(context).unfocus();
    setState(() {
      _loggedPressed = true;
      _hasError = false;
    });
    _code = _codeController.text.toString().trim();
    final _selfAuthCredential = PhoneAuthProvider.getCredential(verificationId: _verificationId, smsCode: _code.toString());
    verificationComplete(_selfAuthCredential);
  }
}
