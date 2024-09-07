import 'package:bac_helper_sc/provider/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/download_dialog.dart';

class BacExamsAndSolutions extends StatefulWidget {
  const BacExamsAndSolutions({super.key});

  @override
  State<BacExamsAndSolutions> createState() => _BacExamsAndSolutionsState();
}

class _BacExamsAndSolutionsState extends State<BacExamsAndSolutions>
    with SingleTickerProviderStateMixin {
  final Map<int, List<Subject>> subjectsByYear = {};
  late TabController _tabController;
  //final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    // Initialize TabController
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    _tabController.addListener(() {
      setState(() {
        // No need to update _index manually, just rebuild UI
      });
    });
    fetchSubjects();
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose TabController when widget is disposed
    super.dispose();
  }

  Future<void> fetchSubjects() async {
    // Fetch subjects from Firebase Storage
    // This is a placeholder implementation
    for (int year = 2024; year >= 2008; year--) {
      subjectsByYear[year] = [
        Subject(name: 'علوم الطبيعة و الحياة', downloaded: false),
        Subject(name: 'الرياضيات', downloaded: false),
        Subject(name: 'العلوم الفيزيائية', downloaded: false),
        Subject(name: 'اللغة العربية', downloaded: false),
        Subject(name: 'الفلسفة', downloaded: false),
        Subject(name: 'الإجتماعيات', downloaded: false),
        Subject(name: 'العلوم الإسلامية', downloaded: false),
        Subject(name: 'اللغة الفرنسية', downloaded: false),
        Subject(name: 'اللغة الانجليزية', downloaded: false),
        Subject(name: 'اللغة الأمازيغية', downloaded: false),
      ];
    }
    setState(() {});
  }

  Future<void> downloadSubject(int year, Subject subject) async {
    // Implement download logic here
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const MyDownloadDialog();
      },
    );
    // For now, we'll just toggle the downloaded state
    setState(() {
      subject.downloaded = true;
    });
  }

  void openSubject(int year, Subject subject) {
    // Implement open logic here
    print('Opening ${subject.name} for year $year');
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
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.pop(context);
                }),
            centerTitle: true,
            backgroundColor: Colors.deepPurple,
            title: Text(
              _tabController.index == 1 ? 'المواضيع' : 'الحلول',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            bottom: TabBar(
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.values.first,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[400],
              controller: _tabController,
              tabs: [
                Tab(
                    icon: Icon(
                  Icons.star,
                )),
                Tab(
                    icon: Icon(
                  Icons.list,
                )),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 16), // Adds padding around the ListView
                        itemCount: subjectsByYear.length,
                        itemBuilder: (context, index) {
                          final year = subjectsByYear.keys.elementAt(index);
                          final subjects = subjectsByYear[year]!;

                          return Card(
                            // Wrap each ExpansionTile in a Card for elevation effect
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0), // Adds space between cards
                            elevation: 2, // Adds shadow to the card
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Rounded corners for the card
                            ),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                showTrailingIcon: false,
                                title: Text(
                                  'بكالوريا $year',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                iconColor: dark
                                    ? Colors.white
                                    : Colors
                                        .black, // Changes the icon color of ExpansionTile
                                // collapsedIconColor: Colors.deepPurple, // Changes the icon color when collapsed
                                children: subjects.map((subject) {
                                  return ListTile(
                                    title: Text(
                                      subject.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    subtitle: const Text(
                                      'الموضوع 1 + 2',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors
                                            .grey, // Changes subtitle text color
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(
                                        subject.downloaded
                                            ? Icons.file_open_rounded
                                            : Icons.cloud_download,
                                        color: subject.downloaded
                                            ? Colors.deepPurpleAccent
                                            : dark
                                                ? Colors.white70
                                                : Colors
                                                    .black87, // Changes icon color based on downloaded state
                                      ),
                                      onPressed: () {
                                        if (subject.downloaded) {
                                          openSubject(year, subject);
                                        } else {
                                          downloadSubject(year, subject);
                                        }
                                      },
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 16), // Adds padding around the ListView
                        itemCount: subjectsByYear.length,
                        itemBuilder: (context, index) {
                          final year = subjectsByYear.keys.elementAt(index);
                          final subjects = subjectsByYear[year]!;

                          return Card(
                            // Wrap each ExpansionTile in a Card for elevation effect
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0), // Adds space between cards
                            elevation: 2, // Adds shadow to the card
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Rounded corners for the card
                            ),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                showTrailingIcon: false,
                                title: Text(
                                  'بكالوريا $year',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                iconColor: dark
                                    ? Colors.white
                                    : Colors
                                        .black, // Changes the icon color of ExpansionTile
                                // collapsedIconColor: Colors.deepPurple, // Changes the icon color when collapsed
                                children: subjects.map((subject) {
                                  return ListTile(
                                    title: Text(
                                      subject.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    subtitle: const Text(
                                      'الموضوع 1 + 2',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors
                                            .grey, // Changes subtitle text color
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(
                                        subject.downloaded
                                            ? Icons.file_open_rounded
                                            : Icons.cloud_download,
                                        color: subject.downloaded
                                            ? Colors.deepPurpleAccent
                                            : dark
                                            ? Colors.white70
                                            : Colors
                                            .black87, // Changes icon color based on downloaded state
                                      ),
                                      onPressed: () {
                                        if (subject.downloaded) {
                                          openSubject(year, subject);
                                        } else {
                                          downloadSubject(year, subject);
                                        }
                                      },
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
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
  bool downloaded;

  Subject({required this.name, this.downloaded = false});
}
