import 'package:auto_route/auto_route.dart';
import 'package:draggable_float_widget/draggable_float_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/core/route/routes.gr.dart';
import 'package:whatsapp/features/dashboard/presentation/pages/bloc/rtc_databse_crud_bloc/bloc/rtc_crud_bloc.dart';
import 'package:whatsapp/features/dashboard/presentation/pages/chat_page.dart';

import 'bloc/listen_bloc/listen_bloc.dart';
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

  RtcCrudBloc rtcCrudBloc = RtcCrudBloc();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => listenBloc..add(ListenDataEvent(listen: true)),
        ),
        BlocProvider(
          create: (context) => rtcCrudBloc,
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<ListenBloc, ListenState>(
            listener: (context, state) {
              if (state is ListenDataLiveState) {
                QuickAlert.show(
                    context: context,
                    type: QuickAlertType.confirm,
                    title: state.callerId,
                    text: "Do you want to receive a call?",
                    onConfirmBtnTap: () async {
                      rtcCrudBloc
                          .add(RtcCrudUpdateEvent(friendPhone: state.callerId));
                      Navigator.pop(context);
                    },
                    onCancelBtnTap: () {
                      rtcCrudBloc.add(RtcCrudDeleteEvent());
                      Navigator.pop(context);
                    },
                    barrierDismissible: false);
              }
            },
          ),
          BlocListener<RtcCrudBloc, RtcCrudState>(
            listener: (context, state) {
              if (state is RtcCrudUpdateLoadingState) {
                EasyLoading.show();
              } else if (state is RtcCrudUpdateFailState) {
                EasyLoading.dismiss();
                EasyLoading.showError(state.message);
              } else if (state is RtcCrudUpdateSuccessState) {
                EasyLoading.dismiss();
                context.router.push(CallPageRoute(
                    token: state.rtcToken, friendPhone: state.rtcToken));
              }
            },
          ),
        ],
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
                                Stack(
                                  children: [
                                    Container(
                                      color: Colors.red,
                                      height: 500,
                                      width: 100,
                                    ),
                                    DraggableFloatWidget(
                                      child: Container(
                                        color: Colors.white,
                                        height: 0100,
                                        width: 100,
                                      ),
                                    ),
                                  ],
                                )
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
