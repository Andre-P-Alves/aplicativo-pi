import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilledBar extends StatefulWidget {
  final double initialValue;
  final Color fillColor;
  final Color backgroundColor;
  final double width;
  final double height;

  FilledBar({
    required this.initialValue,
    this.fillColor = Colors.blue,
    this.backgroundColor = Colors.grey,
    this.width = 200.0,
    this.height = 20.0,
  });

  @override
  _FilledBarState createState() => _FilledBarState();
}

class _FilledBarState extends State<FilledBar> {
  late double value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue.clamp(0.0, 1.0);
  }

  void updateValue(double newValue) {
    setState(() {
      value = newValue.clamp(0.0, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: value,
        child: Container(
          decoration: BoxDecoration(
            color: widget.fillColor,
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(children: [
        Container(
          margin: const EdgeInsets.only(top: 40, left: 200, right: 200),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.11),
                blurRadius: 400,
                spreadRadius: 0.0)
          ]),
          child: TextField(
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.green,
                contentPadding: EdgeInsets.all(15),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none)),
          ),
        )
      ]),
    );
  }
}

AppBar appBar() {
  return AppBar(
    title: const Text(
      'teste',
      style: TextStyle(
        color: Colors.amber,
        fontSize: 18,
      ),
    ),
    backgroundColor: Colors.white,
    centerTitle: true,
    elevation: 0.0,
    leading: Container(
      margin: const EdgeInsets.all(10),
      alignment: Alignment.center,
      width: 30,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SvgPicture.asset(
        'assets/icons/left-arrow-svgrepo-com.svg',
        height: 15,
        width: 15,
      ),
    ),
    actions: [
      GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          width: 30, // Mesmo tamanho do botão
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            'assets/icons/left-arrow-svgrepo-com.svg',
            height: 15,
            width: 15,
          ),
        ),
      ),
    ],
  );
}
