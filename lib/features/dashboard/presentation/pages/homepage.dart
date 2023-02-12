import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/core/route/routes.gr.dart';
import 'package:whatsapp/features/dashboard/presentation/pages/chat_page.dart';

import 'bloc/bloc/listen_bloc.dart';
import 'contact_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final List<String> _tabs = ['Chats', 'Status', 'Calls'];
  final List<String> _items = [
    'Chats',
    'Status',
    'Calls',
    'Chats',
    'Status',
    'Calls',
    'Chats',
    'Status',
    'Calls',
    'Chats',
    'Status',
    'Calls',
    'Chats',
    'Status',
    'Calls',
    'Chats',
    'Status',
    'Calls',
    'Chats',
    'Status',
    'Calls',
    'Chats',
    'Status',
    'Calls',
    'Chats',
    'Status',
    'Calls',
    'Chats',
    'Status',
    'Calls',
  ];
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: _tabs.length,
      vsync: this,
    );
  }

  ListenBloc listenBloc = ListenBloc();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => listenBloc..add(ListenDataEvent(listen: true)),
      child: BlocListener<ListenBloc, ListenState>(
        listener: (context, state) {
          if (state is ListenDataLiveState) {
            EasyLoading.showInfo(state.message);
          }
        },
        child: SafeArea(
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
                backgroundColor: const Color.fromARGB(255, 66, 153, 127),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('authenticated');
                  await prefs.setBool('authenticated', false);
                  listenBloc.add(ListenDataEvent(listen: false));
                  context.router.pushAndPopUntil(SignUpPageRoute(),
                      predicate: ((route) => false));
                },
                child: const Icon(
                  Icons.message,
                  color: Colors.white,
                )),
            body: DefaultTabController(
              length: 4,
              child: Builder(builder: (BuildContext context) {
                return NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        elevation: 0,
                        actions: [
                          SizedBox(
                            width: size.width / 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Icon(CupertinoIcons.photo_camera),
                                Icon(CupertinoIcons.search),
                                Icon(Icons.more_vert_rounded)
                              ],
                            ),
                          )
                        ],
                        title: const Text('Hydrush'),
                      ),
                      SliverAppBar(
                        pinned: true,
                        flexibleSpace: Container(
                          color: Theme.of(context).bottomAppBarColor,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: DefaultTabController(
                                  length: 3,
                                  child: Column(
                                    children: [
                                      TabBar(
                                          controller: tabController,
                                          tabs: _tabs
                                              .map((e) => Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 32,
                                                        vertical: 18),
                                                    child: Row(
                                                      children: [
                                                        Text(e
                                                            // style:
                                                            //     const TextStyle(color: colorPrimary),
                                                            ),
                                                      ],
                                                    ),
                                                  ))
                                              .toList()),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    controller: tabController,
                    children: [
                      // FIRST TabBarView
                      CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [const ChatPage()],
                            ),
                          ),
                        ],
                      ),

                      // SECOND TabBarView
                      CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        color: Colors.white,
                                        width: double.infinity,
                                        child: Image.network(
                                          'https://cdn.britannica.com/24/58624-050-73A7BF0B/valley-Atlas-Mountains-Morocco.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        color: Colors.white,
                                        width: double.infinity,
                                        child: const Text('text'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      //THIRD TabBarView
                      CustomScrollView(
                        slivers: [
                          SliverList(
                              delegate: SliverChildListDelegate(
                                  [const ContactPage()]))
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              actions: [
                SizedBox(
                  width: size.width / 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(CupertinoIcons.photo_camera),
                      Icon(CupertinoIcons.search),
                      Icon(Icons.more_vert_rounded)
                    ],
                  ),
                )
              ],
              title: const Text('WhatsApp'),
            ),
            SliverAppBar(
              pinned: true,
              flexibleSpace: Container(
                color: Theme.of(context).bottomAppBarColor,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: DefaultTabController(
                        length: 3,
                        child: Column(
                          children: [
                            TabBar(
                                controller: tabController,
                                tabs: _tabs
                                    .map((e) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 32, vertical: 18),
                                          child: Row(
                                            children: [
                                              Text(e
                                                  // style:
                                                  //     const TextStyle(color: colorPrimary),
                                                  ),
                                            ],
                                          ),
                                        ))
                                    .toList()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (context, index) => SizedBox(
                height: 60,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    ListTile(
                      tileColor:
                          (index % 2 == 0) ? Colors.white : Colors.green[50],
                      title: Center(
                        child: Text('$index',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 50,
                                color: Colors.greenAccent[400]) //TextStyle
                            ), //Text
                      ), //Center
                    ),
                    Container(),
                    Container()
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
