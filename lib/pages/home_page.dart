import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:youtube_clone_app_ui/json/home_video.dart';
import 'package:youtube_clone_app_ui/pages/video_detail_page.dart';
import 'package:youtube_clone_app_ui/theme/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset("assets/images/youtube.svg", width: 35,),
                Row(
                  children: <Widget>[
                    const IconButton(onPressed: null,
                      icon: Icon(LineIcons.video,
                          color: Colors.white,
                          size: 28)),
                    const IconButton(onPressed: null,
                      icon: Icon(LineIcons.search,
                          color: Colors.white,
                          size: 28)),
                    const IconButton(onPressed: null,
                      icon: Icon(LineIcons.bell,
                        color: Colors.white,
                        size: 28,),
                      ),
                    const SizedBox(width: 5,),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        /*image: DecorationImage(
                          image: NetworkImage(url),
                          fit: BoxFit.cover
                        )*/
                      ),
                    ),
                  ],
                ),
              ],
            ),

          ),
          const SizedBox(height: 20,),
          const Padding(padding: EdgeInsets.only(left: 20, right: 20),
            child: Text("Recommended", style: TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold
            ),),
          ),
          const SizedBox(height: 20,),
          const SizedBox(height: 10,),
          Column(
            children: List.generate(home_video.length, ((index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) =>
                      VideoDetailPage(
                          thumnail: home_video[index]['thumnail_img'],
                          title: home_video[index]['title'],
                          viewCount: home_video[index]['view_count'],
                          dayAgo: home_video[index]['day_ago'],
                          username: home_video[index]['username'],
                          profile: home_video[index]['profile_img'],
                          subscribeCount: home_video[index]['subscriber_count'],
                          likeCount: home_video[index]['like_count'],
                          unlikeCount: home_video[index]['unlike_count'],
                          videoUrl: home_video[index]['video_url'])
                    ));
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  image: AssetImage(home_video[index]['thumnail_img']),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                      ),
                      Padding(padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(image: NetworkImage(
                                      home_video[index]['profile_img']
                                  ), fit: BoxFit.cover)
                              ),
                            ),
                            const SizedBox(width: 15,),
                            SizedBox(
                              width: size.width - 120,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start ,
                                children: [Text(home_video[index]['title'], style: TextStyle(
                                    color: white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    height: 1.3
                                ),
                                ),
                                  const SizedBox(height: 2,),
                                  Row(
                                    children: [
                                      Container(
                                        width: size.width - 120,
                                        child: Text(home_video[index]['username'] +
                                            " - " +
                                            home_video[0]['day_ago'] + " - "
                                            + home_video[0]['view_count'],
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: white.withOpacity(0.4),
                                              height: 1.5
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Icon(
                              LineIcons.verticalEllipsis, color: white.withOpacity(0.4),
                            ),


                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }))
          ),
        ],
      ),
    );
  }
}
