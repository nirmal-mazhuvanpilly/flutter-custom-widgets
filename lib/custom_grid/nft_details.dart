import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:limoverse_widgets/custom_grid/custom_expanded_widget.dart';
import 'package:limoverse_widgets/utils.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class NftDetails extends StatelessWidget {
  NftDetails({
    Key? key,
  }) : super(key: key);

  final appBar = AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    flexibleSpace: ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(.50),
                Colors.black.withOpacity(.10),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
    ),
    title: const Text(
      "NFT Details",
      style: TextStyle(color: Colors.white),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: appBar.preferredSize.height +
                  (MediaQuery.of(context).padding.top * 1),
            ),
            Container(
              height: size.width * 1.2533,
              color: Colors.black,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        "https://vo.limoverse.io/_ipx/w_1920,q_75/https%3A%2F%2Flimoverse.mypinata.cloud%2Fipfs%2FQmRyTGMKabGkCVGtrNGKwB16zfqpqf4zgf8oEiF2Rn3JjT?url=https%3A%2F%2Flimoverse.mypinata.cloud%2Fipfs%2FQmRyTGMKabGkCVGtrNGKwB16zfqpqf4zgf8oEiF2Rn3JjT&w=1920&q=75",
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: size.width * 1.2530,
                        foregroundDecoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.black,
                                Colors.black.withOpacity(.25),
                                Colors.transparent,
                                Colors.transparent,
                                Colors.transparent,
                                Colors.transparent,
                                Colors.transparent,
                                Colors.black.withOpacity(.25),
                                Colors.black,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover, image: imageProvider)),
                      );
                    },
                    placeholder: (context, url) {
                      return Container(
                        height: size.width * 1.2533,
                        color: Colors.black,
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Limo Sneaker NFT #4E135",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 26),
                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.10),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  topRight: Radius.circular(100),
                                  bottomRight: Radius.circular(100),
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 14),
                                    child: Text(
                                      "Efficiency Index",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: SizedBox.square(
                                    dimension: 60,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SfRadialGauge(
                                          axes: <RadialAxis>[
                                            RadialAxis(
                                              startAngle: 90,
                                              endAngle: 450,
                                              minimum: 0,
                                              maximum: 60,
                                              showLabels: false,
                                              showTicks: false,
                                              axisLineStyle: AxisLineStyle(
                                                thickness: 0.12,
                                                cornerStyle:
                                                    CornerStyle.bothCurve,
                                                color: HexColor("#3B3E44"),
                                                thicknessUnit:
                                                    GaugeSizeUnit.factor,
                                              ),
                                              pointers: const <GaugePointer>[
                                                RangePointer(
                                                  enableAnimation: true,
                                                  gradient:
                                                      SweepGradient(colors: [
                                                    Colors.red,
                                                    Colors.orange,
                                                  ]),
                                                  value: 30,
                                                  cornerStyle:
                                                      CornerStyle.bothCurve,
                                                  width: 0.12,
                                                  sizeUnit:
                                                      GaugeSizeUnit.factor,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Text(
                                          "30",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Attributes(
                  attributes: const ["high", "low", "medium", "high"]),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: CustomExpandedWidget(
                backgroundColor: Colors.transparent,
                dividerColor: Colors.transparent,
                expandedWidget: Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: Text(
                      "ASICS special edition. JAPAN S, NFT sneaker,use it in HealthFi to move2earn",
                      style:
                          TextStyle(color: HexColor("#8B8B8B"), fontSize: 14)),
                ),
                child: const Text("Description",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 22),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              height: 1,
              width: double.maxFinite,
              color: HexColor("#242730"),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Flexible(
                    child: Text("More Collection",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                  Flexible(
                    child: Text("View All",
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, constraints) {
                final halfWidth = (constraints.maxWidth / 2) -
                    14.5; // Half of available space
                final textScaleFactor = MediaQuery.of(context)
                    .textScaleFactor; // Device TextScale factor
                const bufferHeight =
                    10.0; // Additional Buffer height to avoid overflow issues
                const verticalPaddingHeight =
                    7.0; // Explore Button vertical padding height
                const spacing = 10.0; // Space between widgets
                const crossAxisSpacing = 15.0;
                final imageContainerHeight =
                    (halfWidth - (crossAxisSpacing / 2));

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

                final imageDiskCache = (imageContainerHeight *
                        MediaQuery.of(context).devicePixelRatio)
                    .toInt();
                return SizedBox(
                  height: mainAxisExtent,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    itemBuilder: (context, index) {
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NftDetails()));
                          },
                          splashColor: Colors.white.withOpacity(.06),
                          highlightColor: Colors.white.withOpacity(.03),
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: imageContainerHeight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: imageContainerHeight,
                                  width: imageContainerHeight,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://footwearnews.com/wp-content/uploads/2022/12/SP33-Pippen-Modernist-01.jpg?w=1024&h=686&crop=1",
                                    maxHeightDiskCache: imageDiskCache,
                                    maxWidthDiskCache: imageDiskCache,
                                    imageBuilder: (context, imageProvider) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: imageProvider)),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                            borderRadius:
                                                BorderRadius.circular(100)),
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
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 15),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class Attributes extends StatelessWidget {
  final List<String>? attributes;
  Attributes({super.key, this.attributes});

  final List<String> iconsList = [
    "Constants.durabilityIcon",
    "Constants.flexibilityIcon",
    "Constants.gripIcon",
    "Constants.comfortIcon",
  ];
  final List<String> features = [
    'Durability',
    'Flexibility',
    'Grip',
    'Comfort',
  ];
  final List<Color> colorsList = [
    Colors.transparent,
    HexColor('#6BF2C1'),
    HexColor('#254BC0'),
    HexColor('#DC7FE4'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(attributes?.length ?? 0, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          iconsList[index],
                          width: 14,
                          height: 14,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: Colors.white,
                            height: 14,
                            width: 14,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          features[index],
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 4,
                child: index == 0
                    ? DurabilityIndicator(
                        value: attributes?.elementAt(index) ?? "",
                      )
                    : CommonIndicator(
                        color: colorsList[index],
                        // value: basicValues[index],
                        value: attributes?.elementAt(index) ?? "",
                      ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      attributes?.elementAt(index).toUpperCase() ?? "",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

class CommonIndicator extends StatelessWidget {
  final Color? color;
  final String? value;

  const CommonIndicator({
    Key? key,
    this.color,
    this.value,
  }) : super(key: key);

  final low = "low";
  final medium = "medium";
  final high = "high";

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: HexColor('#242830')),
        ),
        child: FractionallySizedBox(
          widthFactor: (value?.trim() == "")
              ? (1 / 100)
              : value?.trim().toLowerCase() == low
                  ? (100 / 3) / 100
                  : value?.trim().toLowerCase() == medium
                      ? ((100 / 3) * 2) / 100
                      : 100 / 100,
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(100),
                bottomLeft: const Radius.circular(100),
                topRight: (value?.trim().toLowerCase() == high)
                    ? const Radius.circular(100)
                    : const Radius.circular(0),
                bottomRight: (value?.trim().toLowerCase() == high)
                    ? const Radius.circular(100)
                    : const Radius.circular(0),
              ),
              color: color,
            ),
            height: 10,
          ),
        ));
  }
}

class DurabilityIndicator extends StatelessWidget {
  final String? value;
  const DurabilityIndicator({Key? key, this.value}) : super(key: key);

  final low = "low";
  final medium = "medium";
  final high = "high";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: HexColor('#242830')),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            (value?.trim().toLowerCase() == low ||
                    value?.trim().toLowerCase() == medium ||
                    value?.trim().toLowerCase() == high)
                ? Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                              bottomLeft: Radius.circular(100)),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.red, Colors.orange])),
                      height: 10,
                    ),
                  )
                : const Expanded(child: SizedBox.shrink()),
            const SizedBox(width: 2),
            (value?.trim().toLowerCase() == medium ||
                    value?.trim().toLowerCase() == high)
                ? Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                            Colors.orangeAccent,
                            Colors.yellow,
                          ])),
                      height: 10,
                    ),
                  )
                : const Expanded(child: SizedBox.shrink()),
            const SizedBox(width: 2),
            (value?.trim().toLowerCase() == high)
                ? Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(100),
                              bottomRight: Radius.circular(100)),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.yellow,
                                Colors.green,
                              ])),
                      height: 10,
                    ),
                  )
                : const Expanded(child: SizedBox.shrink())
          ],
        ),
      ),
    );
  }
}
