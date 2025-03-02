import 'package:ai_powered_trash_classifier/screens/scan_page.dart';
import 'package:flutter/material.dart';
import '../widget/drawer_menu.dart'; // Import the drawer menu
import '../widget/settings_page.dart'; // Import the settings page

class LearnMorePage extends StatelessWidget {
  final String scannedItem; // Add a parameter for the scanned item

  const LearnMorePage({super.key, required this.scannedItem}); // Update constructor

  // Navigation functions
  void _navigateToDrawer(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DrawerMenu()),
    );
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // ✅ Scrollable Content
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    const Text(
                      "Your waste belongs to...",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Image.asset(
                        'assets/bins/green_box.png', // Ensure image exists
                        height: 150,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "BROWN BIN",
                      style: TextStyle(fontFamily: 'Simpsonfont', fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "AI recycling advises for...",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      scannedItem.isNotEmpty ? scannedItem : "UNKNOWN ITEM",
                      style: const TextStyle(
                        fontFamily: 'Simpsonfont',
                        fontSize: 20,
                      ),
                    ),
                    const Text(
                      "- Incorrectly disposed of.\n- Place in accepted compost or areas.\n- Some waste may need special handling.",
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "AI Powered",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Tips and Tricks",
                      style: TextStyle(
                          fontFamily: 'Simpsonfont',
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "- Proper waste disposal techniques.\n- Alternatives for composting.\n- How to minimize waste impact.",
                    ),
                    const SizedBox(height: 30),

                    // Understood Button with Image Background
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/widgets/black-btn.png',
                            height: 60,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/overview_page');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                            ),
                            child: const Text(
                              "Understood!",
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Wrong Object or Material Button with Image Background
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/widgets/outlined-btn.png', // Ensure image exists
                            height: 60,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ScanPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                            ),
                            child: const Text(
                              "Wrong object or material?",
                              style: TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 100), // Ensure extra spacing at the bottom
                  ],
                ),
              ),
            ),

            // Top Right Menu Icon
            Positioned(
              top: 16,
              right: 16,
              child: IconButton(
                icon: Image.asset(
                  'assets/widgets/menu-icon.png',
                  width: 75,
                ),
                onPressed: () => _navigateToDrawer(context),
              ),
            ),

            // Settings Button (Bottom Left)
            Positioned(
              bottom: 16,
              left: 16,
              child: IconButton(
                icon: Image.asset(
                  'assets/icon/settings-icon.png',
                  height: 75,
                ),
                onPressed: () => _navigateToSettings(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
