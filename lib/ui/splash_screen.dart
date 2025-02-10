import 'dart:async';

import 'package:discover/ui/main_page.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with your asset video
    _controller = VideoPlayerController.asset('assets/videos/splashVideo.mp4')
      ..initialize().then((_) {
        // Optionally set looping or any other configurations
        
        _controller.setLooping(false);
        // Start the video playback
        _controller.play();
        setState(() {}); // Refresh to show the video once ready
      });

    // After a delay, navigate to your main app screen
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const MainPage()), // Replace HomePage() with your actual home widget
      );
    });
  }

  @override
  void dispose() {
    // Dispose of the video controller to free resources
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  _controller.value.isInitialized
            ? Center(
              child: SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
                ),
              ),
              ),
            )
          : Container(color: Colors.black);
  }
}

// Stack(
//               fit: StackFit.expand,
//               children: [
//                 AspectRatio(
//                   aspectRatio: _controller.value.aspectRatio,
//                   child: VideoPlayer(_controller),
//                 ),
//               ],
//             )