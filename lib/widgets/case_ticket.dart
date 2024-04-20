import 'package:charity/size.dart';
import 'package:flutter/material.dart';

import '../constant/my_colors.dart';

class CaseTicket extends StatelessWidget {
  final String name , id , description ;
  final Function() onTap;
  const CaseTicket({super.key, required this.name, required this.id, required this.description, required this.onTap});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: sizeConfig.screenHeight! * 0.13,
        margin: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(8, 8),
              blurRadius: 20.0,
            ),
          ],
          borderRadius: BorderRadius.circular(15.0),

        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          children:
          [
            Container(
              decoration: BoxDecoration(
                color: MyColors.myBlue,
              ),
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
                height: sizeConfig.screenHeight! * 0.13,
              ),
            ),
            const SizedBox(width: 5.0,),
            Expanded(
              child: Column(
                children: [
                  Text(
                    name ,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textDirection: TextDirection.rtl,
                  ),
                  Text(
                    id,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15.0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textDirection: TextDirection.rtl,
                  ),
                  Text(
                    description ,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15.0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5.0,),
          ],
        ),
      ),
    );
  }
}
