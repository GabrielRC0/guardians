import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/back1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.80),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/goglogo.png",
                    width: 250,
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/choose');
                    },
                    child: Text('Welcome Back Guardian!'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle: TextStyle(fontSize: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Text(
              '"Guardians of the Galaxy" is a registered trademark owned by Marvel Characters, Inc., which is a subsidiary of Marvel Entertainment, LLC, which in turn is a subsidiary of The Walt Disney Company. This software uses the ip only in scholar uses',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/images/zune.png",
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
