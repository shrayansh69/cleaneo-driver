import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:cleaneo_driver_app/Global/global.dart';
import 'package:cleaneo_driver_app/Home/BotNav.dart';
import 'package:cleaneo_driver_app/Home/PickedUpMap/accepted.dart';
import 'package:cleaneo_driver_app/Home/PickedUpMap/delivered.dart';
import 'package:cleaneo_driver_app/Home/StartTrip/components/pickupOrderSummary.dart';
import 'package:cleaneo_driver_app/Map/enableLocation.dart';
import 'package:cleaneo_driver_app/Map/map.dart';
import 'package:cleaneo_driver_app/Screens/Driver_Onboarding/DL.dart';
import 'package:cleaneo_driver_app/Screens/Driver_Onboarding/Verifying.dart';
import 'package:cleaneo_driver_app/Screens/WelcomePage.dart';
import 'package:cleaneo_driver_app/end.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../PickupMap/map.dart';

class ReceiveOTPage extends StatefulWidget {
  String orderID;
  ReceiveOTPage({Key? key, required this.orderID}) : super(key: key);

  @override
  State<ReceiveOTPage> createState() => _ReceiveOTPageState();
}

class _ReceiveOTPageState extends State<ReceiveOTPage> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;
  int focusedIndex = -1;
  bool ispressed = false;
  String otp = '';
  int _secondsRemaining = 30;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    controllers = List.generate(4, (_) => TextEditingController());
    focusNodes = List.generate(4, (_) => FocusNode());
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer.cancel();
        // Timer expired, perform any action here
        print('Timer expired!');
      }
    });
  }

  Future<void> signUp() async {
    // Define the API endpoint
    String apiUrl = 'https://drycleaneo.com/CleaneoUser/api/signup';

    // Create the request body
    Map<String, String> requestBody = {
      'id': UserID,
      'name': Signupname,
      'email': Signupemail,
      'phone': Signupphone,
    };

    // Convert the request body to JSON format
    String jsonBody = jsonEncode(requestBody);

    try {
      // Make the POST request
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonBody,
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        print('Sign up successful');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return end();
        }));
        // You can handle the response here if needed
      } else {
        // Handle error if the request was not successful
        print('Failed to sign up. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions if any occur during the request
      print('Error signing up: $e');
    }
  }

  Future<void> _triggerApiCall() async {
    final String apiUrl =
        'https://drycleaneo.com/CleaneoVendor/api/updateOrderStatus/${widget.orderID}';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
      );

      if (response.statusCode == 200) {
        // Successful API call

        print('API call successful');
        print('hello');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return OrderAcceptedPage(); // here the Summary Page
          // will be open
        }));
      } else {
        // API call failed
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred
      print('Exception: $e');
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    print(userVendor);
    var mQuery = MediaQuery.of(context);
    final defaultPinTheme = PinTheme(
        width: mQuery.size.width * 0.23,
        height: mQuery.size.height * 0.1,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.45),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 0), // changes the position of the shadow
            ),
          ],
        ),
        textStyle: TextStyle(
            fontSize: mQuery.size.height * 0.04, fontFamily: 'SatoshiBold'));
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff006acb),
        ),
        child: Column(
          children: [
            SizedBox(height: mQuery.size.height * 0.034),
            Padding(
              padding: EdgeInsets.only(
                top: mQuery.size.height * 0.058,
                bottom: mQuery.size.height * 0.03,
                left: mQuery.size.width * 0.045,
                right: mQuery.size.width * 0.045,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigator.pop(context);
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return auth == 'Login' ? LoginPage() : SignUpPage();
                      // }));
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: mQuery.size.width * 0.045,
                  ),
                  Text(
                    "Verify Receiver OTP",
                    style: TextStyle(
                        fontSize: mQuery.size.height * 0.027,
                        color: Colors.white,
                        fontFamily: 'SatoshiBold'),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Enter 4 Digit Code $OTP",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: mQuery.size.height * 0.0215,
                              fontFamily: 'SatoshiBold'),
                        ),
                        SizedBox(height: mQuery.size.height * 0.006),

                        ///////////
                        Text(
                          "Sent to ${userVendor['UserPhone']}",
                          // (auth == 'login' ? Loginphone : Signupphone),
                          style: TextStyle(
                              fontSize: mQuery.size.height * 0.018,
                              fontFamily: 'SatoshiRegular',
                              color: Colors.black87),
                        ),
                        SizedBox(height: mQuery.size.height * 0.04),
                        Pinput(
                          length: 4,
                          defaultPinTheme: defaultPinTheme.copyWith(
                            textStyle: TextStyle(
                                fontSize: 34,
                                color: Colors.black), // Set text color to black
                          ),
                          onChanged: (value) {
                            setState(() {
                              otp = value;
                            });
                          },
                          onSubmitted: (value) {
                            setState(() {
                              otp = value;
                            });
                          },
                        ),
                        SizedBox(height: mQuery.size.height * 0.1),
                        Text(
                          "Problems receiving the code?",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: mQuery.size.height * 0.018,
                              fontFamily: 'SatoshiBold'),
                        ),
                        SizedBox(height: mQuery.size.height * 0.008),
                        GestureDetector(
                          onTap: () {
                            if (_secondsRemaining == 0) {
                              setState(() {
                                _secondsRemaining = 30;
                                _startTimer();
                                OTP =
                                    (1000 + Random().nextInt(9000)).toString();
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.refresh,
                                color: Color(0xff29b2fe),
                              ),
                              SizedBox(width: mQuery.size.width * 0.015),
                              Text(
                                "RESEND",
                                style: TextStyle(
                                    color: Color(0xff29b2fe),
                                    fontSize: mQuery.size.height * 0.018,
                                    fontFamily: 'SatoshiBold'),
                              ),
                              SizedBox(width: mQuery.size.width * 0.015),
                              if (_secondsRemaining > 0)
                                Text(
                                  '$_secondsRemaining seconds remaining',
                                  style: TextStyle(
                                      color: Color(0xff29b2fe),
                                      fontSize: mQuery.size.height * 0.014,
                                      fontFamily: 'SatoshiBold'),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: mQuery.size.height * 0.35),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              ispressed = true;
                            });
                            if (OTP == otp) {
                              print(widget.orderID);
                              _triggerApiCall();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Wrong OTP. Try again.'),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.all(16.0),
                                ),
                              );
                              setState(() {
                                ispressed = false;
                              });
                            }
                          },
                          // onTap: () {
                          //   Navigator.push(context,
                          //       MaterialPageRoute(builder: (context) {
                          //     return DL();
                          //   }));
                          // },
                          child: Container(
                            width: double.infinity,
                            height: mQuery.size.height * 0.06,
                            decoration: BoxDecoration(
                                color: Color(0xff29b2fe),
                                borderRadius: BorderRadius.circular(6)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    ispressed == true ? "Verifying" : "Verify",
                                    style: TextStyle(
                                        fontSize: mQuery.size.height * 0.02,
                                        color: Colors.white,
                                        fontFamily: 'SatoshiBold'),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  if (ispressed == true)
                                    GFLoader(
                                      type: GFLoaderType.ios,
                                      loaderColorOne: Colors.white,
                                      loaderColorThree: Colors.white,
                                      loaderColorTwo: Colors.white,
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OTPBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isFocused;

  OTPBox(
      {required this.controller,
      required this.focusNode,
      required this.isFocused});

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    return Container(
      width: mQuery.size.width * 0.18,
      height: mQuery.size.width * 0.63,
      child: TextField(
        style: TextStyle(fontSize: 30),
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
