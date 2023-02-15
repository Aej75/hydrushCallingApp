import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/features/dashboard/presentation/pages/bloc/listen_bloc/listen_bloc.dart';
import 'package:whatsapp/features/dashboard/presentation/pages/bloc/rtc_databse_crud_bloc/bloc/rtc_crud_bloc.dart';

import '../../../../core/utils/settings.dart';

class CallPage extends StatefulWidget {
  final String friendPhone;
  final String token;
  final String? channelName;
  final ClientRole? role;
  const CallPage(
      {super.key,
      required this.token,
      required this.friendPhone,
      this.channelName = 'videoCall',
      this.role = ClientRole.Broadcaster});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  final _users = <int>[];

  final _infoString = <String>[];
  bool muted = false;
  bool viewPanel = false;
  late RtcEngine _engine;
  ListenBloc listenBloc = ListenBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initialize();
  }

  RtcCrudBloc rtcCrudBloc = RtcCrudBloc();

  @override
  void dispose() {
    // TODO: implement dispose
    _users.clear();
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

  Future<void> initialize() async {
    if (appID.isEmpty) {
      setState(() {
        _infoString.add(
            'APP_ID is missing, please provide your APP_ID in settings.dart');
        _infoString.add("Agora Engine is not starting");
      });

      return;
    }

    _engine = await RtcEngine.create(appID);

    await _engine.enableVideo();

    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(widget.role!);

    _addAgoraEventHandlers();
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    // configuration.dimensions = const VideoDimensions(width: 1920, height: 1080);
    await _engine.setVideoEncoderConfiguration(configuration);
    await _engine.joinChannel(widget.token, widget.channelName!, null, 0);
  }

  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(
      error: (err) {
        setState(() {
          final info = "error: $err";

          _infoString.add(info);
        });
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        setState(() {
          final info = "join Channel: $channel, uid:$uid";

          _infoString.add(info);
        });
      },
      leaveChannel: (stats) {
        setState(() {
          const info = "leave Channel";

          setState(() {
            _users.remove(_users[1]);
          });
        });
      },
      userJoined: (remoteUid, elapsed) {
        setState(() {
          final info = 'user joined: $remoteUid';
          _infoString.add(info);

          _users.add(remoteUid);
        });
      },
      userOffline: (remoteUid, reason) {
        final info = 'user Offline: $remoteUid';
        _infoString.add(info);

        _users.remove(remoteUid);
      },
      firstRemoteVideoFrame: (uid, width, height, elapsed) {
        final info = "First remote vide = $uid ${width}x $height";

        _infoString.add(info);
      },
    ));
  }

  Widget _viewRows() {
    final List<StatefulWidget> list = [];

    if (widget.role == ClientRole.Broadcaster) {
      list.add(const rtc_local_view.SurfaceView.screenShare());
    }
    for (var uid in _users) {
      list.add(rtc_remote_view.SurfaceView(
        channelId: widget.channelName!,
        uid: uid,
      ));
    }

    final views = list;

    // for (int i = 1; views.length < i; i++) {
    //   if (i == 1) {
    //     return Stack(
    //       children: [
    //         Positioned(
    //           top: 0,
    //           child: SizedBox(
    //               width: MediaQuery.of(context).size.width / 3,
    //               height: MediaQuery.of(context).size.width / 3,
    //               child: views[1]),
    //         ),
    //         Expanded(child: views[2])
    //       ],
    //     );
    //   }
    // }
    return views.length == 1
        ? Expanded(child: views[0])
        : Stack(
            children: [
              views[1],
              Positioned(
                  right: 10,
                  top: 10,
                  child: SizedBox(height: 150, width: 100, child: views[0]))
            ],
          );

    // FloatingDraggableWidget(
    //     screenHeight: MediaQuery.of(context).size.height,
    //     screenWidth: MediaQuery.of(context).size.width,
    //     autoAlign: true,
    //     mainScreenWidget: Expanded(child: views[1]),
    //     floatingWidgetHeight: 150,
    //     floatingWidgetWidth: 100,
    //     floatingWidget: Expanded(child: views[0]),
    //   );

    // return Stack(
    //     children: List.generate(views.length, (index) => views[index]));
  }

  Widget _toolbar() {
    if (widget.role == ClientRole.Audience) return const Text('Audience');

    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {
              setState(() {
                muted = !muted;
              });
              _engine.muteLocalAudioStream(muted);
            },
            shape: const CircleBorder(),
            elevation: 2,
            fillColor: muted ? Colors.greenAccent : Colors.white,
            padding: const EdgeInsets.all(12),
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.green,
              size: 20,
            ),
          ),
          RawMaterialButton(
            onPressed: () async {
              await _engine.leaveChannel();
              rtcCrudBloc.add(RtcCrudDeleteEvent());

              var updated =
                  widget.friendPhone.replaceAll('(', '').replaceAll(')', '');

              // listenBloc.add(UpdatePageEvent(friendPhone: updated));

              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            shape: const CircleBorder(),
            elevation: 2,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(12),
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35,
            ),
          ),
          RawMaterialButton(
            onPressed: () {
              _engine.switchCamera();
            },
            shape: const CircleBorder(),
            elevation: 2,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12),
            child: const Icon(
              Icons.switch_camera,
              color: Colors.black,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _panel() {
    return Visibility(
        visible: viewPanel,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          alignment: Alignment.bottomCenter,
          child: FractionallySizedBox(
            heightFactor: 0.5,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: ListView.builder(
                  reverse: true,
                  itemCount: _infoString.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (_infoString.isEmpty) {
                      return const Text('null');
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 10),
                      child: Row(
                        children: [
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                _infoString[index],
                                style: const TextStyle(color: Colors.blueGrey),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //   actions: [
          //   IconButton(
          //       onPressed: () {
          //         setState(() {
          //           viewPanel = !viewPanel;
          //         });
          //       },
          //       icon: const Icon(Icons.info_outline))
          // ]
          ),
      body: BlocProvider(
        create: (context) => listenBloc,
        child: BlocListener<ListenBloc, ListenState>(
          listener: (context, state) async {
            if (state is ListenAndUpdateState) {
              setState(() {});
            }
          },
          child: Center(
            //     child: Column(
            //   children: [_toolbar()],
            // )

            child: Stack(
              children: [_viewRows(), _panel(), _toolbar()],
            ),
          ),
        ),
      ),
    );
  }
}
