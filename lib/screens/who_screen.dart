import 'package:flutter/material.dart';

class WhoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Text(
          'repeat sound ©سبحة أذكار صوتيه',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff3949AB),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'تطبيق لتكرار الصوت يساعد على ذكر الله كثيرا والحفظ والمذاكرة والتذكير بسهولة فى اى روتين لحياتك مع استخدامات كثيرة اخرى',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          Text('للتواصل مع صاحب التطبيق من الواتساب 459030292392 :'),
          Text('للتواصل مع صاحب التطبيق من الجيميل afadjnjedje@gmail.com :'),
          Text('للتواصل مع المطور afadjnjedje@gmail.com :'),
        ],
      ),
    );
  }
}
