import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_link_admin/data/models/menu_item.dart';
import 'package:health_link_admin/data/models/user_model.dart';
import 'package:health_link_admin/presentation/screens/appointments/appointments_screen.dart';
import 'package:health_link_admin/presentation/screens/auth/sign_in_screen.dart';
import 'package:health_link_admin/presentation/screens/help/help_screen.dart';
import 'package:health_link_admin/presentation/screens/home/home_screen.dart';
import 'package:health_link_admin/presentation/screens/medicalRecords/medical_records_screen.dart';
import 'package:health_link_admin/presentation/screens/messages/messages_screen.dart';
import 'package:health_link_admin/presentation/screens/patients/patients_screen.dart';
import 'package:health_link_admin/presentation/screens/payments/payments_screen.dart';
import 'package:health_link_admin/presentation/screens/profile/profile_screen.dart';
import 'package:health_link_admin/presentation/screens/settings/settings_screen.dart';
import 'package:health_link_admin/presentation/screens/statistics/statistics_screen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/header_drawer.dart';
import 'widgets/theme_widget.dart';

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

  Future<void> _logout(BuildContext context) async {
    // Показать диалог подтверждения
    bool confirmLogout = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Выход',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              content: Text(
                'Вы уверены, что хотите выйти?',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false), // Отмена
                  child: Text(
                    'Отмена',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(true), // Подтверждение
                  child: Text(
                    'Выйти',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.red),
                  ),
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
            ),
            onPressed: () {
              Scaffold.of(context)
                  .openDrawer(); // Endi bu yerda Scaffold topiladi
            },
          );
        }),
        title: const Text(
          "Health Link Admin",
        ),
      ),
      body: container,
      drawer: SafeArea(
        child: Drawer(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            children: [
              Column(
                children: [
                  HeaderDrawer(widget: widget),
                  Divider(
                    thickness: 1,
                    endIndent: 15,
                    indent: 15,
                    height: 1,
                  ),
                  myDrawerList(),
                ],
              ),
              const ThemeWidget()
            ],
          ),
        ),
      ),
    );
  }

  Widget myDrawerList() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
        right: 15,
        left: 15,
      ),
      // color: Colors.white,
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Dashboard", Iconsax.home,
              currentPage == DrawerSections.home ? true : false),
          menuItem(2, "Appointments", Iconsax.calendar,
              currentPage == DrawerSections.appointments ? true : false),
          menuItem(3, "Patients", Iconsax.personalcard,
              currentPage == DrawerSections.patients ? true : false),
          menuItem(4, "Messages", Iconsax.message,
              currentPage == DrawerSections.messages ? true : false),
          menuItem(5, "Payments", Iconsax.card,
              currentPage == DrawerSections.payments ? true : false),
          menuItem(6, "Statistics", Iconsax.graph,
              currentPage == DrawerSections.statistics ? true : false),
          menuItem(7, "Medical Records", Iconsax.monitor_recorder,
              currentPage == DrawerSections.medicalRecords ? true : false),
          menuItem(8, "Settings", Iconsax.setting,
              currentPage == DrawerSections.settings ? true : false),
          menuItem(9, "Profile", Iconsax.profile_circle,
              currentPage == DrawerSections.profile ? true : false),
          menuItem(10, "Help & Support", Iconsax.info_circle,
              currentPage == DrawerSections.help ? true : false),
          const Divider(), // Add a divider before logout
          menuItem(11, "Logout", Iconsax.logout_1,
              currentPage == DrawerSections.logout ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      color: selected ? Theme.of(context).primaryColor : Colors.transparent,
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
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: selected ? Colors.white : null,
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: selected ? Colors.white : null),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
