import 'package:flutter/material.dart';
import 'package:random_number_geneartor/component/number_row.dart';
import 'package:random_number_geneartor/constant/color.dart';

class SettingsScreen extends StatefulWidget {
  final int maxNumber;
  const SettingsScreen({Key? key, required this.maxNumber}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double maxNumber = 1000;

  @override
  void initState() {
    super.initState();
    maxNumber = widget.maxNumber.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Body(
                maxNumber: maxNumber,
              ),
              _Footer(
                onSliderChanged: onSliderChanged,
                onButtonPressed: onButtonPressed,
                maxNumber: maxNumber,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSliderChanged(double val) {
    setState(() {
      maxNumber = val;
    });
  }

  void onButtonPressed() {
    Navigator.of(context).pop(maxNumber.toInt());
  }
}

class _Body extends StatelessWidget {
  final double maxNumber;
  const _Body({required this.maxNumber, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberRow(
        number: maxNumber.toInt(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final double maxNumber;
  final ValueChanged<double>? onSliderChanged;
  final VoidCallback onButtonPressed;

  const _Footer(
      {required this.onSliderChanged,
      required this.onButtonPressed,
      required this.maxNumber,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Slider(
          value: maxNumber,
          min: 1000,
          max: 100000,
          onChanged: onSliderChanged,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: redColor),
          onPressed: onButtonPressed,
          child: Text('저장'),
        ),
      ],
    );
  }
}
