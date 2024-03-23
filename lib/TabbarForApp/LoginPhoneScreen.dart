import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_134/TabbarForApp/LoginController.dart';
import 'package:flutter_application_134/TabbarForApp/TabbarViewCustom.dart';


class LoginPhoneScreen extends StatefulWidget {
   LoginPhoneScreen({super.key});

  @override
  State<LoginPhoneScreen> createState() => _LoginPhoneScreenState();
}

class _LoginPhoneScreenState extends State<LoginPhoneScreen> {

  TextEditingController phoneNumberController=TextEditingController();
  List<TextEditingController> controllers=[];

  bool isOtpSent=false;

  List<FocusNode> focusNodes=[];
  String enteredOtp='';

  late StreamController<int> _numberStreamController = StreamController<int>.broadcast();

  late Timer _timer;
   int _start = 70;



  Widget _getAppbarLogo(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset('images/tacologo.png',height: 150,),
      ],
    );
  }

  Widget  _getTitleDesc(String title,String subtitle){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
        const SizedBox(height: 8,),
        GestureDetector(onTap: (){
          if(isOtpSent){
            isOtpSent=false;
            stopTimer();
          }
        },child: Text(subtitle,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 16))),
        const SizedBox(height: 16,),
      ],
    );
  }

  Widget _getPhoneNumberContainer(){
    return Container(
      height: 100,
      width: double.maxFinite,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black,width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Mobile no.'),
          _getPhoneNumberInputField()
        ],
      ),
    );
  }

  void generateOtp()async{
    final response = await loginController.generateOtp(phoneNumberController.text);
    showSnackBar(response['message']);
    setState(() {
      isOtpSent=true;
      _start=70;
      startTimer();
    });
  }

  void verifyOtp()async{
    final response= await loginController.verifyOtp(phoneNumberController.text,enteredOtp);
    showSnackBar('Login Successfully!');
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  TabbarViewCustom()));

  }

  Widget _getSubmitButton(){
    return GestureDetector(
      onTap: (){
          if(!isOtpSent){
            if(phoneNumberController.text.isEmpty ||int.parse(phoneNumberController.text[0]) < 6 || phoneNumberController.text.length < 10){
              showSnackBar('invalid number');
              return;
            }
            generateOtp();
          }else{
            if(enteredOtp.isEmpty || enteredOtp.length != 6){
              showSnackBar('invalid otp');
            }else{
              verifyOtp();
            }
               }


      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal:12),
        decoration: const BoxDecoration(
         color: Colors.deepPurple
        ),
        child:  Center(child: Text((!isOtpSent)?'continue with otp >':'Confirm OTP',style: const TextStyle(color: Colors.white),)),
      ),
    );
  }

  Widget _getPhoneNumberInputField(){
    return Row(
      children: [
        const Text('+91 - '),
        Expanded(
          child: TextFormField(
            controller: phoneNumberController,
            keyboardType: TextInputType.number,
            maxLength: 10,
            decoration: const InputDecoration(
              counterText: ''
            ),
          ),
        ),
      ],
    );
  }

  Widget _getPhoneNumberField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32,),
        _getTitleDesc('Just 10 Digits'.toUpperCase(),'to get started!'.toUpperCase()),
        _getPhoneNumberContainer(),
        const SizedBox(height: 32,),
      ],
    );
  }

  Widget _getPhoneOtpField(BuildContext context){
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32,),
        _getTitleDesc('confirm otp'.toUpperCase(),'otp sent to your mobile no. ${phoneNumberController.text}'),
        // const SizedBox(height: 32,),
        _resendOtpCounter(),
        const SizedBox(height: 16,),
        _getOtpInputField(context,6),
        const SizedBox(height: 16,),
        _confirmTerms(),
        const SizedBox(height: 16,),
      ],
    );
  }

  Widget _resendOtpCounter(){
    return StreamBuilder<int>(
      stream: _numberStreamController.stream,
      builder: (context, snapshot) {
        return snapshot.data == null ?const SizedBox() :Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Enable Resend In : ${snapshot.data}'),
            GestureDetector(onTap: (){
              _start=70;
              startTimer();
              showSnackBar('OTP Sent Successfully!');
            },child: Text('resend otp',style: TextStyle(color: snapshot.data == 0 ? Colors.blue:Colors.grey ),))
          ],
        );
      }
    );
  }

  Widget _getOtpInputField(BuildContext context,int length){
    final List<Widget> inputFields=[];
    for(int i=0;i< length;i++){
      controllers.add(TextEditingController());
      focusNodes.add(FocusNode() );
      inputFields.add(_getInputField(controllers[i],focusNodes[i],(text){
        if(i < length-1){
          FocusScope.of(context).requestFocus(focusNodes[i+1]);
        }else{
          enteredOtp='';
          controllers.forEach((element) {
            enteredOtp=enteredOtp+element.text;
          });
        }
      }));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: inputFields,
    );
  }

  Widget _getInputField(TextEditingController controller,FocusNode focusNode,Function(String) onChanged){
    return Container(
      height: 40,
      width: 40,
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black,width: 1)
      ),
      child: Center(
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          maxLength: 1,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          onChanged: onChanged,
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none
          ),
        ),
      ),
    );
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

   void stopTimer(){
    setState(() {
      _start = 0;
    });
   }

   Widget _confirmTerms(){
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('By confirming OTP you agree to our',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800),),
        SizedBox(width: 6.0,),
        Text('Terms',style: TextStyle(
          decoration: TextDecoration.underline,
          color: Colors.deepPurple,
          fontWeight: FontWeight.bold
        ),)
      ],
    );
   }

   void showSnackBar(String message){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
       content: Text(message),
     ));
   }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          padding:const EdgeInsets.symmetric(horizontal: 20) ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32,),
              _getAppbarLogo(),
              (!isOtpSent) ?_getPhoneNumberField(): _getPhoneOtpField(context),
              _getSubmitButton()
            ],
          ),
        ),
      ),
    );
  }

   @override
   void dispose() {
     _numberStreamController.close();
    _timer.cancel();
   }
}
