import 'package:billing_web/ui/screens/admin/admin_panel.dart';
import 'package:billing_web/ui/screens/admin/users.dart';
import 'package:billing_web/ui/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScaffoldWidget extends StatefulWidget {
  final AppBar? appBar;
  final Widget body;
  final int index;

  const ScaffoldWidget(
      {Key? key, this.appBar, required this.body, required this.index})
      : super(key: key);

  @override
  _ScaffoldWidgetState createState() => _ScaffoldWidgetState();
}

class _ScaffoldWidgetState extends State<ScaffoldWidget> {
  int navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: Row(
        children: [
          Sidenav(widget.index, (int index) {
            print(index);
          }),
          widget.body
        ],
      ),
    );
  }
}

class Sidenav extends StatelessWidget {
  final Function setIndex;
  final int selectedIndex;

  const Sidenav(this.selectedIndex, this.setIndex);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text('Billing App',
                textAlign: TextAlign.start,
                style: GoogleFonts.adamina(
                    color: Colors.deepPurple,
                    fontSize: 21,
                    fontWeight: FontWeight.w600)),
          ),
          Divider(color: Colors.grey.shade400),
          const SizedBox(
            height: 10,
          ),
          _navItem(context, Icons.admin_panel_settings, 'Admin Panel',
              onTap: () {
            Navigator.of(context).pushNamed(AdminPanel.routeName);
          }, selected: selectedIndex == 0),
          const SizedBox(
            height: 10,
          ),
          _navItem(context, Icons.dashboard, 'Dashboard', onTap: () {
            Navigator.of(context).pushNamed(Dashboard.routeName);
          }, selected: selectedIndex == 1),
          const SizedBox(
            height: 10,
          ),
          _navItem(context, Icons.logout_rounded, 'Logout', onTap: () {
            Navigator.of(context).pushNamed("/");
          }, selected: selectedIndex == 2),
        ],
      ),
    );
  }

  _navItem(BuildContext context, IconData icon, String text,
          {Text? suffix, Function()? onTap, bool selected = false}) =>
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: selected
              ? Colors.deepPurple.withOpacity(0.2)
              : Colors.transparent,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ListTile(
          leading:
              Icon(icon, color: selected ? Colors.deepPurple : Colors.black),
          trailing: suffix,
          title: Text(
            text,
            style: GoogleFonts.adamina(
                color: selected ? Colors.deepPurple : Colors.black),
          ),
          selected: selected,
          onTap: onTap,
        ),
      );
}
