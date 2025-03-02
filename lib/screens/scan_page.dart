import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'learn_more_page.dart';
import '../widget/drawer_menu.dart';
import '../widget/settings_page.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  CameraController? _controller;
  List<CameraDescription>? cameras;
  bool _showLearnMore = false; // Initially hidden
  String _scanText = "Place your item in front of the camera!"; // Initial instruction text
  String _scannedItem = ""; // Initially empty, appears after scanning

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(cameras![0], ResolutionPreset.medium, enableAudio: false);
    await _controller!.initialize();
    if (!mounted) return;
    setState(() {});
  }

  void _scanItem() {
    // Simulate a scan and update the UI
    setState(() {
      _showLearnMore = true; // Show "Learn More" button
      _scannedItem = "Plastic Bottle"; // Replace with actual detected item
      _scanText = "Your item is:"; // Instruction above scanned item
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Top Right Menu Icon
            Positioned(
              top: 20,
              right: 20,
              child: IconButton(
                icon: Image.asset(
                  'assets/widgets/menu-icon.png',
                  width: 70,
                ),
                onPressed: () => _navigateToDrawer(context),
              ),
            ),

            // Camera Preview Box + Instructions + Scanned Item
            Positioned(
              top: MediaQuery.of(context).size.height * 0.125,
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    // Instruction Text (Changes on scan)
                    Text(
                      _scanText,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20), // Spacing

                    // Camera Frame
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _controller == null || !_controller!.value.isInitialized
                          ? const Center(child: CircularProgressIndicator())
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CameraPreview(_controller!),
                            ),
                    ),

                    const SizedBox(height: 20), // Space between camera and scanned item

                    // Scanned Item Text (Appears only after scanning)
                    if (_scannedItem.isNotEmpty)
                      Text(
                        _scannedItem,
                        style: const TextStyle(
                          fontFamily: 'Simpsonfont',
                          fontSize: 30,
                          
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Scan My Waste Button
            Positioned(
              top: MediaQuery.of(context).size.height * 0.57,
              left: MediaQuery.of(context).size.width * 0.15,
              right: MediaQuery.of(context).size.width * 0.15,
              child: GestureDetector(
                onTap: _scanItem,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/widgets/black-btn.png',
                      height: 50,
                    ),
                    const Text(
                      "Scan My Waste",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Learn More Button (Initially Hidden)
            // if (_showLearnMore)
            //   Positioned(
            //     bottom: 150,
            //     left: MediaQuery.of(context).size.width * 0.3,
            //     right: MediaQuery.of(context).size.width * 0.3,
            //     child: GestureDetector(
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => const LearnMorePage()),
            //         );
            //       },
            //       child: Stack(
            //         alignment: Alignment.center,
            //         children: [
            //           Image.asset(
            //             'assets/widgets/outlined-btn.png',
            //             height: 90,
            //           ),
            //           const Text(
            //             "Learn More",
            //             style: TextStyle(
            //               fontSize: 35,
            //               fontWeight: FontWeight.bold,
            //               color: Colors.black,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),

            // Settings Button (Bottom Left)
            Positioned(
              bottom: 20,
              left: 20,
              child: IconButton(
                icon: Image.asset('assets/icon/settings-icon.png', height: 70),
                onPressed: () {
                  _navigateToSettings(context);
                },
              ),
            ),
            
            if (_showLearnMore)
              Positioned(
                bottom: 70,
                left: MediaQuery.of(context).size.width * 0.3,
                right: MediaQuery.of(context).size.width * 0.3,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LearnMorePage(scannedItem: _scannedItem), // Pass the scanned item
                      ),
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/widgets/outlined-btn.png',
                        height: 100,
                      ),
                      const Text(
                        "Learn More",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

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
