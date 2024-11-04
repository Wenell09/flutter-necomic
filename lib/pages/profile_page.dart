import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_komik/bloc/auth/auth_bloc.dart';
import 'package:flutter_komik/bloc/save_userId/save_user_id_bloc.dart';
import 'package:flutter_komik/bloc/theme/theme_bloc.dart';
import 'package:flutter_komik/bloc/user/user_bloc.dart';
import 'package:flutter_komik/pages/favorites_page.dart';
import 'package:flutter_komik/pages/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaveUserIdBloc, SaveUserIdState>(
      builder: (context, saveState) {
        if (saveState is SaveUserLoaded) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.blue,
            ),
            body: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.28,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        Center(
                          child: BlocBuilder<UserBloc, UserState>(
                            builder: (context, state) {
                              if (state is UserLoaded) {
                                return Text(
                                  cutString(state.user.username),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                );
                              }
                              return const Text("");
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text(
                            "Username",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          trailing: BlocBuilder<UserBloc, UserState>(
                            builder: (context, state) {
                              if (state is UserLoaded) {
                                return Text(
                                  state.user.username,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              }
                              return const Text("");
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          trailing: BlocBuilder<UserBloc, UserState>(
                            builder: (context, state) {
                              if (state is UserLoaded) {
                                return Text(
                                  state.user.email,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              }
                              return const Text("");
                            },
                          ),
                        ),
                        const Divider(),
                        InkWell(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const FavoritesPage(),
                          )),
                          child: const ListTile(
                            leading: Icon(
                              Icons.favorite,
                              size: 30,
                              color: Colors.blue,
                            ),
                            title: Text(
                              "My favorite comics",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Icon(
                              Icons.navigate_next_outlined,
                              color: Colors.blue,
                              size: 30,
                            ),
                          ),
                        ),
                        const Divider(),
                        InkWell(
                          onTap: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  contentPadding: const EdgeInsets.only(
                                    top: 20,
                                    bottom: 20,
                                  ),
                                  actionsAlignment:
                                      MainAxisAlignment.spaceAround,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  content: const Text(
                                    textAlign: TextAlign.center,
                                    "Are you sure want to Logout?",
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text(
                                        "No",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context.read<AuthBloc>().add(Logout());
                                        context
                                            .read<SaveUserIdBloc>()
                                            .add(SaveUserId(userId: ""));
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        "Logout",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const ListTile(
                            leading: Icon(
                              Icons.logout,
                              color: Colors.blue,
                              size: 30,
                            ),
                            title: Text(
                              "Logout",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Icon(
                              Icons.navigate_next_outlined,
                              color: Colors.blue,
                              size: 30,
                            ),
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(
                            Icons.dark_mode,
                            color: Colors.blue,
                            size: 30,
                          ),
                          title: const Text(
                            "dark Mode",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: BlocBuilder<ThemeBloc, ThemeState>(
                            bloc: context.read<ThemeBloc>()..add(LoadTheme()),
                            builder: (context, state) {
                              return AnimatedSwitcher(
                                duration: const Duration(seconds: 2),
                                transitionBuilder: (child, animation) =>
                                    ScaleTransition(
                                  scale: animation,
                                  child: child,
                                ),
                                child: Switch(
                                  key: ValueKey<bool>(state.isDark),
                                  value: state.isDark,
                                  activeColor: Colors.white,
                                  activeTrackColor: Colors.grey[700],
                                  inactiveTrackColor: Colors.white,
                                  inactiveThumbColor: Colors.grey[700],
                                  onChanged: (value) async {
                                    context
                                        .read<ThemeBloc>()
                                        .add(SaveTheme(isDark: value));
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          textAlign: TextAlign.center,
                          "Versi Aplikasi\n1.0.0",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.28 - 65,
                      left: MediaQuery.of(context).size.width / 2 - 62.5,
                      child: BlocBuilder<SaveUserIdBloc, SaveUserIdState>(
                        builder: (context, saveState) {
                          if (saveState is SaveUserLoaded) {
                            return BlocBuilder<UserBloc, UserState>(
                              builder: (context, state) {
                                if (state is UserLoaded) {
                                  return Container(
                                    width: 125,
                                    height: 125,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(state.user.photo),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }
                                return Container(
                                  width: 125,
                                  height: 125,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.lightBlueAccent,
                                  ),
                                );
                              },
                            );
                          }
                          return Container(
                            width: 125,
                            height: 125,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.blue,
          ),
          body: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.28,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      Center(
                        child: Center(
                          child: InkWell(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            )),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const ListTile(
                        title: Text(
                          "Username",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        trailing: Text(
                          "**********",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Divider(),
                      const ListTile(
                        title: Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        trailing: Text(
                          "**********",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(
                          Icons.dark_mode,
                          color: Colors.blue,
                          size: 30,
                        ),
                        title: const Text(
                          "dark Mode",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: BlocBuilder<ThemeBloc, ThemeState>(
                          bloc: context.read<ThemeBloc>()..add(LoadTheme()),
                          builder: (context, state) {
                            return AnimatedSwitcher(
                              duration: const Duration(seconds: 2),
                              transitionBuilder: (child, animation) =>
                                  ScaleTransition(
                                scale: animation,
                                child: child,
                              ),
                              child: Switch(
                                key: ValueKey<bool>(state.isDark),
                                value: state.isDark,
                                activeColor: Colors.white,
                                activeTrackColor: Colors.grey[700],
                                inactiveTrackColor: Colors.white,
                                inactiveThumbColor: Colors.grey[700],
                                onChanged: (value) async {
                                  context
                                      .read<ThemeBloc>()
                                      .add(SaveTheme(isDark: value));
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        textAlign: TextAlign.center,
                        "Versi Aplikasi\n1.0.0",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.28 - 65,
                    left: MediaQuery.of(context).size.width / 2 - 62.5,
                    child: Container(
                      width: 125,
                      height: 125,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

String cutString(String inputString) {
  int index = inputString.indexOf(' ');
  if (index != -1) {
    return inputString.substring(0, index).trim();
  } else {
    return inputString;
  }
}
