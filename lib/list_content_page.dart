import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smm/add_content_page.dart';
import 'package:smm/date/accounts.dart';
import 'package:smm/date/boxes.dart';

class ListContentPage extends StatefulWidget {
  const ListContentPage({super.key});

  @override
  State<ListContentPage> createState() {
    return _ListContentPageState();
  }
}

class _ListContentPageState extends State<ListContentPage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<Accounts>(HiveBoxes.accounts).listenable(),
        builder: (context, Box<Accounts> box, _) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: SvgPicture.asset(
                              "assets/arrow_back.svg",
                            ),
                          ),
                        ),
                      ),
                    ),
                    for (int i = 0; i < box.values.length; i++)
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Container(
                          width: 327.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.r))),
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                child: Text(
                                  "${box.getAt(i)!.orderType}\n${box.getAt(i)!.customer}\n${box.getAt(i)!.login} ${box.getAt(i)!.password}",
                                  style: TextStyle(fontSize: 18.sp),
                                ),
                              ),
                              Positioned(
                                right: 20.w,
                                top: 18.h,
                                child: Container(
                                  width: 35.h,
                                  height: 35.h,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: MemoryImage(
                                        box.getAt(i)!.imageContent!),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const AddContentPage(),
                            ),
                          );
                        },
                        child: Container(
                          width: 327.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.r)),
                            color: const Color(0xFF803CEF),
                          ),
                          child: Center(
                            child: Text(
                              "Connect account",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.sp),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
