import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:shopcart/constants/global_variables.dart';
import 'package:shopcart/providers/user_provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UserProvider>(context).user;
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
        // gradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        //   colors: [
        //     Color.fromARGB(255, 21, 211, 72),
        //     Color.fromARGB(255, 151, 244, 159),
        //   ],
        //   stops: [0.5, 1.0],
        // ),
      ),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(
                Icons.location_on_outlined,
                size: 20,
                color: Colors.white,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child:
                    // Marquee(text: "Deliver to ${users.name} : ${users.address}")

                    Text(
                  "Deliver to  : ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),

          // Expanded(
          //   child: Marquee(
          //     accelerationDuration: const Duration(seconds: 1),
          //     accelerationCurve: Curves.linear,
          //     decelerationDuration: const Duration(milliseconds: 500),
          //     decelerationCurve: Curves.easeOut,
          //     blankSpace: 10.0,
          //     pauseAfterRound: const Duration(seconds: 5),
          //     startPadding: 10.0,
          //     text: "",
          //     style: const TextStyle(color: Colors.white),
          //   ),
          // ),
          const Padding(
            padding: EdgeInsets.only(
              left: 2,
              top: 2,
              right: 5,
            ),
            child: Icon(
              Icons.arrow_drop_down_outlined,
              size: 25,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
