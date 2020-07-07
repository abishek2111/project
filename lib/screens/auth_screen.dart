import 'package:app1/helper/dimensions.dart';
import 'package:app1/scoped_model/main_scoped_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  var viewportHeight;
  var viewportWidth;
  final _codeController = TextEditingController();

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  var _formData = {
    'Govt_id': '',
    'Phone_num': '',
  };

  Future<Null> loginUser(
      String phone, MainModel model, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        AuthResult result = await _auth.signInWithCredential(credential);

        FirebaseUser user = result.user;

        if (user != null) {
          Navigator.of(context).pop();
          print('Automatic OTP succcess');
          _submitForm(model);
        }
        // This call back is only gets called when the verification is done automatically i.e (auto-code-retrival)
      },
      verificationFailed: (AuthException exception) {
        print('Here is an exception in otp verification: $exception');
      },
      codeSent: (String verificationId, [int forceResendingToken]) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text('Give the code?'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: _codeController,
                  )
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () async {
                    final code = _codeController.text.trim();
                    AuthCredential credential = PhoneAuthProvider.getCredential(
                        verificationId: verificationId, smsCode: code);

                    AuthResult result =
                        await _auth.signInWithCredential(credential);

                    FirebaseUser user = result.user;

                    if (user != null) {
                      print('Manual OTP succcess');
                      _submitForm(model);
                    } else {
                      print('Error');
                    }
                  },
                  child: Text('Confirm'),
                  textColor: Colors.white,
                  color: Colors.blue,
                )
              ],
            );
          },
        );
      },
      codeAutoRetrievalTimeout: null,
    );
  }

  Widget searchWidget(String placeholder) {
    var keyboard;
    if (placeholder == 'Govt_id') {
      keyboard = TextInputType.text;
    } else {
      keyboard = TextInputType.text;
    }
    return TextFormField(
      onChanged: (String value) {
        if (placeholder == 'Govt_id') {
          _formData['Govt_id'] = value;
        } else {
          _formData['Phone_num'] = value;
        }
      },
      validator: (input) {
        if (input.isEmpty) {
          return 'Fiels can not be left empty';
        }
      },
      keyboardType: keyboard,
      onSaved: (String value) {
        if (placeholder == 'Govt_id') {
          _formData['Govt_id'] = value;
        } else {
          _formData['Phone_num'] = value;
        }
      },
      style: TextStyle(
        fontSize: getViewportHeight(context) * 0.025,
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        alignLabelWithHint: false,
        prefixIcon: Icon(
          placeholder == 'Govt_id' ? Icons.perm_identity : Icons.phone_android,
          color: Theme.of(context).accentColor,
          size: getViewportHeight(context) * 0.04,
        ),
        labelText: placeholder,
        labelStyle: TextStyle(
          fontSize: viewportHeight * 0.03,
          color: Colors.grey,
          fontWeight: FontWeight.w600,
        ),
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 2),
        ),
      ),
    );
  }

  Widget _button(String title, MainModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Container(
        width: viewportWidth * 0.7,
        child: RaisedButton(
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: viewportHeight * 0.03,
              ),
            ),
          ),
          onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());
            final phone = _formData['Phone_num'];
            loginUser('+91' + phone, model, context);
            // _submitForm(model);
          },
        ),
      ),
    );
  }

  void _submitForm(MainModel model) {
    if (_formKey.currentState.validate()) {
      print('Inside');
      _formKey.currentState.save();
      model
          .userLogin(_formData['Govt_id'], _formData['Phone_num'])
          .then((value) {
        if (value) {
          Navigator.of(context).pushReplacementNamed('/home');
        } else {
          print('Login Failed');
          return;
        }
      });
    } else {
      print('not validated');
    }
  }

  @override
  Widget build(BuildContext context) {
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);
    return SafeArea(
        child: GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: ScopedModelDescendant<MainModel>(
          builder: (context, child, model) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Center(
                      child: Text(
                        'Payroll App',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo[900]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 30),
                    child: Container(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            searchWidget('Govt_id'),
                            SizedBox(
                              height: 40,
                            ),
                            searchWidget('Phone_Num'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _button('NEXT', model),
                ],
              ),
            );
          },
        ),
      ),
    ));
  }
}
