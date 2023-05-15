import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _tokenController = TextEditingController();
  bool _isLoading = false;
  User? _user; // Track the signed-in user

  @override
  void initState() {
    super.initState();
    // Check if a user is already signed in
    _user = _auth.currentUser;
  }

  Future<void> _signInWithToken() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential =
          await _auth.signInWithCustomToken(_tokenController.text.trim());
      // User is signed in
      _user = userCredential.user;
      // Do something with the user
    } catch (error) {
      // Handle error
      print('Error: $error');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_user != null) // Display UID if user is signed in
                Text('Signed in as: ${_user!.uid}'),
              TextField(
                controller: _tokenController,
                decoration: InputDecoration(
                  labelText: 'Custom Token',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _isLoading ? null : _signInWithToken,
                child:
                    _isLoading ? CircularProgressIndicator() : Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
