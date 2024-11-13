import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:smm/calendar_info_page.dart';
import 'package:smm/date/accounts.dart';
import 'package:smm/date/boxes.dart';
import 'package:smm/info_page.dart';
import 'package:smm/list_content_page.dart';
import 'package:smm/statistics_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() {
    return _MenuPageState();
  }
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8C59DE),
      body: SafeArea(
          child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const InfoPage(),
                    ),
                  );
                },
                child: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 40.h,
                ),
              ),
            ),
          ),
          Container(
            width: 368.w,
            height: 286.h,
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/menu.png"))),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Wrap(
              spacing: 20.w,
              runSpacing: 20.w,
              children: [
                Container(
                  width: 161.w,
                  height: 151.sp,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.all(Radius.circular(28.r)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Hive.box<Accounts>(HiveBoxes.accounts)
                            .values
                            .length
                            .toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 65.74.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Number of accounts in operation",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const CalendarInfoPage(),
                      ),
                    );
                  },
                  child: Container(
                    width: 161.w,
                    height: 151.sp,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.all(Radius.circular(28.r)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 70.w,
                          height: 70.h,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/planning-calendar.png"))),
                        ),
                        Text(
                          "Calendar and\npublication planning",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const ListContentPage(),
                      ),
                    );
                  },
                  child: Container(
                    width: 161.w,
                    height: 151.sp,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.all(Radius.circular(28.r)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 90.w,
                          height: 90.h,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/account-management.png"))),
                        ),
                        Text(
                          "Account\nManagement",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const StatisticsPage(),
                      ),
                    );
                  },
                  child: Container(
                    width: 161.w,
                    height: 151.sp,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.all(Radius.circular(28.r)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 110.w,
                          height: 81.h,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/ac_state.png"))),
                        ),
                        Text(
                          "Account statistics",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
