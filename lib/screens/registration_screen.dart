import 'package:fashion_flow/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fashion_flow/constants/colors.dart';
import 'package:fashion_flow/constants/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SvgPicture.asset(
                'assets/mainLogo.svg',
                width: width * 0.65,
              ),
              const Text(
                Strings.appTitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Kayıt',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              const SizedBox(height: 5),
              const Text('   E-posta adresinizle kaydolun    '),
              const SizedBox(height: 5),
              EmailPasswordBox(buttonText: 'Kaydol', buttonFunction: () {}),
              const SizedBox(height: 10),
              const SizedBox(height: 5),
              const Text(
                'veya şunlarla giriş yap',
                textAlign: TextAlign.center,
                style: TextStyle(color: ffColors.Gray, fontSize: 13),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: InkWell(
                      onTap: () {}, // Image tapped
                      splashColor: Colors.white10, // Splash color over image
                      child: Ink.image(
                        fit: BoxFit.cover, // Fixes border issues
                        width: 40,
                        height: 40,
                        image: const AssetImage('assets/icons/ic_google.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: InkWell(
                      onTap: () {}, // Image tapped
                      splashColor: Colors.white10, // Splash color over image
                      child: Ink.image(
                        fit: BoxFit.cover, // Fixes border issues
                        width: 40,
                        height: 40,
                        image: const AssetImage('assets/icons/ic_facebook.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: InkWell(
                      onTap: () {}, // Image tapped
                      splashColor: Colors.white10, // Splash color over image
                      child: Ink.image(
                        fit: BoxFit.cover, // Fixes border issues
                        width: 40,
                        height: 40,
                        image:
                            const AssetImage('assets/icons/ic_instagram.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: InkWell(
                      onTap: () {}, // Image tapped
                      splashColor: Colors.white10, // Splash color over image
                      child: Ink.image(
                        fit: BoxFit.cover, // Fixes border issues
                        width: 40,
                        height: 40,
                        image: const AssetImage('assets/icons/ic_twitter.png'),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class EmailPasswordBox extends StatefulWidget {
  EmailPasswordBox(
      {super.key, required this.buttonText, required this.buttonFunction});

  String buttonText;
  VoidCallback buttonFunction;

  @override
  State<EmailPasswordBox> createState() => _EmailPasswordBoxState();
}

class _EmailPasswordBoxState extends State<EmailPasswordBox> {
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            labelText: 'E-mail',
            suffixIcon: const Icon(Icons.email_outlined),
          ),
          onChanged: (value) {
            email = value;
            print(value);
            print(email);
          },
        ),
        const SizedBox(height: 20),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            labelText: 'Şifre',
            suffixIcon: const Icon(Icons.lock_outlined),
          ),
          onChanged: (value) {
            password = value;
          },
        ),
        TextButton(
          onPressed: () async {
            try {
              final UserCredential newUser = await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: email, password: password);
              print('Kullanıcı oluşturuldu');

              if (newUser != null) {
                Navigator.pushNamed(context, HomeScreen.routeName);
              }
            } catch (e) {
              print('Kullanıcı oluşturma başarısız: $e');
            }
          },
          child: Container(
            height: 70,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: ffColors.Pink,
            ),
            child: Center(
              child: Text(
                widget.buttonText,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
