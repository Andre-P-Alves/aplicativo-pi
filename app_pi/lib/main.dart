// import 'package:flutter/material.dart';
// import 'dart:math';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Vertical Bar Timer'),
//         ),
//         body: Row(
//           children: [
//             VerticalBarTimer(),
//             SemiCircleProgressBarWithImageBackground(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class VerticalBarTimer extends StatefulWidget {
//   @override
//   _VerticalBarTimerState createState() => _VerticalBarTimerState();
// }

// class _VerticalBarTimerState extends State<VerticalBarTimer> {
//   // Define an external mutable variable (e.g., receivedProgress) here
//   // Example:
//   double receivedProgress = 0.0;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 250.0, // Adjust as needed
//       height: 350.0,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Align(
//             alignment: Alignment.topCenter,
//             child: Image.asset(
//               'assets/icons/retangulo.png', // Replace with your image path
//               width: 250.0, // Adjust as needed
//               height: 350.0, // Adjust as needed
//               fit: BoxFit.cover,
//             ),
//           ),
//           Positioned(
//             top: 50,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 StreamBuilder<double>(
//                   stream: Stream.periodic(Duration(milliseconds: 500))
//                       .map((_) => 50 + receivedProgress), // AQUI LE O BLUETOOTH
//                   initialData: receivedProgress,
//                   builder: (context, snapshot) {
//                     final double barHeight = snapshot.data ?? 0.0;
//                     var cor = Colors.white;
//                     if (barHeight > 70 || barHeight < 30) {
//                       cor = const Color.fromARGB(255, 173, 25, 14);
//                     } else {
//                       cor = Colors.green;
//                     }
//                     ;
//                     return Container(
//                       width: 40.0,
//                       height: 200.0,
//                       color: Colors.blue,
//                       child: Align(
//                         alignment: Alignment
//                             .topCenter, // Change alignment to topCenter
//                         child: Container(
//                           width: 35.0,
//                           height: barHeight /
//                               100 *
//                               200.0, // Calculate the height based on receivedProgress
//                           color: cor,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 SizedBox(height: 20.0),
//                 Text(
//                   'Ritmo: ${(receivedProgress).toStringAsFixed(1)}',
//                   style: TextStyle(fontSize: 18.0),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SemiCircleProgressBarWithImageBackground extends StatefulWidget {
//   @override
//   _SemiCircleProgressBarWithImageBackgroundState createState() =>
//       _SemiCircleProgressBarWithImageBackgroundState();
// }

// class _SemiCircleProgressBarWithImageBackgroundState
//     extends State<SemiCircleProgressBarWithImageBackground> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 250.0, // Adjust as needed
//       height: 177.0, // Adjust as needed
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           // Move the image upwards by changing its alignment
//           Align(
//             alignment: Alignment.topCenter,
//             child: Image.asset(
//               'assets/icons/250.png', // Replace with your image path
//               width: 250.0, // Adjust as needed
//               height: 177.0, // Adjust as needed
//               fit: BoxFit.cover,
//             ),
//           ),
//           // Place the progress bar inside the image
//           Positioned(
//             top:
//                 20, // Adjust this value to control the position of the progress bar
//             child: SemiCircleProgressBar(),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SemiCircleProgressBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Define an external mutable variable (e.g., receivedProgress) here
//     // Example:
//     double receivedProgress = 100.0;

//     return CustomPaint(
//       painter: SemiCircleProgressBarPainter(receivedProgress),
//       size: Size(150.0, 150.0), // Adjust the size as needed
//     );
//   }
// }

// class SemiCircleProgressBarPainter extends CustomPainter {
//   final double progress;

//   SemiCircleProgressBarPainter(this.progress);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..strokeCap = StrokeCap.round
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 10.0;

//     final double radius = size.width / 2;
//     final double startAngle = -pi; // 180 degrees
//     final double sweepAngle = pi * (progress / 100);

//     // Add a conditional statement to change the color to red if progress is higher than 70
//     if (progress > 70) {
//       paint.color = const Color.fromARGB(255, 173, 25, 14);
//     } else if (progress > 40) {
//       paint.color = Colors.green;
//     } else {
//       paint.color = const Color.fromARGB(255, 145, 206, 255);
//     }

//     canvas.drawArc(
//       Rect.fromCircle(center: Offset(radius, radius), radius: radius),
//       startAngle,
//       sweepAngle,
//       false,
//       paint,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESP32 Communication',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String receivedData = 'No data received';

  Future<void> _getData() async {
    try {
      Uri url = Uri.parse(
          'http://192.168.4.1'); // ESP32 IP address when acting as an access point

      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          receivedData = response.body;
        });
      } else {
        setState(() {
          receivedData =
              'Failed to fetch data. Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        receivedData = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ESP32 Communication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Received Data:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              receivedData,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _getData();
              },
              child: Text('Fetch Data'),
            ),
          ],
        ),
      ),
    );
  }
}
