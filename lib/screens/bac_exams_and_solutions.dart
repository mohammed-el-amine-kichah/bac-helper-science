import 'package:bac_helper_sc/provider/dark_mode.dart';
import 'package:bac_helper_sc/screens/pdf_download_and_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BacExamsAndSolutions extends StatefulWidget {
  const BacExamsAndSolutions({super.key});

  @override
  State<BacExamsAndSolutions> createState() => _BacExamsAndSolutionsState();
}

class _BacExamsAndSolutionsState extends State<BacExamsAndSolutions>
    with SingleTickerProviderStateMixin {
  final Map<int, List<Subject>> subjectsByYear = {};
  late TabController _tabController;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    _tabController.addListener(() {
      setState(() {});
    });
    initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    await fetchSubjects();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> fetchSubjects() async {
    for (int year = 2024; year >= 2008; year--) {
      subjectsByYear[year] = [
        Subject(name: 'علوم الطبيعة و الحياة', exam: '-sciences-se'),
        Subject(name: 'الرياضيات', exam: '-math-se'),
        Subject(name: 'العلوم الفيزيائية', exam: '-physics-se'),
        Subject(name: 'اللغة العربية', exam: '-arabic-sci'),
        Subject(name: 'الفلسفة', exam: '-philo-sem'),
        Subject(name: 'الإجتماعيات', exam: '-hisgeo-semtm'),
        Subject(name: 'العلوم الإسلامية', exam: '-islamic'),
        Subject(name: 'اللغة الفرنسية', exam: '-french-sci'),
        Subject(name: 'اللغة الانجليزية', exam: '-english-sci'),
        Subject(name: 'اللغة الأمازيغية', exam: '-tamazight'),
      ];

      for (var subject in subjectsByYear[year]!) {
        subject.examDownloaded = prefs.getBool('$year${subject.exam}_exam') ?? false;
        subject.solutionDownloaded = prefs.getBool('$year${subject.exam}_solution') ?? false;
      }
    }
    setState(() {});
  }

  Future<void> setDownloadedState(int year, String examCode, bool isCorrection, bool isDownloaded) async {
    var subjects = subjectsByYear[year];
    if (subjects != null) {
      var subject = subjects.firstWhere((s) => s.exam == examCode);
      if (isCorrection) {
        subject.solutionDownloaded = isDownloaded;
        await prefs.setBool('$year${subject.exam}_solution', isDownloaded);
      } else {
        subject.examDownloaded = isDownloaded;
        await prefs.setBool('$year${subject.exam}_exam', isDownloaded);
      }
      setState(() {});
    }
  }

  Widget buildSubjectList(bool isCorrection) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      itemCount: subjectsByYear.length,
      itemBuilder: (context, index) {
        final year = subjectsByYear.keys.elementAt(index);
        final subjects = subjectsByYear[year]!;

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              showTrailingIcon: false,
              title: Text(
                'بكالوريا $year',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              iconColor: Provider.of<ThemeNotifier>(context).isDarkMode ? Colors.white : Colors.black,
              children: subjects.map((subject) {
                bool isDownloaded = isCorrection ? subject.solutionDownloaded : subject.examDownloaded;
                return ListTile(
                  title: Text(
                    subject.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  subtitle: const Text(
                    'الموضوع 1 + 2',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      isDownloaded ? Icons.file_open_rounded : Icons.cloud_download,
                      color: isDownloaded
                          ? Colors.deepPurpleAccent
                          : Provider.of<ThemeNotifier>(context).isDarkMode
                          ? Colors.white70
                          : Colors.black87,
                    ),
                    onPressed: () {
                      String examCode = isCorrection
                          ? '$year${subject.exam}-correction'
                          : '$year${subject.exam}';
                      if (!isDownloaded) {
                        setDownloadedState(year, subject.exam, isCorrection, true);
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PdfDownloadViewer(
                            exam: examCode,
                            module: subject.name,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool dark = Provider.of<ThemeNotifier>(context).isDarkMode;
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        initialIndex: 1,
        child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              child: const Icon(Icons.arrow_back, color: Colors.white),
              onTap: () => Navigator.pop(context),
            ),
            centerTitle: true,
            backgroundColor: Colors.deepPurple,
            title: Text(
              _tabController.index == 1 ? 'المواضيع' : 'الحلول',
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
            bottom: TabBar(
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.values.first,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[400],
              controller: _tabController,
              tabs: const [
                Tab(icon: Icon(Icons.star)),
                Tab(icon: Icon(Icons.list)),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: buildSubjectList(true),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: buildSubjectList(false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Subject {
  final String name;
  bool examDownloaded;
  bool solutionDownloaded;
  final String exam;
  Subject({
    required this.name,
    this.examDownloaded = false,
    this.solutionDownloaded = false,
    required this.exam
  });
}