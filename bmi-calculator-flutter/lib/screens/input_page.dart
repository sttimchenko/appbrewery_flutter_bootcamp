import 'package:bmi_calculator/calculator_brain.dart';
import 'package:bmi_calculator/components/amount_picker.dart';
import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/components/icon_content.dart';
import 'package:bmi_calculator/screens/results_page.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Gender { male, female }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender;
  var height = 180;
  var weight = 60;
  var age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    color: selectedGender == Gender.male
                        ? kActiveCardColor
                        : kInactiveCardColor,
                    onTap: () {
                      setState(() {
                        selectedGender = selectedGender == Gender.male
                            ? null
                            : Gender.male;
                      });
                    },
                    child: IconContent(
                        icon: FontAwesomeIcons.mars,
                        label: 'MALE'
                    )
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    color: selectedGender == Gender.female
                      ? kActiveCardColor
                      : kInactiveCardColor,
                    onTap: () {
                      setState(() {
                        selectedGender = selectedGender == Gender.female
                            ? null
                            : Gender.female;
                      });
                    },
                    child: IconContent(
                          icon: FontAwesomeIcons.venus,
                          label: 'FEMALE'
                      ),
                    ),
                )
              ],
            ),
          ),
          Expanded(
              child: ReusableCard(
                color: kActiveCardColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'HEIGHT',
                      style: kLabelTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          height.toString(),
                          style: kDisplayNumberTextStyle
                        ),
                        Text(
                          'cm',
                          style: kLabelTextStyle,
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        inactiveTrackColor: Color(0xFF8D8E98),
                        activeTrackColor: Colors.white,
                        thumbColor: Color(0xFFEB1555),
                        overlayColor: Color(0x1FEB1555),
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 16.0
                        ),
                        overlayShape: RoundSliderOverlayShape(
                            overlayRadius: 32.0
                        )
                      ),
                      child: Slider(
                        value: height.toDouble(),
                        min: 120.0,
                        max: 240.0,
                        onChanged: (newValue) {
                          setState(() {
                            height = newValue.round();
                          });
                        },
                      ),
                    )
                  ],
                ),
              )
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: AmountPicker(
                      categoryName: 'WEIGHT',
                      value: weight.toString(),
                      onDecrease: () {
                        setState(() {
                          weight--;
                        });
                      },
                      onIncrease: () {
                        setState(() {
                          weight++;
                        });
                      },
                    )
                ),
                Expanded(
                    child: AmountPicker(
                      categoryName: 'AGE',
                      value: age.toString(),
                      onDecrease: () {
                        setState(() {
                          age--;
                        });
                      },
                      onIncrease: () {
                        setState(() {
                          age++;
                        });
                      },
                    )
                )
              ],
            ),
          ),
          BottomButton(
            title: 'CALCULATE',
            onTap: () {
              final calc = CalculatorBrain(height: height, weight: weight);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResultsPage(
                        bmiResult: calc.calculateBMI(),
                        resultText: calc.getResult().toUpperCase(),
                        resultInterpretation: calc.getInterpretation(),
                      )
                  )
              );
            },
          )
        ],
      ),
    );
  }
}
