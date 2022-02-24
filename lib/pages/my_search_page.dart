
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_myinsta/functions/page_control.dart';
import 'package:flutter_myinsta/models/myUser.dart';
import 'package:flutter_myinsta/pages/sreach_page/other_user_view.dart';
import 'package:flutter_myinsta/pages/sreach_page/search_page_two.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// ignore: must_be_immutable
class MySearchPage extends StatefulWidget {
  MyUser? user;
   MySearchPage({Key? key, this.user}) : super(key: key);
   MySearchPage.from({Key? key, this.user}) : super(key: key);

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  List list = [
    "https://cdn.pixabay.com/photo/2018/08/14/13/23/ocean-3605547__340.jpg",
    "https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072821__340.jpg",
    "https://cdn.pixabay.com/photo/2016/12/16/15/25/christmas-1911637__340.jpg",
    "https://cdn.pixabay.com/photo/2017/02/08/17/24/fantasy-2049567__340.jpg",
    "https://cdn.pixabay.com/photo/2016/06/02/02/33/triangles-1430105__340.png",
    "https://cdn.pixabay.com/photo/2018/08/21/23/29/forest-3622519__340.jpg",
    "https://cdn.pixabay.com/photo/2017/10/26/19/45/red-2892235__340.png",
    "https://cdn.pixabay.com/photo/2018/09/23/18/30/drop-3698073__340.jpg",
    "https://cdn.pixabay.com/photo/2015/04/19/08/32/rose-729509__340.jpg",
    "https://cdn.pixabay.com/photo/2015/12/09/01/02/mandalas-1084082__340.jpg",
    "https://cdn.pixabay.com/photo/2017/08/30/01/05/milky-way-2695569__340.jpg",
    "https://cdn.pixabay.com/photo/2018/08/23/07/35/thunderstorm-3625405__340.jpg",
    "https://cdn.pixabay.com/photo/2016/05/05/02/37/sunset-1373171__480.jpg",
    "https://cdn.pixabay.com/photo/2017/12/15/13/51/polynesia-3021072__480.jpg",
    "https://cdn.pixabay.com/photo/2016/10/20/18/35/earth-1756274__480.jpg",
    "https://cdn.pixabay.com/photo/2016/11/29/13/37/christmas-1869902__480.jpg",
    "https://cdn.pixabay.com/photo/2017/05/09/03/46/alberta-2297204__480.jpg",
    "https://cdn.pixabay.com/photo/2017/10/10/16/55/halloween-2837936__480.png",
    "https://cdn.pixabay.com/photo/2016/10/21/14/50/plouzane-1758197__480.jpg",
    "https://cdn.pixabay.com/photo/2017/08/15/08/23/stars-2643089__480.jpg",
    "https://cdn.pixabay.com/photo/2017/07/03/20/17/colorful-2468874__480.jpg",
    "https://cdn.pixabay.com/photo/2018/02/08/22/27/flower-3140492__480.jpg",
    "https://cdn.pixabay.com/photo/2014/09/14/18/04/dandelion-445228__480.jpg",
    "https://cdn.pixabay.com/photo/2017/06/23/17/46/desert-2435404__480.jpg",
    "https://cdn.pixabay.com/photo/2018/01/30/22/50/forest-3119826__480.jpg",
    "https://cdn.pixabay.com/photo/2011/12/14/12/21/orion-nebula-11107__480.jpg",
    "https://cdn.pixabay.com/photo/2016/04/18/22/05/seashells-1337565__480.jpg",
    "https://cdn.pixabay.com/photo/2018/01/12/10/19/fantasy-3077928__480.jpg",
    "https://cdn.pixabay.com/photo/2018/10/01/09/21/pets-3715733__480.jpg",
    "https://cdn.pixabay.com/photo/2022/01/08/14/09/mont-saint-michel-6924072__480.jpg",
    "https://cdn.pixabay.com/photo/2017/10/10/07/48/hills-2836301__480.jpg",
    "https://cdn.pixabay.com/photo/2013/12/17/20/10/bubbles-230014__480.jpg",
    "https://cdn.pixabay.com/photo/2016/09/29/13/08/planet-1702788__480.jpg",
    "https://cdn.pixabay.com/photo/2021/11/13/23/06/tree-6792528__480.jpg",
  ];
  double appbar_hight = 50;
  double tt = 0;
  RefreshController scroll_controller = RefreshController();
  var control1 = ScrollController();
  var control2 = ScrollController();
  var control_textfield = TextEditingController();
  double last_offset = 0.0;
  var page_control = PageController();
  var tempUser ;

