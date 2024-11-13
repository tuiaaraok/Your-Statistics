import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smm/date/accounts.dart';
import 'package:smm/date/boxes.dart';
import 'package:smm/date/select_an_account.dart';

class AddContentPage extends StatefulWidget {
  const AddContentPage({super.key});

  @override
  State<AddContentPage> createState() {
    // TODO: implement createState
    return _AddContentPageState();
  }
}

class _AddContentPageState extends State<AddContentPage> {
  TextEditingController orderTypeController = TextEditingController();
  TextEditingController customerController = TextEditingController();
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  int currentIndex = -1;
  final FocusNode _nodeText1 = FocusNode();
  Set<Uint8List> image = {};
  List<String> defImage = [
    "assets/twitter.png",
    "assets/facebook.png",
    "assets/instagram.png",
    "assets/tik-tok.png"
  ];
  List<Widget> icons = [];

  Future getLostData() async {
    XFile? picker = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picker == null) return;
    List<int> imageBytes = await picker.readAsBytes();
    image.add(Uint8List.fromList(imageBytes));
  }

  _updateFormCompletion() {
    bool isFilled = orderTypeController.text.isNotEmpty &&
        customerController.text.isNotEmpty &&
        loginController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        currentIndex != -1;
    return isFilled;
  }

  // ... existing code ...

  @override
  void initState() {
    super.initState();
    _loadInitialData(); // Call your method here
  }

  Future<void> _loadInitialData() async {
    Box<SelectAnAccount> contactsBox =
        Hive.box<SelectAnAccount>(HiveBoxes.selectAnAccount);

    if (contactsBox.isEmpty) {
      for (String action in defImage) {
        final ByteData bytes = await rootBundle.load(action);
        image.add(bytes.buffer.asUint8List());
      }

      SelectAnAccount addSelect = SelectAnAccount(images: image.toSet());
      await contactsBox.add(addSelect);
    } else {
      // Here we assume you're retrieving the last stored SelectAnAccount object
      SelectAnAccount storedAccount = contactsBox.getAt(0) as SelectAnAccount;
      image = storedAccount.images!;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
        child: KeyboardActions(
          config: KeyboardActionsConfig(nextFocus: false, actions: [
            KeyboardActionsItem(
              focusNode: _nodeText1,
            ),
          ]),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10.h, right: 10.w),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        "assets/menu_icon.svg",
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 655.h,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Connect account",
                            style: TextStyle(
                                fontSize: 30.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 10.h, top: 10.h, left: 20.w),
                          child: SizedBox(
                            height: 50.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: image.length + 1,
                              itemBuilder: (BuildContext context, int index) {
                                if (index == image.length) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: GestureDetector(
                                      onTap: () async {
                                        await getLostData();
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 32.h,
                                        width: 32.h,
                                        decoration: const BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle),
                                        child: Center(
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 30.h,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                return Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    child: GestureDetector(
                                      onTap: () {
                                        currentIndex = index;
                                        setState(() {});
                                      },
                                      child: Container(
                                        width:
                                            currentIndex == index ? 50.h : 35.h,
                                        height:
                                            currentIndex == index ? 50.h : 35.h,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: MemoryImage(
                                              image.elementAt(index)),
                                        )),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 310.w,
                          child: Text(
                            "Order type",
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
                                controller: orderTypeController,
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
                        SizedBox(
                          width: 310.w,
                          child: Text(
                            "Customer",
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
                                controller: customerController,
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
                        SizedBox(
                          width: 310.w,
                          child: Text(
                            "Login",
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
                                controller: loginController,
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
                        SizedBox(
                          width: 310.w,
                          child: Text(
                            "Password",
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
                                controller: passwordController,
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
                        SizedBox(
                          height: 12.h,
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.paddingOf(context).bottom,
                        top: 20.h),
                    child: SizedBox(
                        width: 300.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                orderTypeController.text = "";
                                customerController.text = "";
                                loginController.text = "";
                                passwordController.text = "";
                                setState(() {});
                              },
                              child: Container(
                                height: 46.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2.h,
                                        color: const Color(0xFF803CEF)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(17.r))),
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
                              onTap: () async {
                                if (_updateFormCompletion()) {
                                  Accounts addAccount = Accounts(
                                    imageContent: image.elementAt(currentIndex),
                                    orderType: orderTypeController.text,
                                    customer: customerController.text,
                                    login: loginController.text,
                                    password: passwordController.text,
                                  );
                                  Box<SelectAnAccount> selectBox =
                                      Hive.box<SelectAnAccount>(
                                          HiveBoxes.selectAnAccount);
                                  Set<String> names = {};
                                  if (selectBox.getAt(0)?.selectList != null) {
                                    names.addAll(
                                        selectBox.getAt(0)!.selectList!);
                                  }
                                  names.add(customerController.text);

                                  selectBox.putAt(
                                      0,
                                      SelectAnAccount(
                                          selectList: names, images: image));

                                  Box<Accounts> accountsBox =
                                      Hive.box<Accounts>(HiveBoxes.accounts);
                                  accountsBox.add(addAccount);
                                  Navigator.pop(context);
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
                                        color: Colors.white, fontSize: 14.sp),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
