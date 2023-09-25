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
//   double barHeight = 0.0;

//   // Define an external mutable variable (e.g., receivedProgress) here
//   // Example:
//   double receivedProgress = 20.0;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Container(
//           width: 20.0,
//           height: 200.0,
//           color: Colors.blue,
//           child: Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               width: 20.0,
//               height: 50.0, //Aqui muda
//               color: Colors.red,
//             ),
//           ),
//         ),
//         SizedBox(height: 20.0),
//         Text(
//           'Progress: ${(barHeight / 200 * 100).toStringAsFixed(1)}%',
//           style: TextStyle(fontSize: 18.0),
//         ),
//       ],
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
//   // Define an external mutable variable (e.g., receivedProgress) here
//   // Example:
//   // double receivedProgress = 0.0;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 250.0, // Adjust as needed
//       height: 250.0, // Adjust as needed
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Image.asset(
//             'assets/icons/nobackground.png', // Replace with your image path
//             width: 250.0, // Adjust as needed
//             height: 250.0, // Adjust as needed
//             fit: BoxFit.cover,
//           ),
//           Align(
//             alignment: Alignment.center,
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
//     double receivedProgress = 1.0; //AQUI VEM O BLUETOOTH READ 1.0 O MAXIMO

//     final double progress = receivedProgress;

//     return CustomPaint(
//       painter: SemiCircleProgressBarPainter(progress),
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
//       ..color = Colors.blue
//       ..strokeCap = StrokeCap.round
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 10.0;

//     final double radius = size.width / 2;
//     final double startAngle = -pi; // 180 degrees
//     final double sweepAngle = pi * progress;

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
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Vertical Bar Timer'),
        ),
        body: Row(
          children: [
            VerticalBarTimer(),
            SemiCircleProgressBarWithImageBackground(),
          ],
        ),
      ),
    );
  }
}

class VerticalBarTimer extends StatefulWidget {
  @override
  _VerticalBarTimerState createState() => _VerticalBarTimerState();
}

class _VerticalBarTimerState extends State<VerticalBarTimer> {
  // Define an external mutable variable (e.g., receivedProgress) here
  // Example:
  double receivedProgress = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        StreamBuilder<double>(
          stream: Stream.periodic(Duration(milliseconds: 500))
              .map((_) => 40 + receivedProgress), // AQUI LE O BLUETOOTH
          initialData: receivedProgress,
          builder: (context, snapshot) {
            final double barHeight = snapshot.data ?? 0.0;
            var cor = Colors.white;
            if (barHeight > 70 || barHeight < 30) {
              cor = const Color.fromARGB(255, 173, 25, 14);
            } else {
              cor = Colors.green;
            }
            ;
            return Container(
              width: 20.0,
              height: 200.0,
              color: Colors.blue,
              child: Align(
                alignment: Alignment.topCenter, // Change alignment to topCenter
                child: Container(
                  width: 20.0,
                  height: barHeight /
                      100 *
                      200.0, // Calculate the height based on receivedProgress
                  color: cor,
                ),
              ),
            );
          },
        ),
        SizedBox(height: 20.0),
        Text(
          'Progress: ${(receivedProgress).toStringAsFixed(1)}%',
          style: TextStyle(fontSize: 18.0),
        ),
      ],
    );
  }
}

class SemiCircleProgressBarWithImageBackground extends StatefulWidget {
  @override
  _SemiCircleProgressBarWithImageBackgroundState createState() =>
      _SemiCircleProgressBarWithImageBackgroundState();
}

class _SemiCircleProgressBarWithImageBackgroundState
    extends State<SemiCircleProgressBarWithImageBackground> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0, // Adjust as needed
      height: 177.0, // Adjust as needed
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Move the image upwards by changing its alignment
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/icons/250.png', // Replace with your image path
              width: 250.0, // Adjust as needed
              height: 177.0, // Adjust as needed
              fit: BoxFit.cover,
            ),
          ),
          // Place the progress bar inside the image
          Positioned(
            top:
                20, // Adjust this value to control the position of the progress bar
            child: SemiCircleProgressBar(),
          ),
        ],
      ),
    );
  }
}

class SemiCircleProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Define an external mutable variable (e.g., receivedProgress) here
    // Example:
    double receivedProgress = 80.0;

    return CustomPaint(
      painter: SemiCircleProgressBarPainter(receivedProgress),
      size: Size(150.0, 150.0), // Adjust the size as needed
    );
  }
}

class SemiCircleProgressBarPainter extends CustomPainter {
  final double progress;

  SemiCircleProgressBarPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;

    final double radius = size.width / 2;
    final double startAngle = -pi; // 180 degrees
    final double sweepAngle = pi * (progress / 100);

    // Add a conditional statement to change the color to red if progress is higher than 70
    if (progress > 70) {
      paint.color = const Color.fromARGB(255, 173, 25, 14);
    } else if (progress > 40) {
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
