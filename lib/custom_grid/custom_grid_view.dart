import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:limoverse_widgets/custom_grid/nft_details.dart';

class CustomGridView extends StatefulWidget {
  const CustomGridView({super.key});

  @override
  State<CustomGridView> createState() => _CustomGridViewState();
}

class _CustomGridViewState extends State<CustomGridView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
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
      appBar: AppBar(
        title: const Text("Market Place"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            color: Colors.black,
            child: SizedBox(
              height: 51,
              child: TabBar(
                controller: tabController,
                indicatorColor: Colors.transparent,
                indicatorPadding: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                isScrollable: true,
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  return states.contains(MaterialState.focused)
                      ? null
                      : Colors.white.withOpacity(.06);
                }),
                tabs: const [
                  TabItem(name: "All"),
                  TabItem(name: "Basic"),
                  TabItem(name: "Standard"),
                  TabItem(name: "Pro"),
                  TabItem(name: "Ultra"),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(controller: tabController, children: const [
              TabViewItem(pageStorageKey: PageStorageKey<String>("All")),
              TabViewItem(pageStorageKey: PageStorageKey<String>("Basic")),
              TabViewItem(pageStorageKey: PageStorageKey<String>("Standard")),
              TabViewItem(pageStorageKey: PageStorageKey<String>("Pro")),
              TabViewItem(pageStorageKey: PageStorageKey<String>("Ultra")),
            ]),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class TabItem extends StatelessWidget {
  final String? name;
  const TabItem({
    super.key,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: double.maxFinite,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Text(
            name ?? "",
            style: const TextStyle(fontSize: 14),
          ),
        )));
  }
}

class TabViewItem extends StatelessWidget {
  final Key? pageStorageKey;
  const TabViewItem({super.key, this.pageStorageKey});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: LayoutBuilder(builder: (context, constraints) {
        final halfWidth = constraints.maxWidth / 2; // Half of available space
        final textScaleFactor =
            MediaQuery.of(context).textScaleFactor; // Device TextScale factor
        const bufferHeight =
            10.0; // Additional Buffer height to avoid overflow issues
        const verticalPaddingHeight =
            7.0; // Explore Button vertical padding height
        const spacing = 10.0; // Space between widgets
        const crossAxisSpacing = 15.0;
        final imageContainerHeight = (halfWidth - (crossAxisSpacing / 2));

        const headingTextSize = 12.0;
        const headingTextMaxLines = 2;
        const currencyTextSize = 16.0;

        // Total MainAxis height calculated basis on above factors
        final mainAxisExtent = (imageContainerHeight +
            spacing +
            spacing +
            bufferHeight +
            (((headingTextSize + 2) * headingTextMaxLines) +
                (currencyTextSize + 2)) +
            textScaleFactor +
            ((((headingTextSize + 2) * 2) + (currencyTextSize + 2)) *
                    (textScaleFactor - 1))
                .round()
                .abs() +
            (verticalPaddingHeight * 2));

        final imageDiskCache =
            (imageContainerHeight * MediaQuery.of(context).devicePixelRatio)
                .toInt();

        return GridView.builder(
            key: pageStorageKey,
            padding: const EdgeInsets.symmetric(vertical: 10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: mainAxisExtent,
                crossAxisSpacing: crossAxisSpacing,
                mainAxisSpacing: 22),
            itemCount: 100,
            itemBuilder: (BuildContext context, int index) {
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => NftDetails()));
                  },
                  splashColor: Colors.white.withOpacity(.06),
                  highlightColor: Colors.white.withOpacity(.03),
                  borderRadius: BorderRadius.circular(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: imageContainerHeight,
                        width: double.maxFinite,
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://vo.limoverse.io/_ipx/w_1920,q_75/https%3A%2F%2Flimoverse.mypinata.cloud%2Fipfs%2FQmRyTGMKabGkCVGtrNGKwB16zfqpqf4zgf8oEiF2Rn3JjT?url=https%3A%2F%2Flimoverse.mypinata.cloud%2Fipfs%2FQmRyTGMKabGkCVGtrNGKwB16zfqpqf4zgf8oEiF2Rn3JjT&w=1920&q=75",
                          maxHeightDiskCache: imageDiskCache,
                          maxWidthDiskCache: imageDiskCache,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      fit: BoxFit.cover, image: imageProvider)),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: spacing),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Limo Sneaker NFT \n#4EI35",
                          maxLines: headingTextMaxLines,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: headingTextSize,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      const SizedBox(height: spacing),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text(
                                "\$ 9.3",
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: currencyTextSize,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: verticalPaddingHeight,
                                  horizontal: 10),
                              child: const Text(
                                "Explore",
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      }),
    );
  }
}
