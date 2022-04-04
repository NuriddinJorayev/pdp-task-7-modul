import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_myinsta/models/myUser.dart';
import 'package:flutter_myinsta/widgets/search_textfield.dart';
import 'package:flutter_svg/svg.dart';

class My_Follow_page extends StatefulWidget {
  final List<MyUser> followers;
  final List<MyUser> following;
  const My_Follow_page(
      {Key? key, required this.followers, required this.following})
      : super(key: key);

  @override
  State<My_Follow_page> createState() => _My_Follow_pageState();
}

class _My_Follow_pageState extends State<My_Follow_page>
    with TickerProviderStateMixin {
  late TabController tab_con;
  var page_con = PageController(initialPage: 1);
  int page_index = 0;

  @override
  void initState() {
    super.initState();
    tab_con = TabController(length: 2, vsync: this, initialIndex: 1);
    tab_con.addListener(() {
      if (page_index != tab_con.index)
        setState(() {
          page_index = tab_con.index;
        });
      page_con.animateToPage(page_index,
          duration: Duration(milliseconds: 100), curve: Curves.linear);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            backgroundColor: Colors.white,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(AntDesign.arrowleft, color: Colors.black)),
            bottom: TabBar(
              controller: tab_con,
              unselectedLabelColor: Colors.black54,
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              indicatorWeight: 1.6,
              indicatorPadding: EdgeInsets.only(bottom: 1),
              tabs: [
                Tab(
                  child:
                      Text(widget.followers.length.toString() + ' Followers'),
                ),
                Tab(
                  child:
                      Text(widget.following.length.toString() + ' Following'),
                ),
              ],
            ),
          ),
          body: PageView(
            controller: page_con,
            pageSnapping: true,
            onPageChanged: (i) {
              setState(() {
                page_index = i;
              });
              tab_con.animateTo(i,
                  duration: Duration(milliseconds: 100), curve: Curves.linear);
            },
            children: [
              SingleChildScrollView(child: page_one(true)),
              SingleChildScrollView(child: page_tow(true)),
            ],
          ),
        ));
  }

  Widget page_one(bool isfollowed) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Sreach_Textfield(),
        SizedBox(height: 20),
        text_build("Categories"),
        SizedBox(height: 10),
        Circle_avatar_d("Accounts You Don't Follow Back", "qwer nad 12 others"),
        Circle_avatar_d("Last Interacted With", "qwertyui nad 32 others"),
        // divider
        Container(
          color: Colors.black.withAlpha(30),
          margin: EdgeInsets.only(top: 1, bottom: 15),
          height: 1,
          width: double.infinity,
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: text_build("All followers"),
        ),
        // first page users list
        for (var e in widget.followers)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Circle_avatar_o(
                "Remove", e.userName, e.name, e.user_image, true),
          ),
      ],
    );
  }

  Widget page_tow(bool isfollowed) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Sreach_Textfield(),
        SizedBox(height: 20),
        text_build("Categories"),
        SizedBox(height: 10),
        Circle_avatar_d("Last Interacted With", "qwertyui nad 32 others"),
        Circle_avatar_d("Most Shown in Feed", "qwer nad 12 others"),
        // divider
        Container(
          color: Colors.black.withAlpha(30),
          margin: EdgeInsets.only(top: 1, bottom: 15),
          height: 1,
          width: double.infinity,
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Text('Sorted by ', style: TextStyle(fontSize: 16)),
                    Text('Default',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Container(
                height: 20,
                width: 20,
                child: SvgPicture.asset("assets/images/SVGs/sort.svg"),
              )
            ],
          ),
        ),
        for (var e in widget.following)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Circle_avatar_o(
                "Following", e.userName, e.name, e.user_image, false, true),
          )
      ],
    );
  }

  Widget remove_button(String button_text) => Row(
        children: [
          Expanded(child: SizedBox.shrink()),
          Container(
            height: 28,
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey, width: 1)),
            child: Text(button_text,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .5)),
          ),
        ],
      );

  Widget user_name(String name, [bool isusername = false]) => Text(
        name,
        style: TextStyle(
            color: isusername ? Colors.black : Colors.grey[600],
            fontWeight: isusername ? FontWeight.bold : FontWeight.normal),
      );

  Widget text_build(String text, [FontWeight ww = FontWeight.bold]) =>
      Container(
        padding: EdgeInsets.only(left: 15),
        alignment: Alignment.centerLeft,
        child: Text(text,
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
      );

  Widget Circle_avatar_o(
      String r_button, String username, String name, String user_img_url,
      [bool isfollowed = false, bool more = false]) {
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          margin: EdgeInsets.fromLTRB(15, 0, 10, 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              image: DecorationImage(
                  image: NetworkImage(user_img_url), fit: BoxFit.fill)),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            !isfollowed
                ? user_name(username, true)
                : Row(
                    children: [
                      user_name(username, true),
                      Text(' \u2022 '),
                      Text('Follow',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w600)),
                    ],
                  ),
            user_name(name),
          ],
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: remove_button(r_button),
          ),
        ),
        more
            ? Container(
                margin: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ))
            : SizedBox.shrink()
      ],
    );
  }

  Widget Circle_avatar_d(text1, text2) {
    return Row(
      children: [
        Container(
          height: 65,
          width: 80,
          // color: Colors.grey,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Transform.translate(
                offset: Offset(-7, -5),
                child: Container(
                  height: 40,
                  width: 40,
                  margin: EdgeInsets.fromLTRB(15, 0, 10, 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://funkylife.in/wp-content/uploads/2021/06/whatsapp-dp-pic-8-scaled.jpg"),
                          fit: BoxFit.fill)),
                ),
              ),
              Transform.translate(
                offset: Offset(7, 5),
                child: Container(
                  height: 42,
                  width: 42,
                  margin: EdgeInsets.fromLTRB(15, 0, 10, 0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2.5),
                      borderRadius: BorderRadius.circular(40),
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://cdn.statusqueen.com/dpimages/thumbnail/dp_images_8-1279.jpg"),
                          fit: BoxFit.fill)),
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            user_name(text1, true),
            user_name(text2),
          ],
        )
      ],
    );
  }
}
