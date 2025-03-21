//import 'dart:nativewrappers/_internal/vm/lib/developer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app_class_version/controller/note_screen_controller.dart';
import 'package:note_app_class_version/view/add_note-screen/add_note_screen.dart';
import 'package:note_app_class_version/view/not_details_screen/note_details_screen.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await NoteScreenController.getAllNotes();
        setState(() {});
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          elevation: 10,
          onPressed: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddNoteScreen(),
                ));

            // log("added a note ");
            setState(() {});
          },
          foregroundColor: Colors.white,
          child: Icon(
            Icons.add,
            size: 45,
          ),
        ),
        endDrawer: Drawer(),
        appBar: AppBar(
          leading: Center(child: CircleAvatar()),
          title: Text(
            "Professor",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "My Notes",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            // Center(
            //   child: TabBar(
            //     tabAlignment: TabAlignment.center,
            //     unselectedLabelColor: Colors.white,
            //     labelColor: Colors.black,
            //     isScrollable: true,
            //     indicatorPadding: EdgeInsets.zero,
            //     labelPadding: EdgeInsets.symmetric(horizontal: 10),
            //     padding: EdgeInsets.zero,
            //     labelStyle:
            //         TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            //     indicator: BoxDecoration(
            //         borderRadius: BorderRadius.circular(100),
            //         color: Colors.white),
            //     indicatorSize: TabBarIndicatorSize.label,
            //     dividerHeight: 0,
            //     tabs: [
            //       Container(
            //           padding: EdgeInsets.symmetric(horizontal: 10),
            //           decoration: BoxDecoration(
            //             border: Border.all(color: Colors.white),
            //             borderRadius: BorderRadius.circular(100),
            //           ),
            //           child: Tab(text: "cat 1", height: 30)),
            //       Container(
            //           padding: EdgeInsets.symmetric(horizontal: 10),
            //           decoration: BoxDecoration(
            //             border: Border.all(color: Colors.white),
            //             borderRadius: BorderRadius.circular(100),
            //           ),
            //           child: Tab(text: "cat 1", height: 30)),
            //       Container(
            //           padding: EdgeInsets.symmetric(horizontal: 10),
            //           decoration: BoxDecoration(
            //             border: Border.all(color: Colors.white),
            //             borderRadius: BorderRadius.circular(100),
            //           ),
            //           child: Tab(text: "cat 1", height: 30)),
            //       Container(
            //           padding: EdgeInsets.symmetric(horizontal: 10),
            //           decoration: BoxDecoration(
            //             border: Border.all(color: Colors.white),
            //             borderRadius: BorderRadius.circular(100),
            //           ),
            //           child: Tab(text: "cat 1", height: 30)),
            //     ],
            //   ),
            // ),
            Expanded(
              child: MasonryGridView.builder(
                itemCount: NoteScreenController.notesList.length,
                padding: EdgeInsets.symmetric(horizontal: 20),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NoteDetailsScreen(),
                        ));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.greenAccent.shade100,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              NoteScreenController.notesList[index]["title"],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddNoteScreen(
                                            isEdit: true,
                                            noteId: NoteScreenController
                                                .notesList[index]["id"],
                                            noteTitle: NoteScreenController
                                                .notesList[index]["title"],
                                            date: NoteScreenController
                                                .notesList[index]["date"],
                                            des: NoteScreenController
                                                .notesList[index]["des"],
                                            category: NoteScreenController
                                                .notesList[index]["category"]),
                                      ));

                                  // log("added a note ");
                                  setState(() {});
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () async {
                                  var noteId = NoteScreenController
                                      .notesList[index]["id"];
                                  await NoteScreenController.deleteNote(noteId);
                                  setState(() {});
                                },
                                icon: Icon(Icons.delete))
                          ],
                        ),
                        Text(
                          NoteScreenController.notesList[index]["des"],
                          textAlign: TextAlign.justify,
                          maxLines: index + 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        Row(
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.date_range),
                            Text(
                              NoteScreenController.notesList[index]["date"],
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
