import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:health_link_admin/model/menu_item.dart';
import 'package:iconsax/iconsax.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainApp(),

      // initialRoute: '/', // Boshlang'ich route
      // routes: {
      //   '/': (context) => MainApp(),
      //   '/second': (context) => Second(),
      //   // '/bemorlar': (context) => BemorlarEkrani(),
      //   // ... va hokazo, qolgan ekranlar uchun ham shunga o'xshash
      // },
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final ZoomDrawerController _zoomDrawerController = ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: _zoomDrawerController,
      style: DrawerStyle.defaultStyle,
      menuScreen: MenuPage(),
      mainScreen: HomeScreen(zoomDrawerController: _zoomDrawerController),
      menuBackgroundColor: Colors.indigo,
    );
  }
}

class MenuItems {
  static const home = MenuItem('Home', Iconsax.home);
  static const profile = MenuItem('Profile', Iconsax.profile);
  static const appointments = MenuItem('Appointments', Iconsax.calendar_1);
  static const patients = MenuItem('Patients', Iconsax.people);
  static const messages = MenuItem('Messages', Iconsax.message);
  static const payments = MenuItem('Payments', Iconsax.wallet_3);
  static const statistics = MenuItem('Statistics', Iconsax.chart_2);
  static const medicalRecords =
      MenuItem('Medical Records', Iconsax.document_text);
  static const settings = MenuItem('Settings', Iconsax.setting_2);
  static const helpAndSupport = MenuItem('Help & Support', Iconsax.info_circle);
  static const logout = MenuItem('Logout', Iconsax.logout);

  static const all = <MenuItem>[
    home,
    profile,
    appointments,
    patients,
    messages,
    payments,
    statistics,
    medicalRecords,
    settings,
    helpAndSupport,
    logout,
  ];
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: MenuItems.all.map((menuItem) {
            return ListTile(
              leading: Icon(menuItem.icon),
              title: Text(menuItem.title),
              onTap: () {
                // TODO: Implement navigation to the selected screen
                // Navigator.push(context, MaterialPageRoute(builder: (context) => Second()));
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final ZoomDrawerController zoomDrawerController; // Add this line
  const HomeScreen({super.key, required this.zoomDrawerController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Home'),
        leading: IconButton(
          onPressed: () => ZoomDrawer.of(context)!.toggle(),
          icon: Icon(Iconsax.category),
        ),
      ),
    );
  }
}
