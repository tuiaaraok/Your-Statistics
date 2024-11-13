import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:smm/add_count_page.dart';
import 'package:smm/date/boxes.dart';
import 'package:smm/date/plan.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() {
    return _StatisticsPageState();
  }
}

class _StatisticsPageState extends State<StatisticsPage> {
  final List<TextEditingController> followersController = [];
  final List<TextEditingController> likesController = [];
  final List<TextEditingController> postController = [];
  final List<FocusNode> _nodeText1 = [];
  final List<FocusNode> _nodeText2 = [];
  final List<FocusNode> _nodeText3 = [];
  @override
  void initState() {
    super.initState();
    Box<Plan> planBox = Hive.box<Plan>(HiveBoxes.plan);
    if (planBox.isNotEmpty) {
      for (var action in planBox.values) {
        followersController.add(TextEditingController(text: action.followers));
        likesController.add(TextEditingController(text: action.likes));
        postController.add(TextEditingController(text: action.posts));
        _nodeText1.add(FocusNode());
        _nodeText2.add(FocusNode());
        _nodeText3.add(FocusNode());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<Plan>(HiveBoxes.plan).listenable(),
        builder: (context, Box<Plan> box, _) {
          // Clear existing controllers and focus nodes
          followersController.clear();
          likesController.clear();
          postController.clear();
          _nodeText1.clear();
          _nodeText2.clear();
          _nodeText3.clear();

          // Repopulate the controllers and focus nodes
          if (box.isNotEmpty) {
            for (var action in box.values) {
              followersController
                  .add(TextEditingController(text: action.followers));
              likesController.add(TextEditingController(text: action.likes));
              postController.add(TextEditingController(text: action.posts));
              _nodeText1.add(FocusNode());
              _nodeText2.add(FocusNode());
              _nodeText3.add(FocusNode());
            }
          }
          return Scaffold(
            body: SafeArea(
                child: KeyboardActions(
              config: KeyboardActionsConfig(
                keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
                nextFocus: true,
                actions: [
                  for (int i = 0; i < _nodeText1.length; i++)
                    KeyboardActionsItem(
                      focusNode: _nodeText1[i],
                      displayDoneButton: true,
                      onTapAction: () {
                        box.putAt(
                            i,
                            Plan(
                                name: box.getAt(i)!.name,
                                followers: followersController[i].text,
                                likes: box.getAt(i)!.likes,
                                posts: box.getAt(i)!.posts));
                      },
                    ),
                  for (int i = 0; i < _nodeText2.length; i++)
                    KeyboardActionsItem(
                      focusNode: _nodeText2[i],
                      displayDoneButton: true,
                      onTapAction: () {
                        box.putAt(
                            i,
                            Plan(
                                name: box.getAt(i)!.name,
                                followers: box.getAt(i)!.followers,
                                likes: likesController[i].text,
                                posts: box.getAt(i)!.posts));
                      },
                    ),
                  for (int i = 0; i < _nodeText3.length; i++)
                    KeyboardActionsItem(
                      focusNode: _nodeText3[i],
                      displayDoneButton: true,
                      onTapAction: () {
                        box.putAt(
                            i,
                            Plan(
                                name: box.getAt(i)!.name,
                                followers: box.getAt(i)!.followers,
                                likes: box.getAt(i)!.likes,
                                posts: postController[i].text));
                      },
                    ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(
                                "assets/arrow_back.svg",
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30.w,
                          )
                        ],
                      ),
                    ),
                    for (int i = 0; i < box.values.length; i++)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: SizedBox(
                                width: 321.w,
                                child: Text(
                                  box.getAt(i)!.name.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: Container(
                                  width: 321.w,
                                  height: 35.h,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: const Color(0xFF878489))),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Followers",
                                          style: TextStyle(fontSize: 16.sp),
                                        ),
                                        Container(
                                          height: 20.h,
                                          width: 74.w,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      const Color(0xFF878489)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.r))),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  int count = int.parse(
                                                          followersController[i]
                                                              .text) -
                                                      1;

                                                  followersController[i].text =
                                                      count.toString();
                                                  box.putAt(
                                                      i,
                                                      Plan(
                                                          name: box
                                                              .getAt(i)!
                                                              .name,
                                                          followers:
                                                              followersController[
                                                                      i]
                                                                  .text,
                                                          likes: box
                                                              .getAt(i)!
                                                              .likes,
                                                          posts: box
                                                              .getAt(i)!
                                                              .posts));
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  width: 21.w,
                                                  height: 20.h,
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFF803CEF),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.r))),
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                    size: 15.w,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 25.h,
                                                width: 30.w,
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: TextField(
                                                    textAlign: TextAlign.center,
                                                    controller:
                                                        followersController[i],
                                                    focusNode: _nodeText1[i],
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 10),
                                                        border: InputBorder
                                                            .none, // Убираем обводку
                                                        focusedBorder: InputBorder
                                                            .none, // Убираем обводку при фокусе
                                                        hintText: '',
                                                        hintStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.grey,
                                                            fontSize: 12.sp)),
                                                    keyboardType:
                                                        TextInputType.text,
                                                    cursorColor: Colors.black,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12.sp),
                                                    onChanged: (text) {
                                                      setState(() {});
                                                    },
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  int count = int.parse(
                                                          followersController[i]
                                                              .text) +
                                                      1;

                                                  followersController[i].text =
                                                      count.toString();
                                                  box.putAt(
                                                      i,
                                                      Plan(
                                                          name: box
                                                              .getAt(i)!
                                                              .name,
                                                          followers:
                                                              followersController[
                                                                      i]
                                                                  .text,
                                                          likes: box
                                                              .getAt(i)!
                                                              .likes,
                                                          posts: box
                                                              .getAt(i)!
                                                              .posts));
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  width: 21.w,
                                                  height: 20.h,
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFF803CEF),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.r))),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 15.w,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: Container(
                                  width: 321.w,
                                  height: 35.h,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: const Color(0xFF878489))),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Likes",
                                          style: TextStyle(fontSize: 16.sp),
                                        ),
                                        Container(
                                          height: 20.h,
                                          width: 74.w,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      const Color(0xFF878489)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.r))),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  int count = int.parse(
                                                          likesController[i]
                                                              .text) -
                                                      1;

                                                  likesController[i].text =
                                                      count.toString();
                                                  box.putAt(
                                                      i,
                                                      Plan(
                                                          name: box
                                                              .getAt(i)!
                                                              .name,
                                                          followers: box
                                                              .getAt(i)!
                                                              .followers,
                                                          likes:
                                                              likesController[i]
                                                                  .text,
                                                          posts: box
                                                              .getAt(i)!
                                                              .posts));
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  width: 21.w,
                                                  height: 20.h,
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFF803CEF),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.r))),
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                    size: 15.w,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 25.h,
                                                width: 30.w,
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: TextField(
                                                    textAlign: TextAlign.center,
                                                    controller:
                                                        likesController[i],
                                                    focusNode: _nodeText2[i],
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 10),
                                                        border: InputBorder
                                                            .none, // Убираем обводку
                                                        focusedBorder: InputBorder
                                                            .none, // Убираем обводку при фокусе
                                                        hintText: '',
                                                        hintStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.grey,
                                                            fontSize: 12.sp)),
                                                    keyboardType:
                                                        TextInputType.text,
                                                    cursorColor: Colors.black,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12.sp),
                                                    onChanged: (text) {
                                                      setState(() {});
                                                    },
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  int count = int.parse(
                                                          likesController[i]
                                                              .text) +
                                                      1;

                                                  likesController[i].text =
                                                      count.toString();
                                                  box.putAt(
                                                      i,
                                                      Plan(
                                                          name: box
                                                              .getAt(i)!
                                                              .name,
                                                          followers: box
                                                              .getAt(i)!
                                                              .followers,
                                                          likes:
                                                              likesController[i]
                                                                  .text,
                                                          posts: box
                                                              .getAt(i)!
                                                              .posts));
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  width: 21.w,
                                                  height: 20.h,
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFF803CEF),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.r))),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 15.w,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: Container(
                                  width: 321.w,
                                  height: 35.h,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: const Color(0xFF878489))),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Posts",
                                          style: TextStyle(fontSize: 16.sp),
                                        ),
                                        Container(
                                          height: 20.h,
                                          width: 74.w,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      const Color(0xFF878489)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.r))),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  int count = int.parse(
                                                          postController[i]
                                                              .text) -
                                                      1;

                                                  postController[i].text =
                                                      count.toString();
                                                  box.putAt(
                                                      i,
                                                      Plan(
                                                          name: box
                                                              .getAt(i)!
                                                              .name,
                                                          followers: box
                                                              .getAt(i)!
                                                              .followers,
                                                          likes: box
                                                              .getAt(i)!
                                                              .likes,
                                                          posts:
                                                              postController[i]
                                                                  .text));
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  width: 21.w,
                                                  height: 20.h,
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFF803CEF),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.r))),
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                    size: 15.w,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 25.h,
                                                width: 30.w,
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: TextField(
                                                    textAlign: TextAlign.center,
                                                    controller:
                                                        postController[i],
                                                    focusNode: _nodeText3[i],
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 10),
                                                        border: InputBorder
                                                            .none, // Убираем обводку
                                                        focusedBorder: InputBorder
                                                            .none, // Убираем обводку при фокусе
                                                        hintText: '',
                                                        hintStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.grey,
                                                            fontSize: 12.sp)),
                                                    keyboardType:
                                                        TextInputType.text,
                                                    cursorColor: Colors.black,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12.sp),
                                                    onChanged: (text) {
                                                      setState(() {});
                                                    },
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  int count = int.parse(
                                                          postController[i]
                                                              .text) +
                                                      1;

                                                  postController[i].text =
                                                      count.toString();
                                                  box.putAt(
                                                      i,
                                                      Plan(
                                                          name: box
                                                              .getAt(i)!
                                                              .name,
                                                          followers: box
                                                              .getAt(i)!
                                                              .followers,
                                                          likes: box
                                                              .getAt(i)!
                                                              .likes,
                                                          posts:
                                                              postController[i]
                                                                  .text));
                                                  setState(() {});
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  width: 21.w,
                                                  height: 20.h,
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFF803CEF),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.r))),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 15.w,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const AddCountPage(),
                          ),
                        );
                      },
                      child: Container(
                        width: 327.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                          color: const Color(0xFF803CEF),
                        ),
                        child: Center(
                          child: Text(
                            "Add counting",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.sp),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
          );
        });
  }
}
