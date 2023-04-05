import 'package:flutter/material.dart';
import 'package:shopcart/features/account/widgets/account_buttons.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: "Yours Orders",
              onTap: () {},
            ),
            AccountButton(
              text: "New Arrivals",
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButton(
              text: "Logout",
              onTap: () {},
            ),
            AccountButton(
              text: "Your Whish List",
              onTap: () {},
            ),
          ],
        )
      ],
    );
  }
}
