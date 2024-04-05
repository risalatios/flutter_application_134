import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_134/TabbarForApp/AboutUsScreen.dart';
import 'package:flutter_application_134/TabbarForApp/LoginScreen.dart';
import 'package:flutter_application_134/TabbarForApp/PrivacyPolicyScreen.dart';
import 'package:flutter_application_134/TabbarForApp/SessionManager.dart';
import 'package:flutter_application_134/TabbarForApp/TermsAndConditionScreen.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _imageFile;

  // Function to open the device's camera and capture an image
  Future<void> _captureImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              CircleAvatar(
           radius: 50,
           backgroundImage: AssetImage('images/carton.png'),
          ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _captureImage,  // Call function to open camera
              child: Text('Take Picture'),
            ),
          ],
        ),
      ),
    );
  }
}


class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Add form fields to edit profile information
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save profile changes and navigate back to the profile screen
                Navigator.pop(context);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}




class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Bringin',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/loginback.png'),
                  
                    )),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Home'),
            onTap: () => {
             Navigator.of(context).pop()
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            
            title: Text('Privacy Policy'),
            onTap: () => {  Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
            )},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Terms & Conditions'),
            onTap: () => {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TermsAndConditionScreen()),
            )
            },
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('About Us'),
            onTap: () => {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutUsScreen()),
            )
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
               showMyAlertDialog(
              context,
              "Alert",
              "Are you sure you want to logout",
            ),
              },
          ),
        ],
      ),
    );
  }
}

void showMyAlertDialog(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () {
            SessionManager.isLoginSave("false");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
            },
            child: Text("YES"),
          ),

          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("NO"),
          ),
        ],
      );
    },
  );
}