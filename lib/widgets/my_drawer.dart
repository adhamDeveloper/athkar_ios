import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

final InAppReview inAppReview = InAppReview.instance;

Widget myDrawer(BuildContext context) {
  return Drawer(
    child: Column(
      children: [
        DrawerHeader(
            child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: const Color(0xff293658),
              child: Image.asset('assets/images/logo.png'),
            ),
            const Text('repeat sound ©سبحة أذكار صوتيه'),
          ],
        )),
        ListTile(
          onTap: () {
            Navigator.pushReplacementNamed(context, '/home_screen');
          },
          title: const Text(
            'الرئيسية',
            textAlign: TextAlign.right,
          ),
          leading: const Icon(
            Icons.home,
            color: Color(0xff3949AB),
          ),
        ),
        ListTile(
          onTap: () async {
            _shareApp(context);
          },
          title: const Text(
            'مشاركة التطبيق',
            textAlign: TextAlign.right,
          ),
          leading: const Icon(
            Icons.share,
            color: Color(0xff3949AB),
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/who_screen');
          },
          title: const Text(
            'من نحن',
            textAlign: TextAlign.right,
          ),
          leading: const Icon(
            Icons.question_mark,
            color: Color(0xff3949AB),
          ),
        ),
        ListTile(
          onTap: () {
            openGmail();
            print('OPEN GMAIL!');
          },
          title: const Text(
            'تواصل معنا',
            textAlign: TextAlign.right,
          ),
          leading: const Icon(
            Icons.email_outlined,
            color: Color(0xff3949AB),
          ),
        ),
        ListTile(
          onTap: () async {
            if (await inAppReview.isAvailable()) {
              inAppReview.requestReview();
              inAppReview.openStoreListing(
                  appStoreId:
                      'https://apps.apple.com/app/app-name/id1111111111');
            }
          },
          title: const Text(
            'قيمنا',
            textAlign: TextAlign.right,
          ),
          leading: const Icon(
            Icons.star_border,
            color: Color(0xff3949AB),
          ),
        ),
      ],
    ),
  );
}

void _shareApp(BuildContext context) {
  final RenderBox box = context.findRenderObject() as RenderBox;
  const String subject =
      'تطبيق لتكرار الصوت يساعد على ذكر الله كثيرا والحفظ والمذاكرة والتذكير بسهولة فى اى روتين لحياتك مع استخدامات كثيرة اخرى';
  String url = Platform.isAndroid
      ? 'https://play.google.com/store/apps/details?id=your.app.package'
      : 'https://apps.apple.com/app/app-name/id1111111111';

  Share.share(
    url,
    subject: subject,
    sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
  );
}

void openGmail() async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'adhammheeb99@gmail.com',
    query: Uri.encodeFull('subject=Hello&body=How are you?'),
  );

  try {
    await launch(emailLaunchUri.toString());
  } catch (e) {
    print('Error: $e');
  }
}
