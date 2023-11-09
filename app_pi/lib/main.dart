// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double receivedProgress = 0.0;
  double receivedValue2 = 0.0;

  @override
  void initState() {
    super.initState();
    // Start the periodic timer to fetch data every x milliseconds
    startTimer();
  }

  void startTimer() {
    const Duration interval = Duration(milliseconds: 10);
    Timer.periodic(interval, (timer) {
      _getData(); // Fetch data from ESP32
    });
  }

  final http.Client client = http.Client();

  Future<void> _getData() async {
    try {
      Uri url = Uri.parse('http://192.168.4.1');
      final response = await client.get(url);
      if (response.statusCode == 200) {
        List<String> values = response.body.split(';');
        if (values.length >= 2) {
          double value1 = double.tryParse(values[0]) ?? 0.0;
          double value2 = double.tryParse(values[1]) ?? 0.0;
          setState(() {
            receivedProgress = value1;
          });
          setState(() {
            receivedValue2 = value2;
          });
        }
      }
    } catch (e) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resusci Baby'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Frequência cardíaca:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              receivedValue2.toString(),
              style: const TextStyle(fontSize: 16),
            ),
            SemiCircleProgressBarWithImageBackground(
              receivedValue2: receivedValue2,
            ),
            VerticalBarTimer(
              receivedProgress: receivedProgress,
              receivedValue2: receivedValue2,
            ),
          ],
        ),
      ),
    );
  }
}

class VerticalBarTimer extends StatelessWidget {
  final double receivedProgress;
  final double receivedValue2; // Add this variable for the second value
  final double maxDist = 6.0;
  final double minDist = 3.3;

  const VerticalBarTimer(
      {super.key,
      required this.receivedProgress,
      required this.receivedValue2});

  @override
  Widget build(BuildContext context) {
    var cor = Colors.white;
    if (receivedProgress > 70 || receivedProgress < 30) {
      cor = const Color.fromARGB(255, 173, 25, 14);
    } else {
      cor = Colors.green;
    }

    return SizedBox(
      width: 250.0,
      height: 350.0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/icons/retangulo.png',
              width: 250.0,
              height: 350.0,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 40.0,
                  height: 250.0,
                  color: Colors.blue,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 35.0,
                      height: ((receivedProgress + 3.3 - minDist) /
                              (maxDist - minDist)) *
                          250, // Bar height
                      color: cor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SemiCircleProgressBarWithImageBackground extends StatefulWidget {
  final double receivedValue2;

  const SemiCircleProgressBarWithImageBackground(
      {super.key, required this.receivedValue2});

  @override
  _SemiCircleProgressBarWithImageBackgroundState createState() =>
      _SemiCircleProgressBarWithImageBackgroundState();
}

class _SemiCircleProgressBarWithImageBackgroundState
    extends State<SemiCircleProgressBarWithImageBackground> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.0, // Adjust as needed
      height: 177.0, // Adjust as needed
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Move the image upwards by changing its alignment
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/icons/250-removebg-preview.png', // Replace with your image path
              width: 250.0, // Adjust as needed
              height: 177.0, // Adjust as needed
              fit: BoxFit.cover,
            ),
          ),
          // Place the progress bar inside the image
          Positioned(
            top:
                20, // Adjust this value to control the position of the progress bar
            child: SemiCircleProgressBar(receivedValue2: widget.receivedValue2),
          ),
        ],
      ),
    );
  }
}

class SemiCircleProgressBar extends StatelessWidget {
  final double receivedValue2;

  const SemiCircleProgressBar({super.key, required this.receivedValue2});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SemiCircleProgressBarPainter(receivedValue2),
      size: const Size(150.0, 150.0), // Adjust the size as needed
    );
  }
}

class SemiCircleProgressBarPainter extends CustomPainter {
  final double value2;
  final int threshold = 200;

  SemiCircleProgressBarPainter(this.value2);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;

    final double radius = size.width / 2;
    const double startAngle = -pi;
    final double sweepAngle = pi * (value2 / threshold);

    // Add a conditional statement to change the color to red if progress is higher than chosen
    if (value2 > 130) {
      paint.color = const Color.fromARGB(255, 173, 25, 14);
    } else if (value2 > 90) {
      paint.color = Colors.green;
    } else {
      paint.color = const Color.fromARGB(255, 145, 206, 255);
    }

    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
