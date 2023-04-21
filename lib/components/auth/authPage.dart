import 'package:flutter/cupertino.dart';
import 'package:paletti_1/components/auth/loginWidget.dart';
import 'package:paletti_1/components/auth/signUpWidget.dart';

class Authpage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<Authpage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? LoginWidget(
          onClickedSignUp: toogle,
        )
      : SignUpWidget(onClickedSignIn: toogle);

  void toogle() => setState(() => isLogin = !isLogin);
}
