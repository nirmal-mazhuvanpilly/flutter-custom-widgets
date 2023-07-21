import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:limoverse_widgets/community/overlay/reaction_overlay.dart';
import 'package:limoverse_widgets/community/widgets/expandable.dart';
import 'package:limoverse_widgets/utils.dart';
import 'package:lottie/lottie.dart';

class FeedsPage extends StatefulWidget {
  const FeedsPage({super.key});

  @override
  State<FeedsPage> createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController tabController;
  final ValueNotifier<int> selectedTabIndex = ValueNotifier<int>(0);

  final ColorTween firstColorTween = ColorTween(
    begin: HexColor("#353535"), // Gradient First Color
    end: HexColor("#E05A50"), // Disabled Color
  );
  final ColorTween secondColorTween = ColorTween(
    begin: HexColor("#353535"), //Gradient Second Color
    end: HexColor("#E1207C"), // Disabled Color
  );

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      selectedTabIndex.value = tabController.index;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            "Choose your category",
            style: TextStyle(color: HexColor("#8B8B8B"), fontSize: 14),
          ),
        ),
        const SizedBox(height: 14),
        ColoredBox(
            color: HexColor("#0D0D0D"),
            child: ValueListenableBuilder<int>(
              valueListenable: selectedTabIndex,
              builder: (context, value, child) {
                return TabBar(
                  controller: tabController,
                  isScrollable: true,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                  indicatorPadding: EdgeInsets.zero,
                  padding: const EdgeInsets.only(left: 9),
                  indicatorColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.label,
                  splashBorderRadius: BorderRadius.circular(100),
                  tabs: [
                    Tabs(
                      animation: tabController.animation!,
                      colorTweenList: [firstColorTween, secondColorTween],
                      currentIndex: 0,
                      child: const Center(
                        child: Text(
                          "All",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Tabs(
                      animation: tabController.animation!,
                      colorTweenList: [firstColorTween, secondColorTween],
                      currentIndex: 1,
                      child: const Center(
                        child: Text(
                          "HealthFi",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Tabs(
                      animation: tabController.animation!,
                      colorTweenList: [firstColorTween, secondColorTween],
                      currentIndex: 2,
                      child: const Center(
                        child: Text(
                          "Well Being",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Tabs(
                        animation: tabController.animation!,
                        colorTweenList: [firstColorTween, secondColorTween],
                        currentIndex: 3,
                        child: const Center(
                            child: Text(
                          "Modifi",
                          style: TextStyle(color: Colors.white),
                        )))
                  ],
                );
              },
            )),
        Expanded(
            child: TabBarView(
          controller: tabController,
          children: [
            const AllCommunity(),
            Container(color: Colors.red),
            Container(color: Colors.yellow),
            Container(color: Colors.orange),
          ],
        ))
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class Tabs extends StatelessWidget {
  const Tabs({
    super.key,
    required this.animation,
    required this.currentIndex,
    required this.colorTweenList,
    this.child,
  });

  final Animation<double> animation;

  final int currentIndex;
  final Widget? child;
  final List<ColorTween> colorTweenList;

  double _getAnimationValue(double value) {
    if (value < 0.0) {
      return 0.0;
    } else if (value > 1.0) {
      return 1.0;
    } else {
      return value;
    }
  }

  Decoration _getAnimatedDecoration({required double animationValue}) {
    return (animationValue < currentIndex)
        ? BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
                width: 1,
                color: HexColor("#8b8b8b").withOpacity(
                    _getAnimationValue(currentIndex - animationValue))),
            gradient: LinearGradient(colors: [
              // lerp method Returns the value this variable has at the given animation clock value.
              // ie, return value between 0.0 and 1.0

              ...colorTweenList
                  .map((e) => e.lerp(
                      _getAnimationValue(animationValue - (currentIndex - 1)))!)
                  .toList(),

              // firstColorTween.lerp(
              //     _getAnimationValue(animationValue - (currentIndex - 1)))!,
              // secondColorTween.lerp(
              //     _getAnimationValue(animationValue - (currentIndex - 1)))!,

              // Change Color with Opacity
              // HexColor("#E05A50").withOpacity(
              //     getAnimationValue(animationValue - (currentIndex - 1))),
              // HexColor("#E1207C").withOpacity(
              //     getAnimationValue(animationValue - (currentIndex - 1))),
            ]))
        : BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
                width: 1,
                color: HexColor("#8b8b8b").withOpacity(
                    _getAnimationValue(animationValue - currentIndex))),
            gradient: LinearGradient(colors: [
              // lerp method Returns the value this variable has at the given animation clock value.
              // ie, return value between 0.0 and 1.0

              ...colorTweenList
                  .map((e) => e.lerp(
                      _getAnimationValue((currentIndex + 1) - animationValue))!)
                  .toList(),

              // firstColorTween.lerp(
              //     _getAnimationValue((currentIndex + 1) - animationValue))!,
              // secondColorTween.lerp(
              //     _getAnimationValue((currentIndex + 1) - animationValue))!,

              // Change Color with Opacity
              // HexColor("#E05A50").withOpacity(
              //     getAnimationValue((currentIndex + 1) - animationValue)),
              // HexColor("#E1207C").withOpacity(
              //     getAnimationValue((currentIndex + 1) - animationValue)),
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        child: child,
        builder: (context, child) {
          final animationValue = animation.value;
          return Container(
            decoration: _getAnimatedDecoration(animationValue: animationValue),
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
            child: child,
          );
        });
  }
}

class AllCommunity extends StatelessWidget {
  const AllCommunity({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const PageStorageKey<String>("All"),
      addAutomaticKeepAlives: true,
      children: const [
        CommunityCard(),
        CommunityCard(),
        CommunityCard(),
        CommunityCard(),
        CommunityCard(),
        CommunityCard(),
      ],
    );
  }
}

class CommunityCard extends StatelessWidget {
  const CommunityCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const sampleText =
        """We are going live tomorrow at 11:00am to announce the winners Celebrate every milestone along the way, no matter how small that the prize. www.livehealthcaresolution.com""";
    return Container(
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 16).copyWith(bottom: 0),
        decoration: BoxDecoration(
            color: HexColor("#242424"),
            borderRadius: BorderRadius.circular(10)),
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://avatars.githubusercontent.com/u/85497740?s=400&u=8cfe7db1ab46f5f8b2d2d33148f1609e2f8da372&v=4"))),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Nirmal M M",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                            Text(
                              "Just now",
                              style: TextStyle(
                                  color: HexColor("#8B8B8B"), fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        height: 16.5,
                        width: 16.5,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/lottie/verified.png"))),
                      ),
                    ],
                  )),
                  Flexible(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          gradient: const LinearGradient(
                            colors: [Colors.orange, Colors.deepOrange],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: const Text(
                          "+ Join",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon:
                              const Icon(Icons.more_vert, color: Colors.white)),
                    ],
                  )),
                ],
              )),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: _ExpandedPost(sampleText: sampleText),
          ),
          const SizedBox(height: 20),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        SizedBox(
                          height: 16,
                          width: 16,
                          child: Lottie.asset("assets/lottie/lottieOne.json"),
                        ),
                        const SizedBox(width: 0),
                        SizedBox(
                          height: 16,
                          width: 16,
                          child: Lottie.asset("assets/lottie/lottieTwo.json"),
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            "You and 162 others",
                            style: TextStyle(
                                color: HexColor("#757575"), fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "12 Comments",
                      style:
                          TextStyle(color: HexColor("#757575"), fontSize: 12),
                    ),
                  ),
                ],
              )),
          const SizedBox(height: 13),
          Container(
            width: double.maxFinite,
            height: 1,
            color: HexColor("#FFFFFF").withOpacity(.20),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ReactionButton(
                        child: Container(
                          color: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 17),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                                width: 20,
                                child: Icon(
                                  Icons.favorite_outline_sharp,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Like",
                                style: TextStyle(
                                    color: HexColor("#757575"), fontSize: 13),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                            width: 20,
                            child: Icon(
                              Icons.mode_comment_outlined,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Comment",
                            style: TextStyle(
                                color: HexColor("#757575"), fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                          const SizedBox(
                            height: 20,
                            width: 20,
                            child: Icon(
                              Icons.share,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Share",
                            style: TextStyle(
                                color: HexColor("#757575"), fontSize: 13),
                          ),
                        ])),
                  ])),
        ]));
  }
}

