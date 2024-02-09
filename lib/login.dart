import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_backend/mainpage.dart';
import 'dart:js' as js;

class Next extends StatelessWidget {
  Next({super.key});

  @override
  final logintext = TextEditingController();
  final passtext = TextEditingController();

  Widget build(BuildContext context) { 
    //Deafult Credentials for the login
    // logintext.text = 'Ahmad Malik';
    // passtext.text = '1141';

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image:  NetworkImage('images/bg.jpg'),// <-- BACKGROUND IMAGE
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 50,
                  width: double.infinity,
                ),
                Container(
                  height: 600,
                  width: 500,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white.withOpacity(0.75)),
                  child: Column(children: [
                    const SizedBox(
                      height: 30,
                      width: double.infinity,
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Admin Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                      width: double.infinity,
                    ),
                    Image.network(
                      'images/user.png',
                      height: 150,
                      width: 150,
                    ),
                    const SizedBox(height: 60),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: logintext,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Username',
                          contentPadding: EdgeInsets.all(15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                        ),
                        style: const TextStyle(fontSize: 18),
                        maxLines: 1,
                        minLines: 1,
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        obscureText: true,
                        controller: passtext,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.key),
                          labelText: 'Password',
                          contentPadding: EdgeInsets.all(15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                        ),
                        style: const TextStyle(fontSize: 18),
                        maxLines: 1,
                        minLines: 1,
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: 240,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(const Color(0xff2327da)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              )),
                        ),
                        onPressed: () {// simple if statement for login
                          if (logintext.text == ('Ahmad Malik') &&
                              passtext.text == ('1141')) {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    fullscreenDialog: true,
                                    builder: (context) => const Mainpage()));
                            logintext.text = '';
                            passtext.text = '';
                          } else {
                            js.context
                                .callMethod("showAlert", ["Wrong Info Entered"]);
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 20,color: Colors.white),
                        ),
                      ),
                    ),
                  ],),
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
