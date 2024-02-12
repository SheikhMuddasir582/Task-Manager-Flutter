import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/auth/home_screen.dart';
import 'package:task_manager/ui/auth/signup_screen.dart';
import 'package:task_manager/utils/round_button.dart';
import 'package:task_manager/utils/utils.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailControl= TextEditingController();
  final passwordControl= TextEditingController();
  final _formkey= GlobalKey<FormState>();
  bool loading= false;
  final _auth= FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailControl.dispose();
    passwordControl.dispose();
  }

  void login(){
    setState(() {
      loading= true;
    });
    _auth.signInWithEmailAndPassword(email: emailControl.text.toString(),
        password: passwordControl.text.toString()).then((value){
      Utils().toastMessage1(value.user!.email.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      // Navigator.push(context, MaterialPageRoute(builder: (context) => FireStoreMark()));
      setState(() {
        loading= false;
      });

    }).onError((error, stackTrace){
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading= false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      //controller: emailControl,
                      decoration: InputDecoration(
                        hintText: 'Email',

                        prefixIcon: const Icon(
                          Icons.alternate_email,
                          color: Color(0xff323F4B),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'enter email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      //controller: passwordControl,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'password',
                        prefixIcon: const Icon(
                          Icons.lock_open,
                          color: Color(0xff323F4B),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'enter password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30,),
                  ],
                )),
            RoundButton(title: 'Login',
              loading: loading,
              onTap: (){
                if(_formkey.currentState!.validate()){
                  login();
                }
              },
            ),

            // Align(
            //   alignment: Alignment.bottomRight,
            //   child: TextButton(onPressed: (){
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPasswordScreen()));
            //   }, child: Text('Forget Password?', style: TextStyle(decoration: TextDecoration.underline),)),
            // ),

            SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("don't have an account?"),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                }, child: Text('sign up')),
              ],
            ),
            SizedBox(height: 30,),
            // InkWell(
            //   onTap: (){
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => LoginWithPhoneNummber()));
            //   },
            //   child: Container(
            //     height: 50,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(50),
            //         border: Border.all(
            //           color: Colors.black,
            //         )
            //     ),
            //     child: Center(
            //       child: Text('Login with Phone'),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );

  }
}