import 'package:bmi_calculator/components/round_icon_button.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AmountPicker extends StatelessWidget {
  final String categoryName;
  final String value;
  final Function onDecrease;
  final Function onIncrease;

  AmountPicker({
    @required this.categoryName,
    @required this.value,
    @required this.onDecrease,
    @required this.onIncrease
  });

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      color: kActiveCardColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            categoryName,
            style: kLabelTextStyle,
          ),
          Text(
              value,
              style: kDisplayNumberTextStyle
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundIconButton(
                  icon: FontAwesomeIcons.minus,
                  onPressed: () {
                    onDecrease();
                  },
                ),
                SizedBox(
                  width: 10.0,
                ),
                RoundIconButton(
                  icon: FontAwesomeIcons.plus,
                  onPressed: () {
                    onIncrease();
                  },
                ),
              ]
          )
        ],
      ),
    );
  }
}
