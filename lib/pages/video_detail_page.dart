import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_clone_app_ui/json/home_video.dart';
import 'package:youtube_clone_app_ui/theme/colors.dart';

class VideoDetailPage extends StatefulWidget {
  String thumnail;
  String title;
  String viewCount;
  String dayAgo;
  String username;
  String profile;
  String subscribeCount;
  String likeCount;
  String unlikeCount;
  String videoUrl;

  VideoDetailPage(
      {required this.thumnail,
      required this.title,
      required this.viewCount,
      required this.dayAgo,
      required this.username,
      required this.profile,
      required this.subscribeCount,
      required this.likeCount,
      required this.unlikeCount,
      required this.videoUrl});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  bool isSwitched = true;
  //add video player controller here
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late int _playBackTime;

  //The values that are passed when changing quality
  late Duration newCurrentPosition;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)..initialize().then((value){
      setState(() {
        _controller.play();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: [
          _controller.value.isInitialized ? Stack(
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Center(
                  child: IconButton(
                      onPressed: (){
                        setState(() {
                          _controller.value.isPlaying ? _controller.pause()
                              : _controller.play();
                        });
                      },
                      icon: Icon(
                          _controller.value.isPlaying ? null :
                          Icons.play_arrow, size: 60,
                        color: white,)),
                ),
              )
            ],
          ) : Container(
            width: size.width,
            height: 250,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(widget.thumnail), fit: BoxFit.cover)),
          ),
          Expanded(
              child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width - 80,
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: white.withOpacity(0.8),
                                    fontWeight: FontWeight.w500,
                                    height: 1.3),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  LineIcons.angleDown,
                                  color: white.withOpacity(0.7),
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              widget.viewCount + " views - " + widget.dayAgo,
                              style: TextStyle(
                                  color: white.withOpacity(0.4), fontSize: 13),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: <Widget>[
                                  Icon(
                                    LineIcons.thumbsUp,
                                    color: white.withOpacity(0.5),
                                    size: 26,
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    widget.likeCount,
                                    style: TextStyle(
                                        color: white.withOpacity(0.4),
                                        fontSize: 13),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Icon(
                                    LineIcons.thumbsDown,
                                    color: white.withOpacity(0.5),
                                    size: 26,
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    widget.unlikeCount,
                                    style: TextStyle(
                                        color: white.withOpacity(0.4),
                                        fontSize: 13),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Icon(
                                    LineIcons.share,
                                    color: white.withOpacity(0.5),
                                    size: 26,
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "Share",
                                    style: TextStyle(
                                        color: white.withOpacity(0.4),
                                        fontSize: 13),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Icon(
                                    LineIcons.download,
                                    color: white.withOpacity(0.5),
                                    size: 26,
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "Download",
                                    style: TextStyle(
                                        color: white.withOpacity(0.4),
                                        fontSize: 13),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Icon(
                                    LineIcons.plus,
                                    color: white.withOpacity(0.5),
                                    size: 26,
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "Save",
                                    style: TextStyle(
                                        color: white.withOpacity(0.4),
                                        fontSize: 13),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: white.withOpacity(0.1),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                      image: NetworkImage(widget.profile),
                                      fit: BoxFit.cover)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: size.width - 180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.username,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: white,
                                        fontWeight: FontWeight.w500,
                                        height: 1.3),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    widget.subscribeCount,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: white.withOpacity(0.4),
                                        fontWeight: FontWeight.w500,
                                        height: 1.3),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "SUBSCRIBE",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: red),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: white.withOpacity(0.1),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Up next",
                          style: TextStyle(
                              fontSize: 14, color: white.withOpacity(0.4)),
                        ),
                        Row(
                          children: [
                            Text(
                              "Autoplay",
                              style: TextStyle(
                                  fontSize: 14, color: white.withOpacity(0.4)),
                            ),
                            Switch(
                                value: isSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched = value;
                                  });
                                }),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Padding(padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            children: List.generate(home_video_detail.length, (index){
                              return GestureDetector(
                                onTap: (){
                                  _startPlay(home_video_detail[index]);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: (size.width - 50) / 2,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(home_video_detail[index]['thumnail_img']),
                                                fit: BoxFit.cover),
                                            borderRadius: BorderRadius.circular(8)),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                                bottom: 10,
                                                right: 12,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.black.withOpacity(0.8),
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(3),
                                                    child: Text(home_video_detail[index]['video_duration'], style: TextStyle(
                                                        fontSize: 12,
                                                        color: white.withOpacity(0.4)
                                                    ),),
                                                  ),
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 20,),
                                      Expanded(child: Container(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: (size.width - 130) / 2,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(home_video_detail[index]['title'], style: TextStyle(
                                                      fontSize: 14,
                                                      color: white.withOpacity(0.9),
                                                      height: 1.3,
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                    maxLines: 3,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(home_video_detail[index]['username'], style: TextStyle(
                                                      fontSize: 12,
                                                      color: white.withOpacity(0.4),
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(home_video_detail[index]['view_count'], style: TextStyle(
                                                      fontSize: 12,
                                                      color: white.withOpacity(0.4)
                                                  ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),

                                                ],
                                              ),
                                            ),
                                            Icon(LineIcons.verticalEllipsis,
                                              color: white.withOpacity(0.4),)
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                              );
                            }),
                          )
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  Future<bool> _clearPrevious() async {
    await _controller.pause();
        return true;
  }

  Future<void> _startPlay(videoItem) async {
    setState(() {
      _initializeVideoPlayerFuture = null as Future<void>;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      _clearPrevious().then((value){
        _initializePlay(videoItem['video_url']);
      });
    });

    //new state of video object
    setState(() {
      widget.title = videoItem['title'];
      widget.viewCount = videoItem['view_count'];
      widget.dayAgo = videoItem['day_ago'];
      widget.username = videoItem['username'];
      widget.profile = videoItem['profile_img'];
      widget.subscribeCount = videoItem['subscriber_count'];
      widget.likeCount = videoItem['like_count'];
      widget.unlikeCount = videoItem['unlike_count'];
    });
  }

  Future<void> _initializePlay(String videoPath) async {
    _controller = VideoPlayerController.asset(videoPath);
    _controller.addListener(() {
      setState(() {
        _playBackTime = _controller.value.position.inSeconds;
      });
    });
    _initializeVideoPlayerFuture = _controller.initialize().then((value){
      _controller.seekTo(newCurrentPosition);
      _controller.play();
    });
  }

}
