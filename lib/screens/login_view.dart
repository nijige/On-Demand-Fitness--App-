import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:training_diet_app/screens/home_view.dart';
import 'package:training_diet_app/screens/welcom_view.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    return Theme(
      data: Theme.of(context).copyWith(
        iconTheme: IconThemeData(
            color: Colors.green), // Definindo a cor verde para os ícones
      ),
      child: FlutterLogin(
        title: 'On-Demand Fitness',
        logo: AssetImage('assets/images/back.png'),
        onLogin: (_) => Future(() => null),
        onSignup: (_) => Future(() => null),
        onSubmitAnimationCompleted: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => WelcomView(),
          ));
        },
        onRecoverPassword: (_) => Future(() => null),
        theme: LoginTheme(
          primaryColor: Color(0xFF53516E),
          accentColor: Colors.green,
          errorColor: Colors.green,
          titleStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'Quicksand',
            letterSpacing: 4,
          ),
          bodyStyle: TextStyle(
            fontStyle: FontStyle.italic,
            decoration: TextDecoration.underline,
          ),
          textFieldStyle: TextStyle(
            color: Colors.black,
            shadows: [Shadow(color: Colors.white, blurRadius: 2)],
          ),
          buttonStyle: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
          cardTheme: CardTheme(
            color: Colors.green.shade100,
            elevation: 5,
            margin: EdgeInsets.only(top: 15),
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
          inputTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.green.withOpacity(.1),
            contentPadding: EdgeInsets.zero,
            errorStyle: TextStyle(
              backgroundColor: Colors.green,
              color: Colors.white,
            ),
            labelStyle: TextStyle(fontSize: 12),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green.shade700, width: 4),
              borderRadius: inputBorder,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green.shade400, width: 5),
              borderRadius: inputBorder,
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green.shade700, width: 7),
              borderRadius: inputBorder,
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green.shade400, width: 8),
              borderRadius: inputBorder,
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 5),
              borderRadius: inputBorder,
            ),
          ),
          buttonTheme: LoginButtonTheme(
            splashColor: Colors.green,
            backgroundColor: Colors.green,
            highlightColor: Colors.lightGreen,
            elevation: 9.0,
            highlightElevation: 6.0,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
