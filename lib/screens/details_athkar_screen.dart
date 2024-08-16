import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../widgets/data_list.dart';
import '../widgets/my_textfields.dart';
import '../widgets/snackbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailsAthkarScreen extends StatefulWidget {
  final DataList list;

  const DetailsAthkarScreen({super.key, required this.list});

  @override
  State<DetailsAthkarScreen> createState() => _DetailsAthkarScreenState();
}

class _DetailsAthkarScreenState extends State<DetailsAthkarScreen>
    with Helpers {
  late TextEditingController _countNumberController;

  int _counter = 0;
  int totalCount = 1; // الإجمالي
  double playbackSpeed = 1.0; // Default playback speed
  final AudioPlayer _instance = AudioPlayer();
  Timer? _timer;
  Completer<void>? _audioCompletion;
  final List<double> _playbackSpeeds = [0.5, 1.0, 1.5, 2.0];
  double _selectedSpeed = 1.0; // السرعة الافتراضية
  bool _isButtonDisabled = false; // متغير لتعطيل الزر
  @override
  void initState() {
    _countNumberController = TextEditingController();
    super.initState();
    _instance.onPlayerStateChanged.listen((PlayerState state) {
      print('PlayerState: $state');
    });
  }

  @override
  void dispose() {
    _countNumberController.dispose();
    _instance.stop();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _instance.stop();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Text(
          'repeat sound ©سبحة أذكار صوتيه',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff3949AB),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: MyTextField(
                        colorText: Colors.black,
                        colorIcons: const Color(0xff3949AB),
                        color: const Color(0xff3949AB),
                        colorBorder: const Color(0xff3949AB),
                        icons: Icons.numbers,
                        text: AppLocalizations.of(context)!.count,
                        keyType: TextInputType.number,
                        controller: _countNumberController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InputDecorator(
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.speed,
                          labelStyle: const TextStyle(color: Color(0xff3949AB)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Color(0xff3949AB), width: 5),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<double>(
                            value: _selectedSpeed,
                            isDense: true,
                            icon: const Icon(
                              Icons.speed,
                              color: Color(0xff3949AB),
                            ),
                            onChanged: (double? newValue) {
                              setState(() {
                                _selectedSpeed = newValue!;
                                // تعيين سرعة التشغيل للصوت
                                _instance.setPlaybackRate(_selectedSpeed);
                              });
                            },
                            items: _playbackSpeeds
                                .map<DropdownMenuItem<double>>((double value) {
                              return DropdownMenuItem<double>(
                                value: value,
                                child: Text(
                                  '$value x',
                                  textAlign: TextAlign.right,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  widget.list.name!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xff3949AB),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Center(
            child: Text(
              '$_counter',
              style: const TextStyle(
                fontSize: 50,
                color: Color(0xff3949AB),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(5.0),
                height: 300,
                width: 300,
                child: CircularProgressIndicator(
                  value: getProgress(),
                  backgroundColor: Colors.grey[300],
                  color: const Color(0xff3949AB),
                  strokeWidth: 10,
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 120,
              left: 50,
              right: 50,
              child: ElevatedButton(
                  onPressed: _isButtonDisabled
                      ? null
                      : () {
                          playMusic();
                        },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 50)),
                  child: Text(
                    AppLocalizations.of(context)!.taspeh_manoal,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xff3949AB),
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
          Positioned(
            bottom: 50,
            left: 50,
            right: 50,
            child: ElevatedButton(
              onPressed: _isButtonDisabled ? null : () => playLoopedMusic(),
              style: ElevatedButton.styleFrom(minimumSize: const Size(200, 50)),
              child: Text(
                AppLocalizations.of(context)!.taspeh_auto,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xff3949AB),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void playLoopedMusic() {
    _timer?.cancel();

    if (_countNumberController.text.isEmpty) {
      showSnackBar(
          context: context, error: true, message: 'قم بإدخال عدد مرات التكرار');
    } else {
      setState(() {
        _isButtonDisabled = true; // تعطيل الزر
      });

      _counter = int.parse(_countNumberController.text);
      totalCount = _counter; // تعيين العدد الإجمالي

      if (_counter > 0) {
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
          if (_counter > 0 &&
              (_audioCompletion == null || _audioCompletion!.isCompleted)) {
            try {
              setState(() {
                print(widget.list.audioUrl);
                print('Counter-> $_counter');
                _counter--;
                _countNumberController.text = _counter.toString();
              });
              _audioCompletion = Completer<void>();
              if (widget.list.audioUrl!.startsWith('file')) {
                await _instance
                    .setPlaybackRate(_selectedSpeed); // استخدم _selectedSpeed
                await _instance.play(AssetSource(widget.list.audioUrl!));
              } else {
                await _instance.setPlaybackRate(_selectedSpeed);
                await _instance.play(DeviceFileSource(widget.list.audioUrl!));
              }
              _instance.onPlayerComplete.listen((event) {
                _audioCompletion!.complete();
              });
              await _audioCompletion!.future;
            } catch (e) {
              print('Error playing audio: $e');
            }
          } else if (_counter <= 0) {
            setState(() {
              _isButtonDisabled = false; // إعادة تفعيل الزر بعد انتهاء التكرار
            });
          } else if (_counter < 0) {
            timer.cancel();
            _instance.stop();
            print('Loop Finished');
          }
        });
      } else {
        _instance.stop();
        setState(() {
          _isButtonDisabled =
              false; // إعادة تفعيل الزر إذا كان العدد المدخل غير صحيح
        });
        showSnackBar(
          context: context,
          error: true,
          message: 'قم بإدخال عدد مرات التكرار',
        );
      }
    }
  }

  void playMusic() async {
    try {
      if (_countNumberController.text.isEmpty) {
        showSnackBar(
          context: context,
          error: true,
          message: 'قم بإدخال عدد مرات التكرار',
        );
      } else {
        setState(() {
          _isButtonDisabled = true; // تعطيل الزر عند بدء التشغيل
        });

        _counter = int.parse(_countNumberController.text);
        totalCount = _counter;
        if (_counter > 0) {
          setState(() {
            print(widget.list.audioUrl);
            print('Counter-> $_counter');
            _counter--;
            _countNumberController.text = _counter.toString();
          });

          if (widget.list.audioUrl!.startsWith('file')) {
            await _instance
                .setPlaybackRate(_selectedSpeed); // استخدم _selectedSpeed
            await _instance.play(AssetSource(widget.list.audioUrl!));
          } else {
            await _instance.setPlaybackRate(_selectedSpeed);
            await _instance.play(DeviceFileSource(widget.list.audioUrl!));
          }

          // انتظر حتى ينتهي الصوت
          await _instance.onPlayerComplete.first;

          setState(() {
            _isButtonDisabled = false; // إعادة تمكين الزر بعد انتهاء التشغيل
          });
        } else {
          showSnackBar(
            context: context,
            error: true,
            message: 'قم بإدخال عدد مرات التكرار',
          );
          setState(() {
            _isButtonDisabled = false; // إعادة تمكين الزر حتى في حالة الخطأ
          });
          return;
        }
      }
    } catch (e) {
      print('Error playing audio: $e');
      setState(() {
        _isButtonDisabled = false; // إعادة تمكين الزر في حالة حدوث خطأ
      });
    }
  }

  double getProgress() {
    return _counter / totalCount;
  }
}
