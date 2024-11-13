import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:smm/date/boxes.dart';
import 'package:smm/date/plan.dart';
import 'package:smm/date/select_an_account.dart';

class AddCountPage extends StatefulWidget {
  const AddCountPage({super.key});

  @override
  State<AddCountPage> createState() {
    return _AddCountPageState();
  }
}

class _AddCountPageState extends State<AddCountPage> {
  TextEditingController followersController = TextEditingController();
  TextEditingController likesController = TextEditingController();
  TextEditingController postsController = TextEditingController();
  Set<String> name = {};
  @override
  void initState() {
    super.initState();
    Box<SelectAnAccount> selectBox =
        Hive.box<SelectAnAccount>(HiveBoxes.selectAnAccount);
    if (selectBox.isNotEmpty) {
      for (var action in selectBox.getAt(0)?.selectList ?? {}) {
        name.add(action);
      }
    }
  }

  _updateFormCompletion() {
    bool isFilled = followersController.text.isNotEmpty &&
        likesController.text.isNotEmpty &&
        postsController.text.isNotEmpty &&
        _selectedItem2 != null;
    return isFilled;
  }

  List<DropdownMenuItem<String>> _createList() {
    return name
        .map<DropdownMenuItem<String>>(
          (e) => DropdownMenuItem(
            value: e,
            child: Center(
                child: Text(
              e,
              style: TextStyle(fontSize: 16.sp),
            )),
          ),
        )
        .toList();
  }

  Widget _createDropdownContainer(
    Widget dropdown,
    String? value,
  ) {
    return Container(
      child: dropdown,
    );
  }

  String? _selectedItem2;
  Widget _onChangedWithValue() {
    final dropdown = DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        style: TextStyle(fontSize: 16.sp, color: Colors.black),
        buttonStyleData: ButtonStyleData(
          height: 44.h,
          width: 310.w,
          padding: EdgeInsets.only(left: 14.w, right: 14.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            border: Border.all(color: const Color(0xFFA1A1A1), width: 2.w),
            color: Colors.white,
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          width: 310.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
          ),
          offset: const Offset(0, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: Radius.circular(40.r),
            thickness: WidgetStateProperty.all(6),
            thumbVisibility: WidgetStateProperty.all(true),
          ),
        ),
        items: _createList(),
        value: _selectedItem2,
        hint: Text(
          _selectedItem2 == null ? 'Select an account' : '',
          style: TextStyle(color: Colors.grey, fontSize: 16.sp),
        ),
        onChanged: (String? value) {
          setState(() {
            _selectedItem2 = value ?? "";
          });
        },
      ),
    );

    return _createDropdownContainer(
      dropdown,
      _selectedItem2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.paddingOf(context).top,
            bottom: MediaQuery.paddingOf(context).bottom),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  child: SvgPicture.asset(
                    "assets/arrow_back.svg",
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: SizedBox(
                width: 310.w,
                child: Text(
                  "Add count",
                  style:
                      TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              width: 390.w,
              height: 382.h,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.r))),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 310.w,
                          child: Text(
                            "Account",
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        _onChangedWithValue(),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 310.w,
                          child: Text(
                            "Followers",
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          height: 44.h,
                          width: 310.w,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3.r)),
                              border: Border.all(
                                  color: const Color(0xFFA1A1A1), width: 2.w)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Center(
                              child: TextField(
                                controller: followersController,
                                decoration: InputDecoration(
                                    border: InputBorder.none, // Убираем обводку
                                    focusedBorder: InputBorder
                                        .none, // Убираем обводку при фокусе
                                    hintText: '',
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: 18.sp)),
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp),
                                onChanged: (text) {
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 310.w,
                          child: Text(
                            "Likes",
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          height: 44.h,
                          width: 310.w,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3.r)),
                              border: Border.all(
                                  color: const Color(0xFFA1A1A1), width: 2.w)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Center(
                              child: TextField(
                                controller: likesController,
                                decoration: InputDecoration(
                                    border: InputBorder.none, // Убираем обводку
                                    focusedBorder: InputBorder
                                        .none, // Убираем обводку при фокусе
                                    hintText: '',
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: 18.sp)),
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp),
                                onChanged: (text) {
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 310.w,
                          child: Text(
                            "Posts",
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          height: 44.h,
                          width: 310.w,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3.r)),
                              border: Border.all(
                                  color: const Color(0xFFA1A1A1), width: 2.w)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Center(
                              child: TextField(
                                controller: postsController,
                                decoration: InputDecoration(
                                    border: InputBorder.none, // Убираем обводку
                                    focusedBorder: InputBorder
                                        .none, // Убираем обводку при фокусе
                                    hintText: '',
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: 18.sp)),
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp),
                                onChanged: (text) {
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
                width: 300.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _selectedItem2 = null;
                        followersController.text = "";
                        likesController.text = "";
                        followersController.text = "";

                        setState(() {});
                      },
                      child: Container(
                        height: 46.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2.h, color: const Color(0xFF803CEF)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(17.r))),
                        child: Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: const Color(0xFF803CEF),
                                fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_updateFormCompletion()) {
                          Box<Plan> planBox = Hive.box<Plan>(HiveBoxes.plan);
                          planBox.add(Plan(
                              name: _selectedItem2,
                              followers: followersController.text,
                              likes: likesController.text,
                              posts: postsController.text));
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        height: 46.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            color: _updateFormCompletion()
                                ? const Color(0xFF803CEF)
                                : const Color.fromARGB(255, 184, 146, 246),
                            borderRadius:
                                BorderRadius.all(Radius.circular(17.r))),
                        child: Center(
                          child: Text(
                            "Add",
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
