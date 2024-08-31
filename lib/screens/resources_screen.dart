import 'package:bac_helper_sc/provider/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourcesScreen extends StatelessWidget {
  final List<ResourceLink> resourceLinks = [
    // youtube channels ( teachers )
    ResourceLink(
      name: 'كتفي شريف زينة',
      subtitle: 'أستاذة علوم',
      icon: FontAwesomeIcons.youtube,
      url: 'https://www.youtube.com/@prof-ketfi.cherif-zina',
      type: ResourceType.youtube,
    ),
    ResourceLink(
      name: 'الأستاذ شاوش',
      subtitle: 'علوم',
      icon: FontAwesomeIcons.youtube,
      url: 'https://www.youtube.com/@Profchaouch',
      type: ResourceType.youtube,
    ),
    ResourceLink(
      name: 'الأستاذ نور الدين',
      subtitle: 'رياضيات',
      icon: FontAwesomeIcons.youtube,
      url: 'https://www.youtube.com/@noureddine2013',
      type: ResourceType.youtube,
    ),
    ResourceLink(
      name: 'الأستاذ عبد الباسط',
      subtitle: 'رياضيات',
      icon: FontAwesomeIcons.youtube,
      url: 'https://www.youtube.com/@user-ip1qr8yu7u',
      type: ResourceType.youtube,
    ),
    ResourceLink(
      name: 'الدكتور السكي داود',
      subtitle: 'رياضيات',
      icon: FontAwesomeIcons.youtube,
      url: 'https://www.youtube.com/@dr.sekkidaoud497',
      type: ResourceType.youtube,
    ),
    ResourceLink(
      name: 'محمد الأمين زدون',
      subtitle: 'أستاذ فيزياء',
      icon: FontAwesomeIcons.youtube,
      url: 'https://www.youtube.com/@amine.zeddoun',
      type: ResourceType.youtube,
    ),
    ResourceLink(
      name: 'سيد أحمد شعلال',
      subtitle: 'أستاذ فيزياء',
      icon: FontAwesomeIcons.youtube,
      url: 'https://www.youtube.com/@sidahmedchaallel8246',
      type: ResourceType.youtube,
    ),
    ResourceLink(
      name: 'الاستاذ حيقون أسامة',
      subtitle: 'أدب عربي',
      icon: FontAwesomeIcons.youtube,
      url: 'https://www.youtube.com/@prof_haigoune',
      type: ResourceType.youtube,
    ),
    ResourceLink(
      name: 'الأستاذ خالد حماش',
      subtitle: 'أدب عربي',
      icon: FontAwesomeIcons.youtube,
      url: 'https://www.youtube.com/@coursdz19',
      type: ResourceType.youtube,
    ),
    ResourceLink(
      name: 'الأستاذة بوسعادي',
      subtitle: 'العلوم الاسلامية',
      icon: FontAwesomeIcons.youtube,
      url: 'https://www.youtube.com/@BOUSSAADI',
      type: ResourceType.youtube,
    ),
    ResourceLink(
      name: 'الأستاذ شمس الدين',
      subtitle: 'العلوم الاسلامية',
      icon: FontAwesomeIcons.youtube,
      url: 'https://www.youtube.com/@dr_chms2540',
      type: ResourceType.youtube,
    ),
    ResourceLink(
      name: 'الأستاذ بورنان',
      subtitle: 'اجتماعيات',
      icon: FontAwesomeIcons.youtube,
      url: 'https://www.youtube.com/@user-oh8ql5et5c',
      type: ResourceType.youtube,
    ),
    ResourceLink(
      name: 'الأستاذ منصوري',
      subtitle: 'فرنسية و انجليزية',
      icon: FontAwesomeIcons.youtube,
      url: 'https://www.youtube.com/@NACERDOCTOR',
      type: ResourceType.youtube,
    ),
    ResourceLink(
      name: 'الأستاذ عادل مقرود',
      subtitle: 'الفلسفة',
      icon: FontAwesomeIcons.youtube,
      url: 'https://www.youtube.com/@user-iy7yg1hw9x',
      type: ResourceType.youtube,
    ),

    // useful facebook pages
    ResourceLink(
      name: 'عقبة بن نافع',
      subtitle: 'موسوعة البكالوريا',
      icon: Icons.facebook,
      url: 'https://www.facebook.com/okba.bac.2010',
      type: ResourceType.socialMedia,
    ),
    ResourceLink(
      name: 'صفحةcours dz ',
      subtitle: 'بكالوريا',
      icon: Icons.facebook,
      url: 'https://www.facebook.com/coursdz2023',
      type: ResourceType.socialMedia,
    ),

    // useful instagram pages
    ResourceLink(
      name: 'حبيبة لحريزي',
      subtitle: 'متوفقة في البكالوريا',
      icon: FontAwesomeIcons.instagram,
      url: 'https://www.instagram.com/habiba_lehrizi/',
      type: ResourceType.socialMedia,
    ),
    ResourceLink(
      name: 'bac_dz',
      subtitle:'بكالوريا',
      icon: FontAwesomeIcons.instagram,
      url: 'https://www.instagram.com/bac_dz/',
      type: ResourceType.socialMedia,
    ),

    ResourceLink(
      name: 'الحقيبة الألماسية',
      subtitle: 'عقبة بن نافع',
      icon: FontAwesomeIcons.googleDrive,
      url: 'https://drive.google.com/drive/folders/1-BuOEEEc-Wf0b28aXdNnpMZyGj5IHGYv?usp=drive_link',
      type: ResourceType.drive,
    ),
    ResourceLink(
      name: 'ملخصات',
      subtitle: 'حبيبة لحريزي',
      icon: FontAwesomeIcons.googleDrive,
      url: 'https://drive.google.com/drive/folders/1_0YFh8gSjaNnUrgo6dhykq98sEpMmgYw',
      type: ResourceType.drive,
    ),
  ];

  ResourcesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool dark = Provider.of<ThemeNotifier>(context).isDarkMode;
    return DefaultTabController(
      length: ResourceType.values.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('مصادر'),
          bottom: TabBar(
            tabs: ResourceType.values
                .map((type) => Tab(icon: Icon(getIconData(type))))
                .toList(),
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 2.0, color: dark ? Colors.white : Colors.deepPurple),
            ),
            labelColor: dark ? Colors.white : Colors.deepPurple,
            indicatorColor: Colors.redAccent,
            unselectedLabelColor: dark ? Colors.white.withOpacity(0.5) : Colors.grey[400],
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ),
        body: TabBarView(
          children: ResourceType.values
              .map((type) => _buildResourceList(type))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildResourceList(ResourceType type) {
    final filteredLinks =
        resourceLinks.where((link) => link.type == type).toList();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView.builder(
        itemCount: filteredLinks.length,
        itemBuilder: (context, index) {
          final link = filteredLinks[index];
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: ListTile(
              leading: Icon(link.icon, color: _getColor(link.type)),
              title: Text(link.name),
              subtitle: Text(link.subtitle),
              trailing:
                  Icon(Icons.arrow_forward_ios, color: _getColor(link.type)),
              onTap: () => _openLink(link.url),
            ),
          );
        },
      ),
    );
  }

  Color _getColor(ResourceType type) {
    switch (type) {
      case ResourceType.youtube:
        return Colors.redAccent;
      case ResourceType.socialMedia:
        return Colors.blue;
      case ResourceType.drive:
        return Colors.green;
    }
  }

  IconData getIconData(ResourceType type) {
    switch (type) {
      case ResourceType.youtube:
        return FontAwesomeIcons.youtube;
      case ResourceType.socialMedia:
        return Icons.person_add_alt_rounded;
      case ResourceType.drive:
        return FontAwesomeIcons.googleDrive;
    }
  }

  void _openLink(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      print('Could not launch $url');
    }
  }
}

class ResourceLink {
  final String name;
  final String subtitle;
  final IconData icon;
  final String url;
  final ResourceType type;

  ResourceLink(
      {required this.name,
      required this.subtitle,
      required this.icon,
      required this.url,
      required this.type});
}

enum ResourceType { youtube, socialMedia, drive }
