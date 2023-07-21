import 'package:flutter/material.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Grid View"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey.shade900,
      body: Padding(
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
          return GridView.builder(
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
                    onTap: () {},
                    splashColor: Colors.white.withOpacity(.06),
                    highlightColor: Colors.white.withOpacity(.03),
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: imageContainerHeight,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(10)),
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
      ),
    );
  }
}
