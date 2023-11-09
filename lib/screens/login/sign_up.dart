import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:henskens/models/AccountData.dart';
import 'package:http/http.dart' as http;

import '../shares/bottomNavigation.dart';
import 'login_form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  late AnimationController _animationController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  Future<void> registerUser(AccountData data) async {
    final url = Uri.parse('https://api-gateway-peterhensk.cloud.okteto.net/signup');
    final headers = {'Content-Type': 'application/json'};
    final body = data.toJson();

    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      // Registration successful
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully signed up!')),
      );
    } else if (response.statusCode == 409) {
      // User with this email already exists
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User with this email already exists.')),
      );
    } else {
      // Handle other errors
      final responseContent = response.body;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Registration failed. Please try again. Error: $responseContent')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailAddressController,
                decoration: const InputDecoration(labelText: 'Email Address'),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(labelText: 'Phone number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Confirm Password'),
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle sign up
                    registerUser(AccountData(
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      emailAddress: _emailAddressController.text,
                      phoneNumber: _phoneNumberController.text,
                      password: _passwordController.text,
                    ));
                    // leeg maken
                    _firstNameController.clear();
                    _lastNameController.clear();
                    _emailAddressController.clear();
                    _phoneNumberController.clear();
                    _passwordController.clear();
                    _confirmPasswordController.clear();
                  }
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
