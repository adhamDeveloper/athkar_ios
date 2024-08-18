import 'dart:io';
import 'package:athkar_tasbeh_sound/widgets/data_list.dart';
import 'package:athkar_tasbeh_sound/widgets/snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import '../widgets/my_drawer.dart';
import '../widgets/my_textfields.dart';
import 'details_athkar_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with Helpers {
  late TextEditingController _searchController,
      _titleAthkarController,
      _fileAthkarController;

  List<DataList> list = [];
  List<DataList> filteredList = [];

  final _record = AudioRecorder();
  bool _isRecording = false;

  File? _selectedFile;
  bool _isFilePickerOpen = false;
  TimeOfDay? selectedTime; // متغير لتخزين الوقت المحدد

  @override
  void initState() {
    _searchController = TextEditingController();
    _fileAthkarController = TextEditingController();
    _titleAthkarController = TextEditingController();
    super.initState();
    _loadItems();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _fileAthkarController.dispose();
    _titleAthkarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3949AB),
      drawer: myDrawer(context),
      appBar: AppBar(
        title: const Text('repeat sound ©سبحة أذكار صوتيه'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          MyTextField(
            colorText: Colors.white,
            color: Colors.white,
            colorBorder: Colors.white,
            text: AppLocalizations.of(context)!.search,
            keyType: TextInputType.text,
            controller: _searchController,
            onChangedT: onSearch,
            icons: Icons.search,
            colorIcons: Colors.white,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.all(5),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsAthkarScreen(
                            list: filteredList[index],
                          ),
                        ),
                      );
                    },
                    leading: Text(
                      '${index + 1}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    title: Text(
                      filteredList[index].name!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.orange,
                      ),
                      onPressed: () {
                        _updateListAthkar(index, context);
                      },
                    ),
                    // subtitle: Text(
                    //   'Time is : $selectedTime',
                    //   textAlign: TextAlign.center,
                    // ),
                  ),
                );
              },
            ),
          )
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addListAthkar(context);
        },
        backgroundColor: Colors.orange,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
  }

  // Function List Sound

  void _loadItems() async {
    final items = await DataList.loadItems();
    setState(() {
      list = items;
      filteredList = items;
    });
  }

  void addItem(DataList item) async {
    await DataList.addItem(item);
    _loadItems();
  }

  void updateItem(int index, DataList newItem) async {
    await DataList.updateItem(index, newItem);
    _loadItems();
  }

  void deleteItem(int index) async {
    await DataList.deleteItem(index);
    _loadItems();
  }

  void onSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredList = list; // إعادة جميع العناصر إذا كان حقل البحث فارغًا
      });
      return;
    }

    var searchResults = list.where((athkar) {
      final title = athkar.name!.toLowerCase();
      final input = query.toLowerCase();
      return title.contains(input);
    }).toList();

    setState(() {
      filteredList = searchResults; // تحديث القائمة المفلترة
    });
  }

  Future<void> _addListAthkar(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 400, // زيادة الحجم للسماح بعرض الحقول الجديدة
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: const Color(0xff3949AB),
                  child: Image.asset('assets/images/logo.png'),
                ),
                MyTextField(
                  colorText: Colors.black,
                  text: AppLocalizations.of(context)!.title_textfiled,
                  icons: Icons.title,
                  color: Colors.black,
                  colorIcons: const Color(0xff3949AB),
                  colorBorder: const Color(0xff3949AB),
                  keyType: TextInputType.text,
                  controller: _titleAthkarController,
                ),
                MyTextField(
                  colorText: Colors.black,
                  icons: Icons.music_video,
                  text: AppLocalizations.of(context)!.file_textfiled,
                  color: Colors.black,
                  colorIcons: const Color(0xff3949AB),
                  colorBorder: const Color(0xff3949AB),
                  keyType: TextInputType.text,
                  controller: _fileAthkarController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StatefulBuilder(
                      builder: (context, setState) {
                        return IconButton(
                          iconSize: 30,
                          style: IconButton.styleFrom(
                            backgroundColor:
                                _isRecording ? Colors.red : Colors.orange,
                            minimumSize: const Size(50, 50),
                          ),
                          onPressed: () async {
                            if (_isRecording) {
                              await _stopRecording();
                              setState(() {
                                _isRecording = false;
                              });
                            } else {
                              setState(() {
                                _isRecording = true;
                              });
                              await _startRecording();
                            }
                          },
                          icon: Icon(
                            _isRecording ? Icons.stop : Icons.mic_rounded,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      iconSize: 30,
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.orange,
                        minimumSize: const Size(50, 50),
                      ),
                      onPressed: () {
                        _pickFile();
                      },
                      icon: const Icon(
                        Icons.audio_file,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_fileAthkarController.text.isNotEmpty &&
                              _titleAthkarController.text.isNotEmpty) {
                            // التأكد من اختيار الوقت
                            DataList newItem = DataList(
                              name: _titleAthkarController.text,
                              audioUrl: _fileAthkarController.text,
                              // alarmTime: selectedTime!, // حفظ الوقت المحدد
                            );
                            addItem(newItem);
                            _titleAthkarController.clear();
                            _fileAthkarController.clear();
                            Navigator.pop(context);
                          } else {
                            showSnackBar(
                                context: context,
                                error: true,
                                message:AppLocalizations.of(context)!.message
                                );
                            return;
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff3949AB),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.add,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          _titleAthkarController.clear();
                          _fileAthkarController.clear();
                          await _stopRecording();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.arrow,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _updateListAthkar(int index, BuildContext context) async {
    final athkarItem = filteredList[index];

    _titleAthkarController.text = athkarItem.name!;
    _fileAthkarController.text = athkarItem.audioUrl!;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 400,
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: const Color(0xff3949AB),
                  child: Image.asset('assets/images/logo.png'),
                ),
                MyTextField(
                  colorText: Colors.black,
                  text: athkarItem.name!,
                  icons: Icons.title,
                  color: Colors.black,
                  colorIcons: const Color(0xff3949AB),
                  colorBorder: const Color(0xff3949AB),
                  keyType: TextInputType.text,
                  controller: _titleAthkarController,
                ),
                const SizedBox(height: 5),
                MyTextField(
                  colorText: Colors.black,
                  icons: Icons.music_video,
                  text: athkarItem.audioUrl!,
                  color: Colors.black,
                  colorIcons: const Color(0xff3949AB),
                  colorBorder: const Color(0xff3949AB),
                  keyType: TextInputType.text,
                  controller: _fileAthkarController,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StatefulBuilder(
                      builder: (context, setState) {
                        return IconButton(
                          iconSize: 30,
                          style: IconButton.styleFrom(
                            backgroundColor:
                                _isRecording ? Colors.red : Colors.orange,
                            minimumSize: const Size(50, 50),
                          ),
                          onPressed: () async {
                            if (_isRecording) {
                              await _stopRecording();
                              setState(() {
                                _isRecording = false;
                              });
                            } else {
                              setState(() {
                                _isRecording = true;
                              });
                              await _startRecording();
                            }
                          },
                          icon: Icon(
                            _isRecording ? Icons.stop : Icons.mic_rounded,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      iconSize: 30,
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.orange,
                        minimumSize: const Size(50, 50),
                      ),
                      onPressed: () {
                        _pickFile();
                      },
                      icon: const Icon(
                        Icons.audio_file,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          deleteItem(index);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.delete,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          DataList updatedItem = DataList(
                            name: _titleAthkarController.text,
                            audioUrl: _fileAthkarController.text,
                          );
                          updateItem(index, updatedItem);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff3949AB),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.update,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _titleAthkarController.clear();
                    _fileAthkarController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.arrow,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

// Function permissions file sound and records

  Future<void> _pickFile() async {
    if (_isFilePickerOpen)
      return; // If a file picker is already open, return immediately

    setState(() {
      _isFilePickerOpen =
          true; // Set the flag to indicate a file picker is open
    });

    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);

    setState(() {
      _isFilePickerOpen = false; // Reset the flag when file picker is closed
    });

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _fileAthkarController.text =
            _selectedFile!.path; // تحديث حقل النص بمسار الملف
      });
    }
  }

  Future<void> _startRecording() async {
    if (await _record.hasPermission()) {
      try {
        final directory = await getApplicationDocumentsDirectory();
        final path = '${directory.path}/audio_recording.m4a';
        await _record.start(
          const RecordConfig(
            encoder: AudioEncoder.flac,
            bitRate: 128000,
            sampleRate: 44100,
          ),
          path: path,
        );
        setState(() {
          _isRecording = true;
        });
        print("Recording started at: $path");
      } catch (e) {
        print("Error starting recording: $e");
      }
    } else {
      print("Microphone permission denied");
    }
  }

  Future<void> _stopRecording() async {
    try {
      String? path = await _record.stop();
      if (path != null) {
        setState(() {
          _isRecording = false;
          _fileAthkarController.text = path;
        });
        print("Recording saved at: $path");
      }
    } catch (e) {
      print("Error stopping recording: $e");
    }
  }
}