  Future<bool> system_back_function() async {
    MyPage_Controller.go_page(0);
    return false;
  }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    scroll_controller.refreshCompleted();
  }
  Future<void> onBottem_loading() async {
    await Future.delayed(Duration(seconds: 2));
    scroll_controller.loadComplete();
  }

  go_page(int i){   
     WidgetsBinding.instance?.addPostFrameCallback((_) {
                      if (page_control.hasClients){
                        page_control.animateToPage(i,
                            duration: Duration(milliseconds: 1),
                            curve: Curves.linear);
                      }
                    });
  }

  @override
  void initState() {
    super.initState();    
    control2.addListener(() {
      print(control2.position.pixels);
      setState(() {
        if (control2.position.pixels <= 60 && control2.position.pixels >= -10) {
          control1.jumpTo(control2.position.pixels.abs());
        } else if (control2.position.pixels >= 60) {
          control1.jumpTo(50);
        }
      });
      // control1.animateTo(control2.offset , duration: Duration(milliseconds: 100), curve: Curves.easeInBack );
    });
  }

  @override
  Widget build(BuildContext context) {
    var allSize = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).viewPadding.top;

    return WillPopScope(
      onWillPop: system_back_function,
      child: PageView(
        controller: page_control,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Scaffold(
            body: SingleChildScrollView(
              controller: control1,
              child: Container(
                height: allSize.height,
                width: allSize.width,
                child: Column(
                  children: [
                    Container(
                      height: height + height,
                      width: allSize.width,
                      color: Colors.grey,
                      alignment: Alignment.bottomCenter,
                      // textfiel parent
                      child: Container(
                        padding: EdgeInsets.only(left: 15, right: 20),
                        height: height,
                        width: allSize.width,
                        color: Colors.white,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.withOpacity(.3),
                          ),
                          // textfield
                          child: GestureDetector(
                            onTap: (){
                                go_page(1);
                                setState(() {
                                  
                                });
                              },
                            child: TextField(                                                        
                            enabled: false,
                              controller: control_textfield,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: .8,
                                  height: 1.5),
                              cursorColor: Colors.black,
                              cursorWidth: 1,
                              cursorHeight: 30,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    FlutterIcons.search_fea,
                                    color: Colors.black,
                                    size: 19,
                                  ),
                                  border: InputBorder.none,
                                  hintText: "Search",
                                  hintStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withAlpha(150),
                                      letterSpacing: .8,
                                      height: 1.2)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SmartRefresher(
                        controller: scroll_controller,
                        enablePullUp: true,
                        
                        header: ClassicHeader(
                        
                            idleText: '',
                            releaseText: "",
                            failedText: '',
                            completeText: '',
                            refreshingText: '',
                            canTwoLevelText: '',
                            refreshingIcon: CircularProgressIndicator(
                              color: Colors.grey[400],
                              strokeWidth: 2,
                            )),

                       
                        footer: ClassicFooter(  
                          idleText: "",
                          failedText: "",
                          noDataText: "",
                          loadingText: "",
                          canLoadingText: "",  
                          idleIcon: Container(
                            height: 50,
                            width: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.8
                              ),
                              shape: BoxShape.circle
                            ),
                            child: Icon(Feather.plus, size: 25, color: Colors.grey,),

                          ),    
                          onClick: (){
                            scroll_controller.requestLoading();
                          },             
                          failedIcon: Container(
                            height: 50,
                            width: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.8
                              ),
                              shape: BoxShape.circle
                            ),
                            child: Icon(Feather.plus, size: 25, color: Colors.grey,),

                          ), 
                          loadingIcon:  Container(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(                        
                                color: Colors.grey[400],
                                strokeWidth: 2,
                              
                              ),
                          ),
                        ),

                         onLoading: onBottem_loading,  
                         onTwoLevel: (bool l){
                           
                         },                
                        onRefresh: onRefresh,
                        
                        child: ListView(
                          controller: control2,
                          children: _all_items(
                              allSize.height * .17, (allSize.width / 3) - 1, list),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SearchPageTwo(page_control: page_control,),
          OtherUserview(pageController: page_control,)
        ],
      ),
    );
  }


  List<Widget> _all_items(size1, size2, List l) {
    int counter = 0;
    int amount = 3;
    bool isRight = false;

    List<Widget> get_list = [];
    List temp_list = [];
    for (int i = 0; i < l.length; i++) {
      temp_list.add(l[i]);
      if (((i+1) - counter) == amount) {
        // three panel
        if (amount == 3) {
          isRight = !isRight;
          counter = i+1;
          amount = amount == 3 ? 6 : 3;
          get_list.add(_item_treeple(size1, size2, isRight, temp_list));
          temp_list = [];
          // wrap panel
        } else if (amount == 6) {
          counter = i+1;
          amount = amount == 3 ? 6 : 3;
          get_list.add(Wrap(
            children:
                temp_list.map((e) => _item_Of_list(size1, size2, e)).toList(),
          ));

          temp_list = [];
        }
      }
      if ((i) == l.length-1) {
      
            get_list.add(Wrap(children: temp_list.map((e) => _item_Of_list(size1, size2, e)).toList()));
        temp_list = [];
       
        
      
      }
    }
    return get_list;
  }

  Widget _item_Of_list(size1, size2, String url) => Container(
        margin: EdgeInsets.all(.5),
        height: size1,
        width: size2,        
        child: Center(
          child: CachedNetworkImage(
              height: size1,
        width: size2, 
            fit: BoxFit.fill,
            imageUrl: url,
            errorWidget: (BuildCont, sgdhjkl, fghj)=>Container(color: Colors.grey[200],),
            placeholder: (BuildCont, sgdhjkl)=>Container(),
          )
        ),
      );


  Widget _item_treeple(size1, size2, bool  isright,   url) => Row(
        children: isright ? [
          Column(
            children: [
              _item_Of_list(size1, size2, url[0]),
              _item_Of_list(size1, size2, url[1]),
            ],
          ),
          Container(
            margin: EdgeInsets.all(.5),
            height: (size1 + size1) + 1,
            width: (size2 + size2) + 1,
            child: CachedNetworkImage(              
               fit: BoxFit.fill,
              imageUrl: url[2],
               errorWidget: (BuildCont, sgdhjkl, fghj)=>Container(color: Colors.grey[200],),
            placeholder: (BuildCont, sgdhjkl)=>Container(),
            height:  (size1 + size1) + 1,
            width:   (size2 + size2) + 1,
            ),
          )
        ]: [          
          Container(
            margin: EdgeInsets.all(.5),
            height: (size1 + size1) + 1,
            width: (size2 + size2) + 1,
            child: CachedNetworkImage(              
               fit: BoxFit.fill,
              imageUrl: url[2],
               errorWidget: (BuildCont, sgdhjkl, fghj)=>Container(color: Colors.grey[200],),
            placeholder: (BuildCont, sgdhjkl)=>Container(),
            height:  (size1 + size1) + 1,
            width:   (size2 + size2) + 1,
            ),
          ),
          Column(
            children: [
              _item_Of_list(size1, size2, url[0]),
              _item_Of_list(size1, size2, url[1]),
            ],
          ),
        ]
      );

  PreferredSizeWidget appbar(Size size) => PreferredSize(
        child: Container(
          color: Colors.redAccent,
          child: Center(child: Text("data")),
        ),
        preferredSize: size,
      );
  



}
