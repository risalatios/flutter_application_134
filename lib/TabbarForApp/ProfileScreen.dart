import 'dart:io';

import 'package:flutter/material.dart';
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
