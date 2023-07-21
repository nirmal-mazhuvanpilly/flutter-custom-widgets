import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:limoverse_widgets/community/widgets/expandable.dart';
import 'package:limoverse_widgets/utils.dart';

class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({super.key});

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const AllCommunity();
  }

  @override
  bool get wantKeepAlive => true;
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
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 48,
                        width: 48,
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
                              "Limoverse",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Just now",
                              style: TextStyle(
                                  color: HexColor("#8B8B8B"), fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                  Flexible(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_vert,
                              color: Colors.white))),
                ],
              )),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: _ExpandedPost(sampleText: sampleText),
          ),
          const SizedBox(height: 24),
          Column(
            children: [
              Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.width * .9227,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://footwearnews.com/wp-content/uploads/2022/12/SP33-Pippen-Modernist-01.jpg?w=1024&h=686&crop=1"))),
              ),
              Material(
                color: HexColor("#171717"),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: InkWell(
                  onTap: () {},
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  splashColor: Colors.white.withOpacity(.06),
                  highlightColor: Colors.white.withOpacity(.03),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.share,
                          color: HexColor("#757575"),
                          size: 18,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Just now",
                          style: TextStyle(
                              color: HexColor("#757575"), fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
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
