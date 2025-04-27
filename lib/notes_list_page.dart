import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_with_firebase/view_notes.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class NotesListPage extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      // appBar: AppBar(
      //   title: Text('Your Notes'),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.delete),
      //       onPressed: () {
      //         // Navigate to delete mode
      //         // Navigator.push(
      //         //   context,
      //         //   MaterialPageRoute(builder: (context) => DeleteNotesPage()),
      //         // );
      //       },
      //     ),
      //   ],
      // ),
      appBar: AppBar(
        backgroundColor: const Color(0xffee4176),
        elevation: 0,
        toolbarHeight: 70,
        leading: IconButton(
          icon: const Icon(TablerIcons.caret_left_filled),
          color: const Color(0xfffef4f5),
          iconSize: 24,
          onPressed: () {
            // Go back logic
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'NOTES',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xfffef4f5),
              fontSize: 24,
              fontFamily: 'Open_Sans'),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 33, right: 33, top: 30),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('notes')
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());

            final notes = snapshot.data!.docs;

            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    height: 68,
                    color: const Color(0xfffef4f5),
                    child: ListTile(
                      title: Text(
                        note['title'] ?? '',
                        style: const TextStyle(
                            fontFamily: "Open_sans",
                            color: Color(0xffee4176),
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      subtitle: Text(
                        note['content'] ?? '',
                        style: const TextStyle(
                            fontFamily: "Open_sans",
                            color: Color(0xffee4176),
                            fontWeight: FontWeight.normal,
                            fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        // Navigate to view/edit note
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ViewEditNotePage(noteId: note.id),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
