import 'package:flutter/material.dart';
import 'package:limoverse_widgets/community/announcement.dart';
import 'package:limoverse_widgets/community/feeds_page.dart';
import 'package:limoverse_widgets/utils.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: HexColor("#0D0D0D"),
      appBar: AppBar(
        title: const Text(
          "Community",
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Material(
              color: HexColor("#161616"),
              child: SizedBox(
                height: 51,
                child: TabBar(
                  controller: tabController,
                  indicatorColor: HexColor("#F66B24"),
                  indicatorPadding: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    return states.contains(MaterialState.focused)
                        ? null
                        : Colors.white.withOpacity(.06);
                  }),
                  tabs: const [
                    SizedBox(
                        height: double.maxFinite,
                        width: double.maxFinite,
                        child: Center(
                            child: Text(
                          "Feeds",
                          style: TextStyle(fontSize: 16),
                        ))),
                    SizedBox(
                        height: double.maxFinite,
                        width: double.maxFinite,
                        child: Center(
                            child: Text(
                          "Announcement",
                          style: TextStyle(fontSize: 16),
                        ))),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(controller: tabController, children: const [
                FeedsPage(),
                AnnouncementPage(),
              ]),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
