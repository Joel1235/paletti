import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class palletOverview extends StatefulWidget {


  @override
  _palettOverview createState() => _palettOverview();
}

class _palettOverview extends State<palletOverview> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: LoginWidget(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height:40),
            Text('PalletOverview works')
          ],
        ),
      ),
    );
  }


 /* @override
  Widget build(BuildContext context) => SingleChildScrollView(
    return Scaffold
    padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            TextFormField(
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Enter amount'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              //validator: (email) => email != null && !EmailValidator.validate(email)
                //  ? 'Enter a valid email'
                  //: null,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50)
              ),
              icon: Icon(Icons.lock_open, size: 32),
              label: Text(
                'Sign In',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: submitPallets,
            )
          ],
        ),
  );*/

  Future submitPallets(){
    throw UnimplementedError();
  }
}