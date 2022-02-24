
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_myinsta/models/post.dart';
import 'package:flutter_myinsta/models/temp.dart';
import 'package:flutter_myinsta/widgets/feed_user_panel.dart';
import 'package:flutter_myinsta/widgets/my_rich_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_like_button/insta_like_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyFeedPage extends StatefulWidget {

  const MyFeedPage({Key? key}) : super(key: key);

  @override
  State<MyFeedPage> createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<MyFeedPage> {
  Size? mediaquery_size;
 
  String img1 =
      "https://www.perma-horti.com/wp-content/uploads/2019/02/image-2.jpg";
  String img2 = "https://ychef.files.bbci.co.uk/976x549/p0738j5f.jpg";

  List<Post> All_posts = [
    Post([
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVC4vdx30EZy4eGVRvk0WD4XF8tYtYq676VwR7R63NGBpFRtcbIOPFqk0RCOmAhLkYpjM&usqp=CAU",
      "https://media.defense.gov/2013/Aug/12/2000705252/-1/-1/0/190413-A-YG824-002.JPG",
      "https://ychef.files.bbci.co.uk/976x549/p0738j5f.jpg",
      "https://www.perma-horti.com/wp-content/uploads/2019/02/image-2.jpg",
      "https://ychef.files.bbci.co.uk/976x549/p0738j5f.jpg",
      "https://www.perma-horti.com/wp-content/uploads/2019/02/image-2.jpg",
      "https://ychef.files.bbci.co.uk/976x549/p0738j5f.jpg",
      "https://www.perma-horti.com/wp-content/uploads/2019/02/image-2.jpg",
      "https://ychef.files.bbci.co.uk/976x549/p0738j5f.jpg",
    ],
        "this day new day today this day new day today this day new day todaythis day new day todaythis day new day today",
        "102",
        true,
        "2020.01.10",
        "https://ychef.files.bbci.co.uk/976x549/p0738j5f.jpg",
        "FullName"),
    Post([
      "https://www.esafety.gov.au/sites/default/files/2019-08/Remove%20images%20and%20video.jpg",
      'https://img-19.ccm2.net/cI8qqj-finfDcmx6jMK6Vr-krEw=/1500x/smart/b829396acc244fd484c5ddcdcb2b08f3/ccmcms-commentcamarche/20494859.jpg',
      "https://www.perma-horti.com/wp-content/uploads/2019/02/image-2.jpg"
    ],
        "this day this day new day today this day new day today this day new day todaythis day new day todaythis day new day today @new day today",
        "1123",
        false,
        "2020.02.10",
        "https://ychef.files.bbci.co.uk/976x549/p0738j5f.jpg",
        "UserName"),
  ];
  @override
  void initState() {
    super.initState();
    
    if (Temp.p != null) {
      All_posts.add(Temp.p!);
      Temp.p = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var allsize = MediaQuery.of(context).size;
    mediaquery_size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leadingWidth: 0,
          title: Row(
            children: [
              Text("Home",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30)),
                      Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black,)
            ],
          ),
          actions: [
            GestureDetector(
              onTap: ()async{
                // DataService.SetNewData();
                print("cloud data");
                // DataService.Updata("Nurik nima gaplar yana o'zingda");
                // QuerySnapshot<Map<String, dynamic>> query = await DataService.getData();
                // print(query.docs.first.data());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset("assets/images/SVGs/icons8-facebook-messenger(1).svg",
                 height: 30,
                width: 30
                  ),
              ),
            ),
                     ],
                     
        ),
        body: Container(
          height: allsize.height,
          width: allsize.width,
          child: ListView.builder(
              itemCount: All_posts.length,
              itemBuilder: (BuildContext con, int index) {
                // ignore: unnecessary_null_comparison
                if (All_posts[index].image_url != null) {
                  return post_items_builder(All_posts[index]);
                }
                return SizedBox.shrink();
              }),
        ));
  }

// post items builder function

  double image_size = 300.0;
  var page_con = PageController();
  int image_avtive_index = 0;
// post items builder function
  Widget post_items_builder(Post p) => Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyFeedUserPanel(
              title: "Username",
              subtitle: "2020-01-20",
              user_image: p.user_image,
            ),
            // base image
            p.image_url.length == 1
                ? CachedNetworkImage(
                    width: MediaQuery.of(context).size.width,
                    imageUrl: p.image_url[0],
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        Center(child: Icon(Icons.error)),
                    imageBuilder: (con, _image_provider) => InstaLikeButton(
                        width: MediaQuery.of(context).size.width,
                        image: _image_provider,
                        imageBoxfit: BoxFit.cover,
                        iconSize: 100,
                        onChanged: () {
                          setState(() {
                            if (!p.isliked) {
                              p.isliked = true;
                              p.likes = (int.parse(p.likes) + 1).toString();
                            }
                          });
                        }))
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: image_size,
                    child: PageView.builder(
                      controller: page_con,
                      onPageChanged: (int i) {
                        setState(() {
                          image_avtive_index = i;
                        });
                      },
                      itemCount: p.image_url.length,
                      itemBuilder: (con, int index) {
                        return CachedNetworkImage(
                            width: MediaQuery.of(context).size.width,
                            imageUrl: p.image_url[index],
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Center(child: Icon(Icons.error)),
                            imageBuilder: (con, _image_provider) =>
                                InstaLikeButton(
                                    width: MediaQuery.of(context).size.width,
                                    image: _image_provider,
                                    imageBoxfit: BoxFit.cover,
                                    iconSize: 100,
                                    onChanged: () {
                                      setState(() {
                                        if (!p.isliked) {
                                          p.isliked = true;
                                          p.likes = (int.parse(p.likes) + 1)
                                              .toString();
                                        }
                                      });
                                    }));
                      },
                    ),
                  ),
            SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        // like button
                        InkResponse(
                          onTap: () {     
                          
                            setState(() {
                              if (p.isliked) {
                                p.isliked = false;
                                p.likes = (int.parse(p.likes) - 1).toString();
                              } else {
                                p.isliked = true;
                                p.likes = (int.parse(p.likes) + 1).toString();
                              }
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            child: p.isliked
                                ? Icon(FontAwesome.heart,
                                    size: 23.0, color: Colors.red)
                                : Icon(Feather.heart, size: 23.0),
                          ),
                        ),

                        SizedBox(width: 15.0),
                        
                        Image.asset("assets/images/bubble-chat(1).png",
                        height: 24,
                        width: 24,
                         fit: BoxFit.cover,),
                        SizedBox(width: 15.0),
                        Transform.rotate(
                          angle: 3.14 / 10,
                          child: Icon(Feather.send),
                        ),
                      ],
                    ),
                  ),
                  // image  indecator
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: AnimatedSmoothIndicator(
                        activeIndex: image_avtive_index,
                        count: p.image_url.length,
                        effect: ScrollingDotsEffect(
                          dotColor: Colors.grey[600]!,
                          activeDotColor: Colors.blue[600]!,
                          spacing: 5.0,
                          dotHeight: 6,
                          dotWidth: 6,
                          maxVisibleDots: 5,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Icon(FontAwesome.bookmark_o)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            // all likes view panel
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${p.likes} likes",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  SizedBox(height: 5.0),
                  MyRichText(text: p.caption)
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text("13 hours age",
                  style: TextStyle(color: Colors.grey, fontSize: 14)),
            ),
            SizedBox(height: 15.0),
          ],
        ),
      );
   
  

}
