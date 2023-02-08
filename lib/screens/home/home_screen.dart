import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sic_management_app/constants/constant_color.dart';
import 'package:sic_management_app/providers/user_provider.dart';
import 'package:sic_management_app/screens/home/add_user_dialog.dart';
import 'package:sic_management_app/services/app_language.dart';

class HomeScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Language dropdownValue =
      AppLanguage().appLocal == const Locale('lo') ? Language.lo : Language.en;

  @override
  void initState() {
    context.read<UserProvider>().getUserInfo();
    context.read<UserProvider>().getUserAmount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: StreamBuilder<dynamic>(
            stream: userProvider.amount,
            builder: (context, snapshot) {
              return Text(
                "USER: ${snapshot.data ?? '...'}",
              );
            }),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<Language>(
              value: dropdownValue,
              icon: const Icon(Icons.translate),
              elevation: 16,
              underline: Container(),
              onChanged: (Language? value) {
                setState(() {
                  dropdownValue = value!;
                  if (dropdownValue == Language.lo) {
                    context.read<AppLanguage>().changeLanguage(Language.lo);
                  } else {
                    context.read<AppLanguage>().changeLanguage(Language.en);
                  }
                });
              },
              items: const [
                DropdownMenuItem<Language>(
                  value: Language.en,
                  child: Text("EN "),
                ),
                DropdownMenuItem<Language>(
                  value: Language.lo,
                  child: Text("LO "),
                ),
              ],
            ),
          )
        ],
      ),
      body: userProvider.isGettingUserInfo
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: userProvider.userData.length,
                itemBuilder: (context, index) => Dismissible(
                  background: showBackgroud(0),
                  secondaryBackground: showBackgroud(1),
                  onDismissed: (_) {
                    context.read<UserProvider>().deleteUser(
                          id: userProvider.userData[index].id.toString(),
                        );
                  },
                  confirmDismiss: (_) {
                    return showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Are you sure'),
                        content: const Text('Do you really want to delete?'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('NO')),
                          TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('YES')),
                        ],
                      ),
                    );
                  },
                  key: ValueKey<String>(
                      userProvider.userData[index].id.toString()),
                  child: ListTile(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (context) => AddUserDialog(
                            userInfo: userProvider.userData[index],
                            isEditMode: true),
                      );
                    },
                    title: Text(
                      '${userProvider.userData[index].name} ${userProvider.userData[index].surname}',
                      style: const TextStyle(color: ConstantColors.backGround),
                    ),
                    subtitle: Text(
                      'Tel : ${userProvider.userData[index].tel}',
                      style: const TextStyle(color: ConstantColors.backGround),
                    ),
                    leading: const SizedBox(
                      height: double.infinity,
                      child: Icon(
                        Icons.people,
                        color: ConstantColors.backGround,
                      ),
                    ),
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: ConstantColors.primar3,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddUserDialog(),
          );
        },
      ),
    );
  }

  Widget showBackgroud(int direction) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }
}
