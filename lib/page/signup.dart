import 'package:flutter/material.dart';
import 'package:flutter_application_2/page/selectprofile.dart';
import 'package:form_field_validator/form_field_validator.dart';

void main() {
  runApp(Signup());
}

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String email = "";
  String password = "";
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00A5F3),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xff00A5F3),
        elevation: 0.0,
        title: Text(
          "Sign Up",
          style: TextStyle(fontSize: 32.0, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 100.0),
                child: InkWell(
                  customBorder: new CircleBorder(),
                  child: Stack(
                    children: [
                      ClipOval(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          color: Colors.white,
                          height: 120.0,
                          width: 120.0,
                          child: Image(
                            fit: BoxFit.fill,
                            image: AssetImage("asset/profile.png"),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 5,
                        child: ClipOval(
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(2.0),
                            child: ClipOval(
                              child: Container(
                                color: Colors.blue[800],
                                padding: EdgeInsets.all(7.0),
                                child: Icon(
                                  Icons.edit,
                                  size: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SelectProfile()));
                  },
                ),
              ),
              /* Container(
              height: 200.0,
              width: 300.0,
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        child: Card(
                          child: Image(
                            image: AssetImage("asset/logo_1"),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(),
                  Row(),
                ],
              ),
            ), */
              Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: false,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        validator: MultiValidator(
                          [
                            EmailValidator(errorText: "Invalid Email!"),
                            RequiredValidator(
                                errorText: "Email address is Required"),
                          ],
                        ),
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                                borderSide: BorderSide(width: 10.0)),
                            hintText: "Email Address",
                            suffixIcon: Icon(Icons.email)),
                        onChanged: (_val) {
                          email = _val;
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: TextFormField(
                          validator: MultiValidator(
                            [
                              MinLengthValidator(6,
                                  errorText: "Invalid password!"),
                              RequiredValidator(
                                  errorText: "Password address is Required"),
                            ],
                          ),
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w600),
                          autofocus: false,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                  borderSide: BorderSide(width: 10.0)),
                              hintText: "Password",
                              suffixIcon: Icon(Icons.lock)),
                          onChanged: (_val) {
                            password = _val;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 60.0),
                            shadowColor: Colors.black,
                            primary: Colors.black,
                          ),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 25.0),
                          ),
                        ),
                      ),
                    ],
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already Have an Account?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.black,
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
