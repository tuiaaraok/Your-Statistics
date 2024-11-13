import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() {
    return _InfoPageState();
  }
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8C59DE),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    "assets/arrow_back.svg",
                    // ignore: deprecated_member_use
                    color: Colors.white,
                    width: 26.w,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: Container(
                      width: 347.w,
                      height: 74.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.r))),
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {
                            String? encodeQueryParameters(
                                Map<String, String> params) {
                              return params.entries
                                  .map((MapEntry<String, String> e) =>
                                      '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                  .join('&');
                            }

                            // ···
                            final Uri emailLaunchUri = Uri(
                              scheme: 'mailto',
                              path: 'tumayaltinli56@icloud.com',
                              query: encodeQueryParameters(<String, String>{
                                '': '',
                              }),
                            );
                            try {
                              if (await canLaunchUrl(emailLaunchUri)) {
                                await launchUrl(emailLaunchUri);
                              } else {
                                throw Exception(
                                    "Could not launch $emailLaunchUri");
                              }
                            } catch (e) {
                              log('Error launching email client: $e'); // Log the error
                            }
                          },
                          child: Text(
                            "Contact us",
                            style: TextStyle(
                                fontSize: 24.sp, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: Container(
                      width: 347.w,
                      height: 74.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.r))),
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {
                            final Uri url = Uri.parse(
                                'https://docs.google.com/document/d/1Mf7gJ6hXdaDVhH2KtERZEeCf2cajo0xRfJq9mVjQAlU/mobilebasic');
                            if (!await launchUrl(url)) {
                              throw Exception('Could not launch $url');
                            }
                          },
                          child: Text(
                            "Privacy policy",
                            style: TextStyle(
                                fontSize: 24.sp, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: Container(
                      width: 347.w,
                      height: 74.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.r))),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            LaunchReview.launch(iOSAppId: "6738126843");
                          },
                          child: Text(
                            "Rate us",
                            style: TextStyle(
                                fontSize: 24.sp, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
