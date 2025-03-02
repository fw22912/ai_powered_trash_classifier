import 'package:flutter/material.dart';
import 'screens/scan_page.dart';
import 'overview_page.dart';
import 'funfact_page.dart';
import 'widget/settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void setLocale(BuildContext context, Locale newLocale) {
    // Implement setLocale
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'RinsHandwriting',
        colorScheme: ColorScheme.light(
          primary: Color(0xFF262626), // Black
          onPrimary: Colors.white,
          // background: Color(0xFFFEFFFB), // White
          // onBackground: Color(0xFF262626), // Black text on white background
      ),
        scaffoldBackgroundColor: Color(0xFFFEFFFB)
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/scan_page': (context) => const ScanPage(),
        '/overview_page': (context) => OverviewPage(userId: 'test_user'),
        '/funfact_page': (context) => Funfact(),
      },
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Big Tree (Left)
          Positioned(
            left: 0,
            top: 90,
            child: Image.asset(
              'assets/background/big_tree.png',
              height: 200,
              fit: BoxFit.contain,
            ),
          ),
          // Small Tree (Right)
          Positioned(
            right: 10,
            top: 90,
            child: Image.asset(
              'assets/background/small_tree.png',
              height: 350,
              fit: BoxFit.contain,
            ),
          ),

          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset(
              'assets/character/panda.png',
              height: 200,
              fit: BoxFit.contain,
            ),
          ),

           // Settings icon replaced with specific image
          Positioned(
            left: 20,
            bottom:20,
            child: IconButton(
              icon: Image.asset('assets/icon/settings-icon.png', height: 70),
              onPressed: () => _navigateToSettings(context),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Greeting text with profile image
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Hello, User",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/icon/profile-icon.png'),
                        radius: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 150),

                  // Trash Classifier Text
                  Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/widgets/black-btn.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const SizedBox(
                      child: Center(
                      child: Text(
                        "TRASH CLASSIFIER",
                        style: TextStyle(
                          fontFamily: 'Simpsonfont',
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      ),
                    ),
                  ),
                  _buildButton("Scan my waste", context, '/scan_page'),
                  _buildButton("Waste Overview", context, '/overview_page'),
                  _buildButton("Tips/Fun facts", context, '/funfact_page'),
                  const Spacer(),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

  void _navigateToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsPage()),
    );
  }

Widget _buildButton(String text, BuildContext context, [String? route]) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0), // Increased vertical padding
    child: SizedBox(
      width: double.infinity,
      height: 70,
      child: InkWell(
        onTap: () {
          if (route != null && route.isNotEmpty) {
            Navigator.pushNamed(context, route);
          }
        },
        child: Stack(
          children: [
            // Use your image as the button background
            Positioned.fill(
              child: Image.asset(
                'assets/widgets/outlined-btn.png', // Ensure this file exists
                fit: BoxFit.cover,
              ),
            ),
            // Center the text with increased padding
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0), // Increased padding
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold, // Optional: Add bold text
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


