import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fashion_flow/constants/colors.dart';
import 'package:fashion_flow/constants/strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  'Giriş',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              const SizedBox(height: 5),
              const Text('   Lütfen hesabınıza giriş yapın    '),
              const SizedBox(height: 5),
              EmailPasswordBox(buttonText: 'Giriş', buttonFunction: () {}),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Şifremi Unuttum',
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Misafir olarak giriş yap',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ffColors.Pink,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Hesabınız yok mu?'),
                  TextButton(onPressed: () {}, child: Text('Şimdi Kaydolun!'))
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}

class EmailPasswordBox extends StatelessWidget {
  EmailPasswordBox({required this.buttonText, required this.buttonFunction});

  String buttonText;
  VoidCallback buttonFunction;
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
          onPressed: () {},
          child: Container(
            height: 70,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: ffColors.Pink,
            ),
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
