import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tif_assignment/constants.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    return Container(
      padding: const EdgeInsets.all(10.0),
      height: isTablet ? 70 : 58,
      width: isTablet ? 480 : 270,
      decoration: BoxDecoration(
        color: primaryBlue,
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(111, 126, 201, 0.25),
            offset: Offset(0, 10),
            blurRadius: 35,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
          ),
          Expanded(
            flex: 1,
            child: Text(
              'BOOK NOW',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: isTablet ? 16 : 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: SvgPicture.asset('assets/icons/arrow.svg'),
            ),
          ),
        ],
      ),
    );
  }
}
