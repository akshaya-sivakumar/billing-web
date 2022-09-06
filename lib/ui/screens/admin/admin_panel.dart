import 'package:billing_web/ui/screens/admin/branches.dart';
import 'package:billing_web/ui/screens/admin/new_item_create.dart';
import 'package:billing_web/ui/screens/admin/sidedishes.dart';
import 'package:billing_web/ui/screens/admin/users.dart';
import 'package:billing_web/ui/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPanel extends StatefulWidget {
  static String routeName = '/adminPanel';

  const AdminPanel({Key? key}) : super(key: key);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      index: 0,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Admin Panel",
          style: GoogleFonts.akayaKanadaka(fontSize: 30),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  adminCard(context, "Users",
                      "https://mycarr.in/wp-content/uploads/2021/10/33308-1.png",
                      () {
                    Navigator.of(context).pushNamed(Users.routeName);
                  }),
                  adminCard(context, "Branches", "assets/images/branch.png",
                      () {
                    Navigator.of(context).pushNamed(Branches.routeName);
                  }),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  adminCard(context, "Menu", "assets/images/menu.png", () {
                    Navigator.of(context)
                        .pushNamed(NewItemCreatePage.routeName);
                  }),
                  adminCard(context, "Side dish", "assets/images/sidedish.png",
                      () {
                    Navigator.of(context).pushNamed(SideDishes.routeName);
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector adminCard(
      BuildContext context, String title, url, Function() onchange) {
    return GestureDetector(
      onTap: onchange,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 5,
        child: Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            width: MediaQuery.of(context).size.width / 4.5,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: 0.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      "https://devexperts.com/blog/wp-content/uploads/2012/11/Post-inner-banner-2336x1314-1-1752x986.png",
                      fit: BoxFit.fitWidth,
                      width: MediaQuery.of(context).size.width / 2 - 30,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          url,
                          color: Colors.white,
                          height: title == "Side dish" ? 80 : 50,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          title,
                          style: GoogleFonts.adamina(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
