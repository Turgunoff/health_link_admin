import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

void main() {
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
      ),
      // home: const MainApp(),
      initialRoute: '/', // Boshlang'ich route
      routes: {
        '/': (context) => MainApp(),
        '/second': (context) => Second(),
        // '/bemorlar': (context) => BemorlarEkrani(),
        // ... va hokazo, qolgan ekranlar uchun ham shunga o'xshash
      },
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueGrey, Colors.blueGrey.withOpacity(0.2)],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 0.5,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.0,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              /// SHIFOKOR MA'LUMOTLARI
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          AssetImage('assets/images/doctor_photo.jpg'),
                      // Shifokor rasmi
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Dr. To\'liq Ism',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Ixtisoslik',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              /// MENYU ELEMENTLARI
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.home, size: 20),
                title: const Text(
                  'Bosh sahifa',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  _advancedDrawerController.hideDrawer();
                  // _advancedDrawerController.hideDrawer(); // Drawerni yopish
                  Navigator.pushNamed(context, '/second');
                },
                leading: const Icon(Icons.calendar_today, size: 20),
                title: const Text(
                  'Qabul jadvali',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.people),
                title: const Text('Bemorlar'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.message),
                title: const Text('Xabarlar'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.payment),
                title: const Text('To\'lovlar'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.bar_chart),
                title: const Text('Statistika'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.medical_services),
                title: const Text('Tibbiy ma\'lumotlar'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.settings),
                title: const Text('Sozlamalar'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.help),
                title: const Text('Yordam'),
              ),
              const Spacer(), // Bo'sh joyni to'ldirish uchun

              /// PASTKI QISM
              Divider(
                height: 1.0,
                color: Colors.white70,
              ),
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: Column(
                    children: [
                      const Text('Ilova versiyasi 1.0.0'),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Foydalanish shartlari'),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Maxfiylik siyosati'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Advanced Drawer Example'),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
        ),
        body: Container(
          child: Text('Home'),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  final _advancedDrawerController = AdvancedDrawerController();
  @override
  void initState() {
    super.initState();
    // Agar drawer yopiq bo'lsa, uni ochish
    if (!_advancedDrawerController.value.visible) {
      _advancedDrawerController.showDrawer();
    }
  }

  @override
  void dispose() {
    // Bu yerda drawerni yopish shart emas, chunki u ochiq qolishi kerak
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second'),
      ),
      body: Center(
        child: Text('Second Page'),
      ),
    );
  }
}
