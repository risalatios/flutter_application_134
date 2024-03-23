import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_134/TabbarForApp/AppLoader.dart';
import 'package:flutter_application_134/TabbarForApp/LoginController.dart';
import 'package:flutter_application_134/TabbarForApp/LoginScreen.dart';
import 'package:flutter_application_134/TabbarForApp/TabbarViewCustom.dart';
import 'package:shared_preferences/shared_preferences.dart';
class OtpVerifyScreen extends StatefulWidget {
  final String mobileNumber;

  const OtpVerifyScreen({Key? key, required this.mobileNumber}) : super(key: key);
  
  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}


class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  late StreamController<int> _numberStreamController = StreamController<int>.broadcast();
  
   bool isLoading = false;
  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];
  String enteredOtp = '';
   String token = '';
  String mobileNumber = '';
  late Timer _timer;
  int _start = 70;
   


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: isLoading
          ? AppLoader() // Show loader if loading state is true
          : SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 32,
              ),
              _getAppbarLogo(),
              _getOtpDesc(),
              _timerLayout(),
              //_resendOtpCounter(),
              _getOtpInputField(context, 6),
              _confirmTerms(),
              _confirmOTP(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getAppbarLogo() {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 20, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'images/tacologo.png',
            height: 80,
          ),
        ],
      ),
    );
  }

  Widget _getOtpDesc() {
    return Container(
      margin: const EdgeInsets.only(top: 45.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15.0),
            height: 38.0,
            child: Text(
              'Confirm otp'.toUpperCase(), // Convert text to upper case
              style: const TextStyle(
                fontFamily: 'josefinsans_bold',
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15.0, top: 5.0),
            child:  Text(
              'OTP sent your mobile number ${widget.mobileNumber}', //.toUpperCase(), // Convert text to upper case
              style: TextStyle(
                fontFamily: 'josefinsans_bold',
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _resendOtpCounter() {
    return StreamBuilder<int>(
        stream: _numberStreamController.stream,
        builder: (context, snapshot) {
          return snapshot.data == null
              ? const SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Resend In : ${snapshot.data}'),
                    GestureDetector(
                        onTap: () {
                          _start = 70;
                          startTimer();
                          // showSnackBar('OTP Sent Successfully!');
                        },
                        child:
                          GestureDetector(
                    onTap: () {
                      generateOtp();
                    },
                          child: Text(
                          'resend otp',
                          style: TextStyle(
                              color: snapshot.data == 0
                                  ? Colors.blue
                                  : Colors.grey),
                        )))
                  ],
                );
        });
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        print('timer is $_start');
        if (_start == 0) {
          timer.cancel();
          _numberStreamController.sink.add(0);
        } else {
          _numberStreamController.sink.add(--_start);
        }
      },
    );
  }

  void generateOtp()async{
    setState(() {
      isLoading = true; // Set loading state to true
    });
    final response = await loginController.generateOtp(mobileNumber);
    setState(() {
      isLoading = true; // Set loading state to true
    });
     if (response["status"] == 200){
      //
     }else{
       String message = "Otp sending failed used valid number";
      MyDialogUtils.showDialogBox(context, message);
     }
     print(response);
     
  }

  @override
  void dispose() {
    super.dispose();
    _numberStreamController.close();
    _timer.cancel();
  }

  Widget _timerLayout() {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 20, 18, 0),
      padding: const EdgeInsets.all(3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Text(
                '70',
                style: TextStyle(
                  fontFamily: 'josefinsans_regular',
                  fontSize: 16,
                  color: Colors.black45,
                ),
              ),
              SizedBox(width: 2),
              Text(
                'Seconds Left',
                style: TextStyle(
                  fontFamily: 'josefinsans_regular',
                  fontSize: 16,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Visibility(
                visible: false, // Set visibility as needed
                child: SizedBox(
                  width: 20,
                  height: 20,
                  // Circular progress
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
              ),
              const Visibility(
                visible: true, // Set visibility as needed
                child: Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Text(
                    'Resend OTP',
                    style: TextStyle(
                      fontFamily: 'josefinsans_bold',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Add navigation logic here
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Icon(
                    Icons.navigate_next,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // otp input field
  Widget _getOtpInputField(BuildContext context, int length) {
    final List<Widget> inputFields = [];
    for (int i = 0; i < length; i++) {
      controllers.add(TextEditingController());
      focusNodes.add(FocusNode());
      inputFields.add(_getInputField(controllers[i], focusNodes[i], (text) {
        if (i < length - 1) {
          FocusScope.of(context).requestFocus(focusNodes[i + 1]);
        } else {
          enteredOtp = '';
          for (var element in controllers) {
            enteredOtp = enteredOtp + element.text;
          }
        }
      }));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: inputFields,
    );
  }

  Widget _getInputField(TextEditingController controller, FocusNode focusNode,
      Function(String) onChanged) {
    return Container(
      height: 40,
      width: 40,
      //margin: const EdgeInsets.only(right: 8),
      margin: const EdgeInsets.fromLTRB(0, 30, 8, 0),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
      child: Center(
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          maxLength: 1,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          onChanged: onChanged,
          decoration: const InputDecoration(counterText: ''),
        ),
      ),
    );
  }

// confirm text terms
  Widget _confirmTerms() {
    return Container(
      // Adjust the margin value as needed
      margin: const EdgeInsets.only(top: 30.0),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'By confirming OTP you agree to our',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
          ),
          SizedBox(
            width: 6.0,
          ),
          Text(
            'Terms',
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _confirmOTP(BuildContext context) {
    Color customColor = const Color(0xFF672B8D);
    return GestureDetector(
       onTap: () {
           if (enteredOtp.isEmpty || enteredOtp.length != 6) {
                     MyDialogUtils.showDialogBox(context, "Please Enter 6 Digits Otp");
                  } else {
                        print('sending this number otp: $enteredOtp');
                         verifyOtp();
                      }
     
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 40, 15, 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: customColor //Colors.blueAccent,
            ),
        child: const Material(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'CONFIRM OTP',
                  style: TextStyle(
                    fontFamily: 'overpass_bold',
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 5), // Add some space between text and icon
                Icon(
                  Icons.navigate_next,
                  size: 20,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void verifyOtp()async{
      print("fvdffdv ${widget.mobileNumber}");
    final response = await loginController.verifyOtp(widget.mobileNumber,enteredOtp);
     if (response["status"] == 200){
        navigateToOtpScreen(context);
     String tokenForApi = response['data']['token'];
       saveToken(tokenForApi);
     }else{
      String message = "verify otp failed used valid otp";
      MyDialogUtils.showDialogBox(context, message);
     }
     print(response);
     
  }
  Future<void> saveToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', token);
}

  void navigateToOtpScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) =>  TabbarViewCustom()));
  }
}