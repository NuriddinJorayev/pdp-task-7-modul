import 'package:flutter/material.dart';

class MyLikesPage extends StatefulWidget {
  const MyLikesPage({Key? key}) : super(key: key);

  @override
  State<MyLikesPage> createState() => _MyLikesPageState();
}

class _MyLikesPageState extends State<MyLikesPage> {
  String img1 =
      "https://www.perma-horti.com/wp-content/uploads/2019/02/image-2.jpg";
  String img2 = "https://ychef.files.bbci.co.uk/976x549/p0738j5f.jpg";


  @override
  Widget build(BuildContext context) {
    // var allsize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(child: Text("data"),),
    );
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: Colors.white,
  //       elevation: 0.0,
  //       centerTitle: true,
  //       title: Text("Likes",
  //           style: TextStyle(
  //               color: Colors.black,
  //               fontFamily: 'Billbong_family',
  //               fontSize: 40)),
  //     ),
  //     body: Container(
  //       height: allsize.height,
  //       width: allsize.width,
  //       child: ListView.builder(
  //           itemCount: All_posts.length,
  //           itemBuilder: (BuildContext con, int index) {
  //             if (All_posts[index].isliked) {
  //               return post_items_builder(All_posts[index]);
  //             } else
  //               return SizedBox.shrink();
  //           }),
  //     ),
  //   );
  // }
  }
  double image_size = 300.0;
  var page_con = PageController();
  int image_avtive_index = 0;

// post items builder function
  // Widget post_items_builder(Post p) => Container(
  //       width: MediaQuery.of(context).size.width,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           MyFeedUserPanel(
  //             title: "Username",
  //             subtitle: "2020-01-20",
  //             user_image: p.user_image,
  //           ),
  //           // base image
  //           p.image_url.length == 1
  //               ? CachedNetworkImage(
  //                   width: MediaQuery.of(context).size.width,
  //                   imageUrl: p.image_url[0],
  //                   fit: BoxFit.cover,
  //                   placeholder: (context, url) =>
  //                       Center(child: CircularProgressIndicator()),
  //                   errorWidget: (context, url, error) =>
  //                       Center(child: Icon(Icons.error)),
  //                   imageBuilder: (con, _image_provider) => InstaLikeButton(
  //                       width: MediaQuery.of(context).size.width,
  //                       image: _image_provider,
  //                       imageBoxfit: BoxFit.cover,
  //                       iconSize: 100,
  //                       onChanged: () {
  //                         setState(() {
  //                           if (!p.isliked) {
  //                             p.isliked = true;
  //                             p.likes = (int.parse(p.likes) + 1).toString();
  //                           }
  //                         });
  //                       }))
  //               : Container(
  //                   width: MediaQuery.of(context).size.width,
  //                   height: image_size,
  //                   child: PageView.builder(
  //                     controller: page_con,
  //                     onPageChanged: (int i) {
  //                       setState(() {
  //                         image_avtive_index = i;
  //                       });
  //                     },
  //                     itemCount: p.image_url.length,
  //                     itemBuilder: (con, int index) {
  //                       return CachedNetworkImage(
  //                           width: MediaQuery.of(context).size.width,
  //                           imageUrl: p.image_url[index],
  //                           fit: BoxFit.cover,
  //                           placeholder: (context, url) =>
  //                               Center(child: CircularProgressIndicator()),
  //                           errorWidget: (context, url, error) =>
  //                               Center(child: Icon(Icons.error)),
  //                           imageBuilder: (con, _image_provider) =>
  //                               InstaLikeButton(
  //                                   width: MediaQuery.of(context).size.width,
  //                                   image: _image_provider,
  //                                   imageBoxfit: BoxFit.cover,
  //                                   iconSize: 100,
  //                                   onChanged: () {
  //                                     setState(() {
  //                                       if (!p.isliked) {
  //                                         p.isliked = true;
  //                                         p.likes = (int.parse(p.likes) + 1)
  //                                             .toString();
  //                                       }
  //                                     });
  //                                   }));
  //                     },
  //                   ),
  //                 ),
  //           SizedBox(height: 5.0),
  //           Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 15.0),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [

  //                 Expanded(
  //                   child: Row(
  //                     children: [
  //                       // like button
  //                       InkResponse(
  //                         onTap: () {
  //                           setState(() {
  //                             if (p.isliked) {
  //                               p.isliked = false;
  //                               p.likes = (int.parse(p.likes) - 1).toString();
  //                             } else {
  //                               p.isliked = true;
  //                               p.likes = (int.parse(p.likes) + 1).toString();
  //                             }
  //                           });
  //                         },
  //                         child: AnimatedContainer(
  //                           duration: Duration(milliseconds: 500),
  //                           child: p.isliked
  //                               ? Icon(FontAwesome.heart,
  //                                   size: 23.0, color: Colors.red)
  //                               : Icon(Feather.heart, size: 23.0),
  //                         ),
  //                       ),
                  
  //                       SizedBox(width: 15.0),
  //                       Icon(FontAwesome.comment_o),
  //                       SizedBox(width: 15.0),
  //                       Transform.rotate(
  //                         angle: 3.14 / 10,
  //                         child: Icon(Feather.send),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 // image  indecator
  //                 Expanded(
  //                   child: Container(
  //                     alignment: Alignment.center,
  //                     child: AnimatedSmoothIndicator(
  //                       activeIndex: image_avtive_index,
  //                       count: p.image_url.length,
  //                       effect: ScrollingDotsEffect(
  //                         dotColor: Colors.grey[600]!,
  //                         activeDotColor: Colors.blue[600]!,
  //                         spacing: 5.0,
  //                         dotHeight: 6,
  //                         dotWidth: 6,
  //                         maxVisibleDots: 5,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 Expanded(
  //                   child: Container(
  //                     alignment: Alignment.centerRight,
  //                     child: Icon(FontAwesome.bookmark_o)),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           SizedBox(height: 10.0),
  //           // all likes view panel
  //           Container(
  //             padding: EdgeInsets.symmetric(horizontal: 10),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   "${p.likes} likes",
  //                   style: TextStyle(
  //                       color: Colors.black,
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 17),
  //                 ),
  //                 SizedBox(height: 5.0),
  //                 MyRichText(text: p.caption)
  //               ],
  //             ),
  //           ),
  //           SizedBox(height: 10.0),
  //           Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 10.0),
  //             child: Text("13 hours age",
  //                 style: TextStyle(color: Colors.grey, fontSize: 14)),
  //           ),
  //           SizedBox(height: 15.0),
  //         ],
  //       ),
  //     );
 
  }