class _ExpandedPost extends StatefulWidget {
  const _ExpandedPost({
    required this.sampleText,
  });

  final String sampleText;

  @override
  State<_ExpandedPost> createState() => _ExpandedPostState();
}

class _ExpandedPostState extends State<_ExpandedPost>
    with AutomaticKeepAliveClientMixin {
  final ExpandableController expandableController = ExpandableController();

  @override
  void dispose() {
    expandableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ExpandablePanel(
      controller: expandableController,
      theme: const ExpandableThemeData(crossFadePoint: 0),
      collapsed: GestureDetector(
        onTap: () {
          expandableController.toggle();
        },
        child: Linkify(
          onOpen: (link) {
            // print("*****");
            // print("Clicked ${link.url}!");
          },
          text:
              "${widget.sampleText.substring(0, (widget.sampleText.length * .75).round())}... see more",
          softWrap: true,
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
          linkStyle: TextStyle(
              decoration: TextDecoration.none,
              color: HexColor("#397BDE"),
              fontSize: 14),
          style: const TextStyle(
              decoration: TextDecoration.none,
              color: Colors.white,
              fontSize: 14),
        ),
      ),
      expanded: Linkify(
        onOpen: (link) {
          // print("*****");
          // print("Clicked ${link.url}!");
        },
        text: widget.sampleText,
        linkStyle: TextStyle(
            decoration: TextDecoration.none,
            color: HexColor("#397BDE"),
            fontSize: 14),
        style: const TextStyle(
            decoration: TextDecoration.none, color: Colors.white, fontSize: 14),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
