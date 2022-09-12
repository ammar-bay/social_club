import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/models/livestream.dart';
// import 'package:socialapp/resources/firestore_methods.dart';
import 'package:socialapp/responsive/responsive_layout.dart';
import 'package:socialapp/screens/broadcast_screen.dart';
import 'package:socialapp/widgets/loading_indicator.dart';
import 'package:timeago/timeago.dart' as timeago;

class LiveFeedScreen extends StatefulWidget {
  const LiveFeedScreen({Key? key}) : super(key: key);

  @override
  State<LiveFeedScreen> createState() => _LiveFeedScreenState();
}

class _LiveFeedScreenState extends State<LiveFeedScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(
            top: 10,
          ),
          child: Column(
            children: [
              const Text(
                'Live Users',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              StreamBuilder<dynamic>(
                stream: FirebaseFirestore.instance
                    .collection('livestream')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingIndicator();
                  }

                  return Expanded(
                    child: ResponsiveLayout(
                      webScreenLayout: GridView.builder(
                        itemCount: snapshot.data.docs.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (context, index) {
                          LiveStream post = LiveStream.fromMap(
                              snapshot.data.docs[index].data());
                          return InkWell(
                            onTap: () async {
                              // await FireStoreMethods()
                              //     .updateViewCount(post.channelId, true);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => BroadcastScreen(
                                    isBroadcaster: false,
                                    channelId: post.channelId,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: size.height * 0.35,
                                    child: Image.network(
                                      post.image,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        post.username,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        post.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('${post.viewers} watching'),
                                      Text(
                                        'Started ${timeago.format(post.startedAt.toDate())}',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      mobileScreenLayout: ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            LiveStream post = LiveStream.fromMap(
                                snapshot.data.docs[index].data());

                            return InkWell(
                              onTap: () async {
                                // await FireStoreMethods()
                                //     .updateViewCount(post.channelId, true);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BroadcastScreen(
                                      isBroadcaster: false,
                                      channelId: post.channelId,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: size.height * 0.1,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: Image.network(post.image),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          post.username,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          post.title,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text('${post.viewers} watching'),
                                        Text(
                                          'Started ${timeago.format(post.startedAt.toDate())}',
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.more_vert,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
