import 'package:flutter/material.dart';
import 'package:manga_cat/components/API/LoginAPI.dart';
import 'package:manga_cat/components/Classes/Login.dart';
import 'package:manga_cat/components/LoginScreenComponents/LoginProgress.dart';
import 'package:manga_cat/components/UniversalComponents/MainAppBar.dart';
import 'package:manga_cat/components/UniversalComponents/SideMenu.dart';
import 'package:manga_cat/resources/Constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Class - LoginScreen
// Functionality - Another class pertaining to screen, which means I did not write this, and for the most part the code is word for word from a youtube tutorial.
//                 The class display a form for our user to fill out. The form checks for whether input is valid or not and then sends the input data to our loginAPI class
//                so we can receive a token to be used in our follow functionality of the app.

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  bool hidePass = true;
  bool APICallInProg = false;
  late LoginRequestModel model;
  final storage = FlutterSecureStorage();

  void initState() {
    super.initState();
    model = LoginRequestModel(email: 'email', password: 'password');
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    var check = form?.validate();

    if(check != null ? check : false) {
      form?.save();
      return true;
    }
    print('fail');
    return false;
  }

  Widget build(BuildContext context) {
    return LoginProgress(
      child: _uiSetup(context),
      inAsyncCall: APICallInProg,
      opacity: 0.3,
      valueColor: AlwaysStoppedAnimation<Color>(Constants.titleCardGray),
    );
  }

  @override
  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: MainAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Constants.mangaWhite,
                    boxShadow: [
                      BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.2),
                      offset: Offset(0,10),
                      blurRadius: 20)
                    ]
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 25),
                        Text("Login", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                        SizedBox(height: 20),
                        TextFormField(
                          cursorColor: Constants.mangaOrange,
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => model.email = input!,
                          validator: (input)=> !input!.contains("@")
                              ? "Invalid Email"
                              : null,
                          decoration: InputDecoration(
                            hintText: "Email",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Constants.mangaOrange
                                )
                            ),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Constants.mangaOrange,),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          cursorColor: Constants.mangaOrange,
                          keyboardType: TextInputType.text,
                          onSaved: (input) => model.password = input!,
                          validator: (input)=> input!.length < 3
                              ? "Password Length too short"
                              : null,
                          decoration: InputDecoration(
                            hintText: "Password",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Constants.mangaOrange
                                )
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Constants.mangaOrange,),
                            suffixIcon: IconButton(
                              onPressed: (){
                                setState(() {
                                  hidePass = !hidePass;

                                });
                              },
                              color: Constants.mangaOrange.withOpacity(0.4),
                              icon: Icon(hidePass?Icons.visibility_off: Icons.visibility),
                            ),
                          ),
                          obscureText: hidePass,
                        ),
                        SizedBox(height: 20),
                        TextButton(
                            onPressed: () {
                              if(validateAndSave()) {
                                setState(() {
                                  APICallInProg = true;
                                });
                                LoginAPI login = LoginAPI();
                                login.login(model).then((value) async => {
                                  setState(() {
                                    APICallInProg = false;
                                  }),
                                  print(value.result),
                                  if(value.token.isNotEmpty) {
                                    print("Heres the token"),
                                    print(value.token),
                                    await storage.write(key: "token", value: value.token),
                                    await storage.write(key: "refresh", value: value.refreshToken)
                                  }
                                });
                              }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(color: Constants.mangaWhite),
                            ),
                          style: TextButton.styleFrom(
                           backgroundColor: Constants.mangaOrange,
                            shape: StadiumBorder(),
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 80
                            )
                          ),

                        )

                      ],
                    ),
                  )
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}

