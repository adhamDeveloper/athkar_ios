import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../provider/language_provider.dart';

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
          title: Text(
            AppLocalizations.of(context)!.home,
            textAlign: TextAlign.right,
          ),
          leading: const Icon(
            Icons.home,
            color: Color(0xff3949AB),
          ),
        ),
        ListTile(
          onTap: () {
            _languageDialog(context);
          },
          title: Text(
            AppLocalizations.of(context)!.language,
            textAlign: TextAlign.right,
          ),
          leading: const Icon(
            Icons.g_translate,
            color: Color(0xff3949AB),
          ),
        ),
        ListTile(
          onTap: () async {
            _shareApp(context);
          },
          title: Text(
            AppLocalizations.of(context)!.share_app,
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
          title: Text(
            AppLocalizations.of(context)!.who,
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
          title: Text(
            AppLocalizations.of(context)!.connect,
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
          title: Text(
            AppLocalizations.of(context)!.rate,
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

Future<void> _languageDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.title),
        content: SingleChildScrollView(
            child: Column(
          children: [
            TextButton(
                onPressed: () {
                  Provider.of<LanguageProvider>(context, listen: false)
                      .changeLanguage("ar");
                  Navigator.pop(context);
                },
                child: Text("Arabic")),
            TextButton(
                onPressed: () {
                  Provider.of<LanguageProvider>(context, listen: false)
                      .changeLanguage("fr");
                  Navigator.pop(context);
                },
                child: Text("Franch")),
            TextButton(
                onPressed: () {
                  Provider.of<LanguageProvider>(context, listen: false)
                      .changeLanguage("en");
                  Navigator.pop(context);
                },
                child: Text("English")),
          ],
        )
            // ListBody(
            //   children: <Widget>[
            //     Text(
            //       AppLocalizations.of(context)!.countMsg,
            //       style: const TextStyle(fontSize: 20),
            //     ),
            //   ],
            // ),
            ),
        // actions: <Widget>[
        //   TextButton(
        //     child: Text(AppLocalizations.of(context)!.yes),
        //     onPressed: () {
        //       Provider.of<LanguageProvider>(context, listen: false)
        //           .changeLanguage();
        //       Navigator.pop(context);
        //     },
        //   ),
        //   TextButton(
        //     child: Text(AppLocalizations.of(context)!.no),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ],
      );
    },
  );
}
