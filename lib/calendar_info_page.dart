import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smm/date/boxes.dart';
import 'package:smm/date/calendar_info.dart';
import 'package:smm/date/select_an_account.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';

class CalendarInfoPage extends StatefulWidget {
  const CalendarInfoPage({super.key});

  @override
  State<CalendarInfoPage> createState() {
    return _CalendarInfoPageState();
  }
}

class _CalendarInfoPageState extends State<CalendarInfoPage> {
  DateTime _currentMonth =
      DateTime(DateTime.now().year, DateTime.now().month, 1);
  final PageController _pageController = PageController(
      initialPage: DateTime.now().month - 1, viewportFraction: 0.8);
  final DateTime _nowDate =
      DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime? _selectDate;
  TextEditingController noteController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final ScrollController _firstController = ScrollController();
  String menuItem = "Add";
  Set<String> name = {};

  _updateFormCompletion() {
    bool isFilled = _selectDate != null &&
        _selectedItem2 != null &&
        noteController.text.isNotEmpty;
    return isFilled;
  }

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
      margin: EdgeInsets.all(10.h),
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
          height: 31.h,
          width: 315.w,
          padding: EdgeInsets.only(left: 14.w, right: 14.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
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
    return ValueListenableBuilder(
        valueListenable:
            Hive.box<CalendarInfo>(HiveBoxes.calendarInfo).listenable(),
        builder: (context, Box<CalendarInfo> box, _) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.paddingOf(context).top,
                  bottom: MediaQuery.paddingOf(context).bottom),
              child: KeyboardActions(
                config: KeyboardActionsConfig(nextFocus: false, actions: [
                  KeyboardActionsItem(
                    focusNode: _nodeText1,
                  ),
                ]),
                child: SizedBox(
                  width: double.maxFinite,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      menuItem = "Add";
                                      setState(() {});
                                    },
                                    child: Center(
                                        child: Text(
                                      "Add",
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: menuItem == "Add"
                                              ? Colors.deepPurple
                                              : Colors.grey),
                                    )),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      menuItem = "Info";
                                      setState(() {});
                                    },
                                    child: Center(
                                        child: Text(
                                      "Info",
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        color: menuItem == "Info"
                                            ? Colors.deepPurple
                                            : Colors.grey,
                                      ),
                                    )),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 30.w,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 330.h,
                          child: PageView.builder(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() {
                                _currentMonth = DateTime(
                                  _nowDate.year + index ~/ 12,
                                  (index % 12) + 1,
                                );
                              });
                            },
                            itemCount: 12 * 3,
                            itemBuilder: (context, pageIndex) {
                              return Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.h),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.r))),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30.w),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.h),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                DateFormat('MMMM yyyy')
                                                    .format(_currentMonth),
                                                style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: buildCalendar(
                                                DateTime(_currentMonth.year,
                                                    _currentMonth.month, 1),
                                                box),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        if (_selectDate != null &&
                            box.isNotEmpty &&
                            menuItem == "Info")
                          if (box.getAt(0)!.day.containsKey(
                              DateFormat('dd.MM.yy').format(_selectDate!)))
                            Padding(
                              padding: EdgeInsets.only(top: 58.h),
                              child: Container(
                                width: 315.w,
                                height: 294.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.r)),
                                ),
                                child: VsScrollbar(
                                  controller: _firstController,
                                  showTrackOnHover: true, // default false
                                  isAlwaysShown: true, // default false
                                  scrollbarFadeDuration: const Duration(
                                      milliseconds:
                                          500), // default : Duration(milliseconds: 300)
                                  scrollbarTimeToFade: const Duration(
                                      milliseconds:
                                          800), // default : Duration(milliseconds: 600)
                                  style: VsScrollbarStyle(
                                    hoverThickness: 100.0, // default 12.0
                                    radius: const Radius.circular(
                                        20), // default Radius.circular(8.0)
                                    thickness: 10.0, // [ default 8.0 ]
                                    color: Colors.purple
                                        .shade900, // default ColorScheme Theme
                                  ),

                                  child: ListView.builder(
                                    controller: _firstController,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 20.w),
                                    shrinkWrap: true,
                                    itemCount: box
                                        .getAt(0)!
                                        .day[DateFormat('dd.MM.yy')
                                            .format(_selectDate!)]!
                                        .length,
                                    cacheExtent: 10000, // higher than content

                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 10.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              box
                                                  .getAt(0)!
                                                  .day[DateFormat('dd.MM.yy')
                                                      .format(_selectDate!)]![0]
                                                  .name
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text(
                                                box
                                                    .getAt(0)!
                                                    .day[DateFormat('dd.MM.yy')
                                                        .format(
                                                            _selectDate!)]![0]
                                                    .note
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 16.sp.sp,
                                                )),
                                            const Divider()
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                        if (menuItem == "Add")
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 30.h),
                                child: _onChangedWithValue(),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Container(
                                  height: 141.h,
                                  width: 315.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.r)),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: TextField(
                                      minLines: 1,
                                      maxLines:
                                          null, // Позволяет полю расширяться по мере добавления строк
                                      controller: noteController,
                                      focusNode: _nodeText1,
                                      textInputAction: TextInputAction.newline,
                                      decoration: InputDecoration(
                                          border: InputBorder
                                              .none, // Убираем обводку
                                          focusedBorder: InputBorder
                                              .none, // Убираем обводку при фокусе
                                          hintText: '',
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                              fontSize: 16.sp)),
                                      keyboardType: TextInputType.multiline,
                                      cursorColor: Colors.black,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp),
                                      onChanged: (text) {
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 30.h),
                                child: SizedBox(
                                    width: 300.w,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            _selectedItem2 = null;
                                            noteController.text = '';
                                            setState(() {});
                                          },
                                          child: Container(
                                            height: 46.h,
                                            width: 100.w,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 2.h,
                                                    color: const Color(
                                                        0xFF803CEF)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(17.r))),
                                            child: Center(
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xFF803CEF),
                                                    fontSize: 14.sp),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (_updateFormCompletion()) {
                                              DayIs dayAdd = DayIs(
                                                  name: _selectedItem2,
                                                  note: noteController.text);
                                              if (box.isEmpty) {
                                                box.add(CalendarInfo(day: {
                                                  DateFormat("dd.MM.yy")
                                                      .format(_selectDate!): [
                                                    dayAdd
                                                  ]
                                                }));
                                              } else {
                                                if (box
                                                    .getAt(0)!
                                                    .day
                                                    .containsKey(DateFormat(
                                                            "dd.MM.yy")
                                                        .format(
                                                            _selectDate!))) {
                                                  List<DayIs> dayInfo = box
                                                      .getAt(0)!
                                                      .day[DateFormat(
                                                          "dd.MM.yy")
                                                      .format(_selectDate!)]!;
                                                  dayInfo.add(dayAdd);
                                                  Map<String, List<DayIs>>
                                                      infoBox =
                                                      box.getAt(0)!.day;
                                                  infoBox[DateFormat("dd.MM.yy")
                                                          .format(
                                                              _selectDate!)] =
                                                      dayInfo;
                                                  box.putAt(
                                                      0,
                                                      CalendarInfo(
                                                          day: infoBox));
                                                } else {
                                                  Map<String, List<DayIs>>
                                                      infoBox =
                                                      box.getAt(0)!.day;
                                                  infoBox[DateFormat("dd.MM.yy")
                                                      .format(_selectDate!)] = [
                                                    dayAdd
                                                  ];
                                                  box.putAt(
                                                      0,
                                                      CalendarInfo(
                                                          day: infoBox));
                                                }
                                              }
                                              _selectedItem2 = null;
                                              noteController.text = "";
                                              setState(() {});
                                            }
                                          },
                                          child: Container(
                                            height: 46.h,
                                            width: 100.w,
                                            decoration: BoxDecoration(
                                                color: _updateFormCompletion()
                                                    ? const Color(0xFF803CEF)
                                                    : const Color.fromARGB(
                                                        255, 184, 146, 246),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(17.r))),
                                            child: Center(
                                              child: Text(
                                                "Add",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.sp),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

// Вот как выглядит ваш метод buildCalendar после правок:
  Widget buildCalendar(DateTime month, Box<CalendarInfo> box) {
    int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    DateTime firstDayOfMonth = DateTime(month.year, month.month, 1);
    int weekdayOfFirstDay =
        firstDayOfMonth.weekday; // 1 = понедельник, 7 = воскресенье

    List<Widget> calendarCells = [];

    // for (int i = 0; i < weekDays.length; i++) {
    //   _currentMonth.weekday - 1 == i
    //       ? calendarCells.add(Container(
    //           decoration: const BoxDecoration(border: Border()),
    //           alignment: Alignment.center,
    //           child: Text(
    //             DateFormat('MMM').format(_currentMonth),
    //             style: TextStyle(
    //               fontWeight: FontWeight.bold,
    //               color: Colors.black,
    //             ),
    //           ),
    //         ))
    //       : calendarCells.add(SizedBox.shrink());
    // }

    // Добавить пустые ячейки для начала месяца
    for (int i = 0; i < weekdayOfFirstDay - 1; i++) {
      calendarCells.add(Container(
        decoration: const BoxDecoration(border: Border()),
        alignment: Alignment.center,
        child: const Text(""),
      ));
    }

    // Добавление дней в месяц
    for (int i = 1; i <= daysInMonth; i++) {
      DateTime date = DateTime(month.year, month.month, i);
      bool isToday = date.isSameDate(DateTime.now());

      calendarCells.add(
        GestureDetector(
          onTap: () {
            _selectDate = date;
            setState(() {});
          },
          child: Container(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Text(
                  date.day.toString(),
                  style: TextStyle(
                    color: isToday ? Colors.green : Colors.black,
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                _selectDate == date
                    ? Container(
                        width: 4.w,
                        height: 4.w,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      )
                    : box.isNotEmpty
                        ? box.getAt(0)!.day.containsKey(
                                DateFormat('dd.MM.yy').format(date))
                            ? Container(
                                width: 4.w,
                                height: 4.w,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                              )
                            : const SizedBox.shrink()
                        : const SizedBox.shrink()
              ],
            ),
          ),
        ),
      );
    }

    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      crossAxisCount: 7,
      childAspectRatio: (40.w / 52.h),
      children: calendarCells,
    );
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
