import 'package:flutter/material.dart';
import 'package:health_link_admin/model/menu_item.dart';
import 'package:health_link_admin/model/user_model.dart';
import 'package:health_link_admin/screens/appointments/appointments_screen.dart';
import 'package:health_link_admin/screens/auth/sign_in_screen.dart';
import 'package:health_link_admin/screens/help/help_screen.dart';
import 'package:health_link_admin/screens/home/home_screen.dart';
import 'package:health_link_admin/screens/medicalRecords/medical_records_screen.dart';
import 'package:health_link_admin/screens/messages/messages_screen.dart';
import 'package:health_link_admin/screens/patients/patients_screen.dart';
import 'package:health_link_admin/screens/payments/payments_screen.dart';
import 'package:health_link_admin/screens/profile/profile_screen.dart';
import 'package:health_link_admin/screens/settings/settings_screen.dart';
import 'package:health_link_admin/screens/statistics/statistics_screen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainApp extends StatefulWidget {
  final UserModel? user; // user obyektini qabul qilish
  final String? token; // Tokenni qabul qilish
  const MainApp({super.key, this.user, this.token});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var currentPage = DrawerSections.home;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var container;

    if (currentPage == DrawerSections.home) {
      container = const HomeScreen();
    } else if (currentPage == DrawerSections.appointments) {
      container = const AppointmentsScreen();
    } else if (currentPage == DrawerSections.patients) {
      container = const PatientsScreen();
    } else if (currentPage == DrawerSections.messages) {
      container = const MessagesScreen();
    } else if (currentPage == DrawerSections.payments) {
      container = const PaymentsScreen();
    } else if (currentPage == DrawerSections.statistics) {
      container = const StatisticsScreen();
    } else if (currentPage == DrawerSections.medicalRecords) {
      container = const MedicalRecordsScreen();
    } else if (currentPage == DrawerSections.settings) {
      container = const SettingsScreen();
    } else if (currentPage == DrawerSections.profile) {
      container = const ProfileScreen();
    } else if (currentPage == DrawerSections.help) {
      container = const HelpScreen();
    }

    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Iconsax.category,
              color: Colors.white,
            ),
            onPressed: () {
              Scaffold.of(context)
                  .openDrawer(); // Endi bu yerda Scaffold topiladi
            },
          );
        }),
        backgroundColor: const Color(0xFF0165FC),
        title: const Text(
          "Health Link Admin",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              myHeaderDrawer(),
              myDrawerList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget myHeaderDrawer() {
    return Container(
      color: const Color(0xFF0165FC),
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/logo.png'),
              ),
            ),
          ),
          Text(
            widget.user != null ? widget.user!.firstName : 'Guest',
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            widget.user != null ? widget.user!.email : 'Guest', // Null check,
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget myDrawerList() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Dashboard", Icons.dashboard_outlined,
              currentPage == DrawerSections.home ? true : false),
          menuItem(2, "Appointments", Icons.calendar_today_outlined,
              currentPage == DrawerSections.appointments ? true : false),
          menuItem(3, "Patients", Icons.people_alt_outlined,
              currentPage == DrawerSections.patients ? true : false),
          menuItem(4, "Messages", Icons.message_outlined,
              currentPage == DrawerSections.messages ? true : false),
          menuItem(5, "Payments", Icons.payment_outlined,
              currentPage == DrawerSections.payments ? true : false),
          menuItem(6, "Statistics", Icons.bar_chart_outlined,
              currentPage == DrawerSections.statistics ? true : false),
          menuItem(7, "Medical Records", Icons.medical_services_outlined,
              currentPage == DrawerSections.medicalRecords ? true : false),
          menuItem(8, "Settings", Icons.settings_outlined,
              currentPage == DrawerSections.settings ? true : false),
          menuItem(9, "Profile", Icons.person_outline,
              currentPage == DrawerSections.profile ? true : false),
          menuItem(10, "Help & Support", Icons.help_outline,
              currentPage == DrawerSections.help ? true : false),
          const Divider(), // Add a divider before logout
          menuItem(11, "Logout", Icons.logout,
              currentPage == DrawerSections.logout ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? const Color(0xFFDBEAFE) : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.home;
            } else if (id == 2) {
              currentPage = DrawerSections.appointments;
            } else if (id == 3) {
              currentPage = DrawerSections.patients;
            } else if (id == 4) {
              currentPage = DrawerSections.messages;
            } else if (id == 5) {
              currentPage = DrawerSections.payments;
            } else if (id == 6) {
              currentPage = DrawerSections.statistics;
            } else if (id == 7) {
              currentPage = DrawerSections.medicalRecords;
            } else if (id == 8) {
              currentPage = DrawerSections.settings;
            } else if (id == 9) {
              currentPage = DrawerSections.profile;
            } else if (id == 10) {
              currentPage = DrawerSections.help;
            } else if (id == 11) {
              _logout(context);
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    // Показать диалог подтверждения
    bool confirmLogout = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Выход'),
              content: const Text('Вы уверены, что хотите выйти?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false), // Отмена
                  child: const Text('Отмена'),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(true), // Подтверждение
                  child: const Text('Выйти'),
                ),
              ],
            );
          },
        ) ??
        false; // Если диалог закрыт без выбора, считаем, что выход отменен

    if (confirmLogout) {
      // Если пользователь подтвердил выход
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
        (route) => false,
      );
    }
  }
}

enum DrawerSections {
  home,
  appointments,
  patients,
  messages,
  payments,
  statistics,
  medicalRecords,
  settings,
  profile,
  help,
  logout,
}

class MenuItems {
  static const home = MenuItem('Dashboard', Iconsax.home);
  static const appointments = MenuItem('Appointments', Iconsax.calendar);
  static const patients = MenuItem('Patients', Iconsax.people);
  static const messages = MenuItem('Messages', Iconsax.message);
  static const payments = MenuItem('Payments', Iconsax.card);
  static const statistics = MenuItem('Statistics', Iconsax.chart);
  static const medicalRecords =
      MenuItem('Medical Records', Iconsax.search_favorite);
  static const settings = MenuItem('Settings', Iconsax.settings);
  static const profile = MenuItem('Profile', Iconsax.profile);
  static const help = MenuItem('Help & Support', Iconsax.info_circle);
  static const logout = MenuItem('Logout', Iconsax.logout);
}

// class MyHeaderDrawer extends StatefulWidget {
//   const MyHeaderDrawer({super.key});

//   @override
//   State<MyHeaderDrawer> createState() => _MyHeaderDrawerState();
// }

// class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color(0xFF0165FC),
//       width: double.infinity,
//       height: 200,
//       padding: const EdgeInsets.only(top: 20.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             margin: const EdgeInsets.only(bottom: 10),
//             height: 70,
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//               image: DecorationImage(
//                 image: AssetImage('assets/images/logo.png'),
//               ),
//             ),
//           ),
//           const Text(
//             "Rapid Tech",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//           ),
//           Text(
//             "info@rapidtech.dev",
//             style: TextStyle(
//               color: Colors.grey[200],
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
