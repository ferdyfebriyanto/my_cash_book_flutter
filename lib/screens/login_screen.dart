import 'package:flutter/material.dart';
import 'package:my_cash_book_flutter/screens/beranda_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _username = TextEditingController();

  bool checkValid = true;
  bool passwordHidden = true;

  void _login() {
    if (_password.text.isNotEmpty) {
      setState(() {
        if (_password.text == "123456" && _username.text == "admin") {
          checkValid = true;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const Beranda();
              },
            ),
          );
          const snackBar = SnackBar(
            content: Text('Log In Succesfully!'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          checkValid = false;
          const snackBar = SnackBar(
            content:
                Text('Something wrong, check your username/password again'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    } else {
      const snackBar = SnackBar(
        content: Text('Oops, something went wrong!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void _showPassword() {
    setState(() {
      passwordHidden = !passwordHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 60.0),
                child: const Image(
                  image: AssetImage('assets/icons/logo.png'),
                ),
              ),
              TextField(
                controller: _username,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your username',
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              TextField(
                controller: _password,
                obscureText: passwordHidden,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Masukkan PIN Anda",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _showPassword();
                    },
                    icon: (passwordHidden)
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                child: ElevatedButton(
                    onPressed: () => _login(), child: const Text("Login")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
