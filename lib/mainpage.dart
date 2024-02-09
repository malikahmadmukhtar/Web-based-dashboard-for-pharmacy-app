import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart' hide Transaction;

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("images/bg.jpg"), // <-- BACKGROUND IMAGE
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              toolbarHeight: 60,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.network('images/appicon.png'),
              ),
              backgroundColor: Colors.blueAccent,
              title: const Text('AM Pharma',
                  style: TextStyle(color: Colors.white)),
              centerTitle: true),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'Admin Panel',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text(
                              'User List',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 500,
                              width: 600,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(
                                    0.6,
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              child: StreamBuilder<
                                  QuerySnapshot<Map<String, dynamic>>>(
                                // inside the <> you enter the type of your stream
                                stream: FirebaseFirestore.instance
                                    .collection("users")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          elevation: 3,
                                          color: Colors.white70,
                                          child: ListTile(
                                            title: Text(
                                              'Name: ' +
                                                  snapshot.data!.docs[index]
                                                      .get('name'),
                                            ),
                                            subtitle: Text(
                                              'Address: ' +
                                                  snapshot.data!.docs[index]
                                                      .get('address') +
                                                  '\nContact: ' +
                                                  snapshot.data!.docs[index]
                                                      .get('contact'),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                  if (snapshot.hasError) {
                                    return const Text('Error');
                                  } else {
                                    return const SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: CircularProgressIndicator());
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Column(
                          children: [
                            const Text(
                              'Order List',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 500,
                              width: 600,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(
                                    0.6,
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              child: StreamBuilder<
                                  QuerySnapshot<Map<String, dynamic>>>(
                                // inside the <> you enter the type of your stream
                                stream: FirebaseFirestore.instance
                                    .collection("cart")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          elevation: 3,
                                          color: Colors.white60,
                                          child: ListTile(
                                            title: Text(
                                              'Userame: ' +
                                                  snapshot.data!.docs[index]
                                                      .get('name'),
                                            ),
                                            subtitle: Text(
                                              'Product: ' +
                                                  snapshot.data!.docs[index]
                                                      .get('product') +
                                                  '\nState: ' +
                                                  snapshot.data!.docs[index]
                                                      .get('state'),
                                            ),
                                            trailing: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      showAlertDialog(
                                                          BuildContext
                                                              context) {
                                                        // set up the buttons
                                                        Widget cancelButton =
                                                            ElevatedButton(
                                                          child: const Text(
                                                              "Cancel"),
                                                          onPressed: ()  {
                                                            Navigator.of(
                                                                    context,
                                                                    rootNavigator:
                                                                        true)
                                                                .pop();
                                                          },
                                                        );
                                                        Widget yesButton =
                                                            ElevatedButton(
                                                          child:
                                                              const Text("Yes"),
                                                          onPressed: () async {
                                                            FirebaseFirestore
                                                                .instance
                                                                .runTransaction(
                                                                    (Transaction
                                                                        myTransaction) async {
                                                              await myTransaction.delete(snapshot.data!.docs[index].reference);});

                                                            DatabaseReference databaseRef = FirebaseDatabase.instance.ref('users').child(snapshot.data!.docs[index].get('name')).child(snapshot.data!.docs[index].get('product'));
                                                            await databaseRef.remove();

                                                            Navigator.of(
                                                                    context,
                                                                    rootNavigator:
                                                                        true)
                                                                .pop();
                                                          },
                                                        );
                                                        // set up the AlertDialog
                                                        AlertDialog alert =
                                                            AlertDialog(
                                                          title: const Text(
                                                              "Confirmation"),
                                                          content: const Text(
                                                              "Would you like to Remove this Order as Delivered?"),
                                                          actions: [
                                                            cancelButton,
                                                            yesButton,
                                                          ],
                                                        );
                                                        // show the dialog
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return alert;
                                                          },
                                                        );
                                                      }

                                                      showAlertDialog(context);
                                                    },
                                                    icon: Icon(Icons.delete)),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                  if (snapshot.hasError) {
                                    return const Text('Error');
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
