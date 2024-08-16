import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DataList {
   String? name;
   String? audioUrl;

  DataList({
    required this.name,
    required this.audioUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'audioUrl': audioUrl,
    };
  }

  factory DataList.fromJson(Map<String, dynamic> json) {
    return DataList(
      name: json['name'],
      audioUrl: json['audioUrl'],
    );
  }

  static List<DataList> allListAthkar = [
    DataList(
      name: 'بسم الله الرحمن الرحيم',
      audioUrl: 'file1.mp3',
    ),
    DataList(
      name: 'استغفر الله العظيم واتوب اليه',
      audioUrl: 'file2.mp3',
    ),
    DataList(
      name: 'سبحان الله',
      audioUrl: 'file3.mp3',
    ),
    DataList(
      name: 'الحمد الله',
      audioUrl: 'file4.mp3',
    ),
    DataList(
      name: 'لا اله الا الله',
      audioUrl: 'file5.mp3',
    ),
    DataList(
      name: 'الله اكبر',
      audioUrl: 'file6.mp3',
    ),
    DataList(
      name: 'لا حول ولا قوة الا بالله',
      audioUrl: 'file7.mp3',
    ),
    DataList(
      name: 'الْلَّهُم صَلِّ وَسَلِم وَبَارِك عَلَى سَيِّدِنَا مُحَمَّد',
      audioUrl: 'file8.mp3',
    ),
    DataList(
      name: 'ياذا الجلال والاكرام',
      audioUrl: 'file9.mp3',
    ),
    DataList(
      name: 'لا اله الا انت سبحانك اني كنت من الظالمين',
      audioUrl: 'file10.mp3',
    ),
    DataList(
      name:
          'سبحان الله والحمد لله ولا اله الا الله والله اكبر ولا حول ولا قوه الا بالله',
      audioUrl: 'file11.mp3',
    ),
    DataList(
      name:
          ' اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ , وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ , اللَّهُمَّ بَارِكْ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا بَارَكْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ( الصلاة الابراهيمية )',
      audioUrl: 'file12.mp3',
    ),
    DataList(
      name: 'حسبى الله لا اله الا هو عليه توكلت وهو رب العرش العظيم',
      audioUrl: 'file13.mp3',
    ),
    DataList(
      name:
          'بسمِ اللهِ الذي لا يَضرُ مع اسمِه شيءٌ في الأرضِ ولا في السماءِ وهو السميعُ العليمِ',
      audioUrl: 'file14.mp3',
    ),
    DataList(
      name:
          'سُبْحَانَ اللهِ وَبِحَمْدِهِ، عَدَدَ خَلْقِهِ وَرِضَا نَفْسِهِ وَزِنَةَ عَرْشِهِ وَمِدَادَ كَلِمَاتِهِ',
      audioUrl: 'file15.mp3',
    ),
    DataList(
      name:
          'يا حيُّ يا قيُّومُ، برَحمتِكَ أستَغيثُ، أصلِح لي شأني كُلَّهُ، ولا تَكِلني إلى نَفسي طرفةَ عينٍ',
      audioUrl: 'file16.mp3',
    ),
    DataList(
      name: 'سُبْحَانَ اللَّهِ وَالْحَمْدُ لِلَّهِ',
      audioUrl: 'file17.mp3',
    ),
    DataList(
      name: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ ، سُبْحَانَ اللَّهِ الْعَظِيمِ',
      audioUrl: 'file18.mp3',
    ),
    DataList(
      name:
          'لا إلَه إلّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلُّ شَيْءِ قَدِيرِ.',
      audioUrl: 'file19.mp3',
    ),
    DataList(
      name: 'اعوذ بالله من الشيطان الرجيم',
      audioUrl: 'file20.mp3',
    ),
    DataList(
      name:
          'سُبْحَانَ اللَّهِ ، وَالْحَمْدُ لِلَّهِ ، وَلا إِلَهَ إِلا اللَّهُ ، وَاللَّهُ أَكْبَرُ ، اللَّهُمَّ اغْفِرْ لِي ، اللَّهُمَّ ارْحَمْنِي ، اللَّهُمَّ ارْزُقْنِي.( خير الدنيا والاخرة )',
      audioUrl: 'file21.mp3',
    ),
    DataList(
      name: 'الْحَمْدُ لِلَّهِ حَمْدًا كَثِيرًا طَيِّبًا مُبَارَكًا فِيهِ.',
      audioUrl: 'file22.mp3',
    ),
    DataList(
      name:
          'اللَّهُ أَكْبَرُ كَبِيرًا ، وَالْحَمْدُ لِلَّهِ كَثِيرًا ، وَسُبْحَانَ اللَّهِ بُكْرَةً وَأَصِيلاً.',
      audioUrl: 'file23.mp3',
    ),
    DataList(
      name:
          'لبيك اللهم لبيك لبيك لا شريك لك لبيك ان الحمد والنعمة لك والملك لا شريك لك( صوت الحج )',
      audioUrl: 'file24.mp3',
    ),
    DataList(
      name:
          'سبحان ذى المجد والنِّعم، سبحان ذى القدرة والكرم، سبحان ذى الجلال والإِكرام.(تسبيح سيدنا نوح عليه السّلام)',
      audioUrl: 'file25.mp3',
    ),
    DataList(
      name:
          '(تسبيح سيدنا آدم عليه السّلام ) سبحان ذى المُلْك والمَلَكُوت، سبحان ذى القدرة والجَبَرُوت، سبحان الحىّ الذى لا يموت.',
      audioUrl: 'file26.mp3',
    ),
    DataList(
      name:
          'سبحان الملِك القدّوس، سبّوح قدّوس، وربّ الملائكة والرّوح.(تسبيح سيدنا جبريل عليه السلام)',
      audioUrl: 'file27.mp3',
    ),
    DataList(
      name:
          ' سبحان الذى تَعَطَّف بالعِزِّ وقال به، سبحان الَّذِى لبس المجد وتكرّم به، سُبحان مَن لا ينبغى التسبيحُ إِلاَّ له(تسبيح سيدنا يوسف عليه السلام )',
      audioUrl: 'file28.mp3',
    ),
    DataList(
      name:
          ' سبحان الواحد الأَحَد، سبحان الباقى على الأَبد، سبحان الذى لم يلد ولم يولد ولم يكن له كُفْوًا أَحد(تسبيح سيدنا عيسى عليه السلام)',
      audioUrl: 'file29.mp3',
    ),
    DataList(
      name:
          ' سبحان الله وبحمده، سبحان الله العظيم وبحمده، أَستغفرُ الله وأَتوب إِليه.(تسبيح سيدنا محمّد صلَّى الله عليه وسلم)',
      audioUrl: 'file30.mp3',
    ),
    DataList(
      name: 'سبحان ربي العظيم',
      audioUrl: 'file31.mp3',
    ),
    DataList(
      name: 'سبحان ربي الاعلى',
      audioUrl: 'file32.mp3',
    ),
  ];

   static Future<List<DataList>> loadItems() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String? jsonString = prefs.getString('dataList');
     if (jsonString != null) {
       List<dynamic> jsonList = jsonDecode(jsonString);
       return jsonList.map((json) => DataList.fromJson(json)).toList();
     } else {
       return [];
     }
   }

   static Future<void> saveItems(List<DataList> list) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String jsonString = jsonEncode(list.map((item) => item.toJson()).toList());
     await prefs.setString('dataList', jsonString);
   }

   static Future<void> addItem(DataList item) async {
     List<DataList> currentItems = await loadItems();
     currentItems.add(item);
     await saveItems(currentItems);
   }

   static Future<void> updateItem(int index, DataList newItem) async {
     List<DataList> currentItems = await loadItems();
     if (index >= 0 && index < currentItems.length) {
       currentItems[index] = newItem;
       await saveItems(currentItems);
     }
   }

   static Future<void> deleteItem(int index) async {
     List<DataList> currentItems = await loadItems();
     if (index >= 0 && index < currentItems.length) {
       currentItems.removeAt(index);
       await saveItems(currentItems);
     }
   }
}
