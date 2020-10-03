import 'package:flutter/material.dart';
import 'package:room_finder/src/reuseables/custom_button.dart';
import 'package:room_finder/src/reuseables/notification.dart';
import 'package:room_finder/src/values/constants.dart';

class VerificationPage extends StatelessWidget {
  final Function onSendVerification;
  final Function onVerified;
  final Function onSignOut;
  final bool loading;

  const VerificationPage({
    Key key,
    @required this.onSendVerification,
    @required this.onVerified,
    @required this.onSignOut,
    @required this.loading,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Verification'),
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
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Your email address has not been verified. Verify your email address and press verify button to get access to the app.',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                CustomButton(
                  padded: true,
                  title: Text('Send Verification Code'),
                  pressed: (){
                    onSendVerification.call();
                  },
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                CustomButton(
                  padded: true,
                  title: Text('I have Verified'),
                  pressed: () async {
                    onVerified.call();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.close, color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (){
          onSignOut.call();
        },
      ),
    );
  }
}
