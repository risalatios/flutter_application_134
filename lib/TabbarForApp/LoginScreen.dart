import 'package:flutter/material.dart';
import 'package:flutter_application_134/TabbarForApp/AppLoader.dart';
import 'package:flutter_application_134/TabbarForApp/LoginController.dart';
import 'package:flutter_application_134/TabbarForApp/LoginPhoneScreen.dart';
import 'package:flutter_application_134/TabbarForApp/OtpVerifyScreen.dart';
import 'package:flutter_application_134/TabbarForApp/TabbarViewCustom.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _phoneNumberController = TextEditingController();
  String mobileNumber = '';
   bool isLoading = false;



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/loginback.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: isLoading
          ? AppLoader() // Show loader if loading state is true
          : Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 100, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage("images/tacologo.png"),
                    height: 96,
                    width: 67,
                  ),
                  SizedBox(height: 44),
                  Text(
                    'JUST 10 DIGITS\nTO GET STARTED',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 44),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 4, left: 10),
                          child: Text(
                            'Mobile No.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                          Row(
            children: [
           Padding(
           padding: EdgeInsets.symmetric(horizontal: 10),
         child: Text(
        '+91 -',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
    ),
    Flexible( // Wrap the TextField with Flexible
      child: TextField(
        keyboardType: TextInputType.phone,
        controller: _phoneNumberController,
         maxLength: 10,
       decoration: InputDecoration(
      counterText: ''
     ),
     )
    ),
  ],
),

                      ],
                    ),
                  ),
                  SizedBox(height: 44),
                  GestureDetector(
                    onTap: () {
                      String phoneNumber = _phoneNumberController.text.trim();
                    if (phoneNumber.isEmpty || phoneNumber.length != 10) {
                         MyDialogUtils.showDialogBox(context, "Please Enter 10 Digits Phone Number");
                      } else {
                        print('sending this number otp: $phoneNumber');
                        generateOtp();
                      }
                    },
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(124, 65, 159, 1),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Continue with top',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/rightarrow.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  void generateOtp()async{
     mobileNumber =  _phoneNumberController.text;
    setState(() {
      isLoading = true; // Set loading state to true
    });
    final response = await loginController.generateOtp(mobileNumber);
    setState(() {
      isLoading = true; // Set loading state to true
    });
     if (response["status"] == 200){
         Navigator.push(
       context,
     MaterialPageRoute(
    builder: (context) => OtpVerifyScreen(mobileNumber: mobileNumber),
  ),
);
     }else{
       String message = "Otp sending failed used valid number";
      MyDialogUtils.showDialogBox(context, message);
     }
     print(response);
     
  }

}

class MyDialogUtils {
  static void showDialogBox(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alert"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
