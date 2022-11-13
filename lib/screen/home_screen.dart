import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_number_geneartor/component/number_row.dart';
import 'package:random_number_geneartor/constant/color.dart';
import 'package:random_number_geneartor/screen/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> randomNumbers = [987, 654, 321];
  int maxNumber = 1000;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              _Header(
                onPressed: onSettingsPop,
              ),
              _Body(randomNumbers: randomNumbers),
              _Footer(
                onPressed: onRandomNumberGenerate,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onRandomNumberGenerate() {
    final rand = Random();
    final Set<int> newNumbers = {};
    while (newNumbers.length != 3) {
      final number = rand.nextInt(maxNumber);
      newNumbers.add(number);
    }
    setState(() {
      randomNumbers = newNumbers.toList();
    });
  }

  void onSettingsPop() async {
    final result = await Navigator.of(context)
        .push<int>(MaterialPageRoute(builder: (context) {
      return SettingsScreen(
        maxNumber: maxNumber,
      );
    }));
    print(result);
    if (result != null) {
      setState(() {
        maxNumber = result;
      });
    }
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
    required this.randomNumbers,
  }) : super(key: key);

  final List<int> randomNumbers;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NumbersWidget(
              number: randomNumbers[0],
            ),
            NumbersWidget(
              number: randomNumbers[1],
            ),
            NumbersWidget(
              number: randomNumbers[2],
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onPressed;
  const _Header({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '랜덤숫자생성기',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30,
          ),
        ),
        IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.settings,
            color: redColor,
          ),
        ),
      ],
    );
  }
}

class NumbersWidget extends StatelessWidget {
  final int number;
  final bool isLast;
  const NumbersWidget({
    Key? key,
    required this.number,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast == true ? 0 : 8.0),
      child: NumberRow(
        number: number,
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;
  const _Footer({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: redColor,
          textStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          '생성하기!',
        ),
      ),
    );
  }
}
