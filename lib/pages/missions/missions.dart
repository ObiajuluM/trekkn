import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MissionsPage extends ConsumerStatefulWidget {
  const MissionsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MissionsPageState();
}

class _MissionsPageState extends ConsumerState<MissionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: const EdgeInsets.all(8),
        title: const Text(
          "Missions",
        ),
      ),

      ///
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          GridView.builder(
            itemCount: 11,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              // crossAxisSpacing: 0.5,
              // mainAxisSpacing: 0.5,
            ),

            ///
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.all(2),
                color: index % 3 == 0
                    ? Theme.of(context).colorScheme.onPrimary
                    : Colors.grey.shade200.withValues(alpha: 0.5),
                elevation: index % 3 == 0 ? null : 0,
                clipBehavior: Clip.antiAlias,
                // padding: EdgeInsets.all(12),
                // decoration: BoxDecoration(
                // color: Color.fromRGBO(238, 102, 44, 1),
                //   color: Theme.of(context).colorScheme.surfaceContainerLow,
                //   borderRadius: BorderRadius.circular(12),
                // ),
                child: GestureDetector(
                  // splashColor: Color.fromRGBO(44, 238, 57, 1),
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/star.png", // <a href="https://www.flaticon.com/free-icons/rating" title="rating icons">Rating icons created by O.moonstd - Flaticon</a>
                          height: 48,
                          // width: 24,
                        ),

                        ///
                        const Text(
                          "Kweku the traveller",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
