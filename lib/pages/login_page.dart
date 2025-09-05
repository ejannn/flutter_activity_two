import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import '../models/user_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  // 🔹 Local users (email, password, fullName, age)
  final List<Map<String, dynamic>> _users = [
    {
      "email": "bonna@example.com",
      "password": "1234",
      "fullName": "Bonna Mae Pitogo",
      "age": 23,
    },
    {
      "email": "beth@example.com",
      "password": "5678",
      "fullName": "Mary Beth Gracia",
      "age": 21,
    },
    {
      "email": "nieljhon@example.com",
      "password": "nieljhon1",
      "fullName": "Niel Jhon Celocia",
      "age": 22,
    },
    {
      "email": "seth@example.com",
      "password": "seth1234",
      "fullName": "Seth Sitjar",
      "age": 23,
    },
  ];

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      // Check if email+password matches one of the users
      final userData = _users.firstWhere(
        (user) => user["email"] == email && user["password"] == password,
        orElse: () => {},
      );

      if (userData.isNotEmpty) {
        final user = UserModel(
          email: userData["email"],
          username: userData["email"].split('@')[0],
          fullName: userData["fullName"],
          age: userData["age"],
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage(user: user)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid email or password")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🔹 Top NavBar
      appBar: AppBar(
        title: const Text(
          "Login Page",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1565C0), // Medium blue
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFE3F2FD), // 🔹 Light blue background
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: const Color(0xFFBBDEFB), // 🔹 Soft blue card
              shadowColor: const Color(
                0xFF1565C0,
              ).withOpacity(0.6), // Medium blue shadow
              margin: const EdgeInsets.symmetric(horizontal: 400, vertical: 50),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.lock_outline,
                        size: 80,
                        color: Color(0xFF1565C0),
                      ),
                      const SizedBox(height: 16),

                      const Text(
                        "WELCOME!",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1565C0),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Email field
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter your email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Password field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter your password";
                          }
                          if (value.length < 4) {
                            return "Password must be at least 4 characters";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // Login button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: const Color(
                              0xFF1565C0,
                            ), // Medium blue button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _login,
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
