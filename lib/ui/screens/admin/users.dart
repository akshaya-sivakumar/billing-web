import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../bloc/branch_bloc/branch_bloc.dart';
import '../../../bloc/signup_bloc/signup_bloc.dart';
import '../../../main.dart';
import '../../../models/branchDetail.dart';
import '../../../models/createUser_request.dart';
import '../../../models/userDetail.dart';
import '../../widgets/loader.dart';
import '../../widgets/textformfield.dart';
import 'admin_panel.dart';

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);
  static String routeName = '/users';

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  TextEditingController userName = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late BranchBloc branchBloc;
  late SignupBloc signupBloc;
  @override
  void initState() {
    branchBloc = BlocProvider.of<BranchBloc>(context);
    branchBloc.add(FetchBranch());

    signupBloc = BlocProvider.of<SignupBloc>(context)
      ..stream.listen((state) {
        if (state is SignupDone) {
          signupBloc.add(FetchUserEvent());

          showToast(message: state.signupResponse.message);
          clearData();
          LoaderWidget().showLoader(context, stopLoader: true);

          /*   Navigator.pushNamedAndRemoveUntil(
              context, AdminPanel.routeName, (route) => false); */
        } else if (state is SignupError) {
          showToast(message: state.error, isError: true);
          LoaderWidget().showLoader(context, stopLoader: true);
        } else if (state is UserDeleted) {
          signupBloc.add(FetchUserEvent());
          showToast(message: "User deleted successfully");
        } else if (state is UserDeleteError) {
          showToast(message: "Something went wrong");
        } else if (state is UpdateUserDone) {
          LoaderWidget().showLoader(context, stopLoader: true);
          signupBloc.add(FetchUserEvent());
          showToast(message: "Updated successfully");
          clearData();
        } else if (state is UpdateUserError) {
          LoaderWidget().showLoader(context, stopLoader: true);
          showToast(message: "Something went wrong");
        }
      });
    //  signupBloc = BlocProvider.of<SignupBloc>(context);
    signupBloc.add(FetchUserEvent());
    super.initState();
  }

  List branches = [];

  List<UserDetail> users = [];

  int id = 0;
  String branchCode = "";
  String userRole = "";
  final formKey = GlobalKey<FormState>();
  List<BranchDetail> branchList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Users"),
        backgroundColor: Colors.deepPurple,
      ), */
      body: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                RotatedBox(
                  quarterTurns: 2,
                  child: Image.network(
                    "https://devexperts.com/blog/wp-content/uploads/2012/11/Post-inner-banner-2336x1314-1-1752x986.png",
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.45,
                    fit: BoxFit.fill,
                  ),
                ),
                Image.asset(
                  'images/illustration-2.png',
                  width: 500,
                  fit: BoxFit.fill,
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.17,
                    right: MediaQuery.of(context).size.width * 0.5,
                    child: SizedBox(
                      width: 250.0,
                      child: DefaultTextStyle(
                        style: GoogleFonts.acme(
                            fontSize: 50, color: Colors.white.withOpacity(0.6)),
                        child: AnimatedTextKit(
                          isRepeatingAnimation: false,
                          animatedTexts: [
                            TyperAnimatedText('Create\n       Users'),
                          ],
                          onTap: () {
                            print("Tap Event");
                          },
                        ),
                      ),
                    )),
                Positioned(
                  right: 10,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withOpacity(0.3),
                    ),
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextFieldWidget(
                            controller: userName,
                            color: Colors.white,
                            title: "User",
                            validator: (value) {
                              if (userName.text == null ||
                                  userName.text == "") {
                                return "Please enter username";
                              }
                            },
                          ),
                          TextFieldWidget(
                            controller: passwordController,
                            color: Colors.white,
                            title: "Password",
                            validator: (value) {
                              if (id == 0) {
                                if (passwordController.text == null ||
                                    passwordController.text == "") {
                                  return "Please enter password";
                                }
                              }
                            },
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.98,
                            //height: 70,
                            //margin: const EdgeInsets.symmetric(vertical: 20.0),
                            //padding: const EdgeInsets.all(10),
                            child: DropdownButtonFormField(
                                dropdownColor: Colors.purple.shade200,
                                validator: (value) {
                                  if (value == null || value == "") {
                                    return "Please select role";
                                  }
                                },
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.white)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.white)),
                                  // filled: true,
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                  hintText: "Select Role",
                                ),
                                value: userRole == "" ? null : userRole,
                                style: TextStyle(color: Colors.white),
                                items: ["Admin", "User"].map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (a) {
                                  setState(() {
                                    userRole = a.toString();
                                  });
                                }),
                          ),
                          if (userRole != "Admin")
                            BlocBuilder<BranchBloc, BranchState>(
                              builder: (context, state) {
                                if (state is BranchDone) {
                                  branchList = state.branchList;
                                }
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IgnorePointer(
                                      ignoring: state is BranchLoad,
                                      child: Container(
                                        width: state is BranchLoad
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.35
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.385,
                                        padding: const EdgeInsets.only(top: 10),

                                        /*   margin: const EdgeInsets.symmetric(
                                            vertical: 20.0, horizontal: 10), */
                                        child: DropdownButtonFormField(
                                            dropdownColor:
                                                Colors.purple.shade200,
                                            validator: (value) {
                                              if (userRole != "Admin") {
                                                if (userName.text == null ||
                                                    userName.text == "") {
                                                  return "Please select branch";
                                                }
                                              }
                                            },
                                            value: branchCode == ""
                                                ? null
                                                : branchCode,
                                            decoration: InputDecoration(
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: const BorderSide(
                                                        color: Colors.white)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: const BorderSide(
                                                        color: Colors.white)),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                Colors.white)),
                                                // filled: true,
                                                hintStyle: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white),
                                                hintText: "Select Branch",
                                                fillColor: Colors.blue[200]),
                                            items: branchList.map((value) {
                                              return DropdownMenuItem<String>(
                                                value: value.ID.toString(),
                                                child: Text(
                                                  value.branchName,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (a) {
                                              branchCode = a.toString();
                                            }),
                                      ),
                                    ),
                                    if (state is BranchLoad)
                                      const CircularProgressIndicator()
                                  ],
                                );
                              },
                            ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 50.0, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton.icon(
                                    style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        backgroundColor: Colors.deepPurple),
                                    onPressed: () async {
                                      if (id == 0) {
                                        LoaderWidget().showLoader(context);

                                        if (formKey.currentState!.validate()) {
                                          context.read<SignupBloc>().add(
                                              SignupRequestEvent(
                                                  CreateuserRequest(
                                                      Username: userName.text,
                                                      Password:
                                                          passwordController
                                                              .text,
                                                      Role: userRole,
                                                      Branch: int.parse(
                                                          branchCode == ""
                                                              ? "0"
                                                              : branchCode))));
                                        } else {
                                          LoaderWidget().showLoader(context,
                                              stopLoader: true);
                                        }
                                      } else {
                                        LoaderWidget().showLoader(context);

                                        if (formKey.currentState!.validate()) {
                                          context.read<SignupBloc>().add(
                                              UpdateUserEvent(
                                                  id,
                                                  CreateuserRequest(
                                                      Username: userName.text,
                                                      Password:
                                                          passwordController
                                                              .text,
                                                      Role: userRole,
                                                      Branch: int.parse(
                                                          branchCode == ""
                                                              ? "0"
                                                              : branchCode))));
                                        } else {
                                          LoaderWidget().showLoader(context,
                                              stopLoader: true);
                                        }
                                      }
                                    },
                                    label: id == 0
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Text(
                                              "Create",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        : const Text(
                                            "Update",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                    icon: id == 0
                                        ? const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          )
                                        : const Icon(
                                            Icons.update,
                                            color: Colors.white,
                                          ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<SignupBloc, SignupState>(
              builder: (context, state) {
                if (state is FetchUserDone) {
                  users = state.userList;
                  return Expanded(
                    child: ListView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            if (index == 0)
                              ListTile(
                                title: Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        "ID",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.deepPurple),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        "Username",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.deepPurple),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 7),
                                      width: 150,
                                      child: Text(
                                        "Role",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.deepPurple,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (users[index].ID != id)
                                      const Padding(
                                        padding: EdgeInsets.all(5),
                                        child: InkWell(
                                          child: Text(
                                            "Edit",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.deepPurple,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Text(
                                      "Delete",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.deepPurple,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            if (index == 0) Divider(),
                            ListTile(
                              selected: id == users[index].ID,
                              selectedTileColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.4),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      "#${users[index].ID}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: id == users[index].ID
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      users[index].username.toCapitalized(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: id == users[index].ID
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 120,
                                  ),
                                  Container(
                                    width: 150,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color:
                                            Colors.deepPurple.withOpacity(0.1)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 7),
                                    child: Text(
                                      users[index].role == ""
                                          ? "Anonymous"
                                          : users[index].role,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: id == users[index].ID
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (users[index].ID != id)
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          color: Colors.deepPurple
                                              .withOpacity(0.1)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: InkWell(
                                          child: const Icon(
                                            Icons.edit,
                                            size: 20,
                                            color: Colors.deepPurple,
                                          ),
                                          onTap: () async {
                                            updateFields(index);
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    )
                                  else
                                    IconButton(
                                      icon: const Icon(
                                        Icons.clear,
                                        color: Colors.black,
                                      ),
                                      onPressed: () async {
                                        clearData();
                                        setState(() {});
                                      },
                                    ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      signupBloc.add(
                                          DeleteUserEvent(users[index].ID));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }
                if (state is FetchUserLoad) {
                  return const CircularProgressIndicator();
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Map<String, Object?> get userMap {
    return {
      "userName": userName.text,
      "password": passwordController.text,
      "branchCode": branchCode,
      "userRole": userRole
    };
  }

  void updateFields(int index) {
    /*  users.forEach((user) {
      branchList.forEach((branch) {
        if(user.branch==branch.ID)

      });
    }); */
    id = users[index].ID;
    passwordController.text = "";
    branchCode = users[index].branch.toString();
    userRole = users[index].role;
    userName.text = users[index].username;
  }

  void clearData() {
    setState(() {
      userName.clear();
      passwordController.clear();
      branchCode = "";
      userRole = "";
      id = 0;
    });
  }
}
