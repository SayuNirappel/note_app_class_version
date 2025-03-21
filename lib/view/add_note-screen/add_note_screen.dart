import 'package:flutter/material.dart';
import 'package:note_app_class_version/controller/note_screen_controller.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen(
      {super.key,
      this.isEdit = false,
      this.noteTitle,
      this.des,
      this.date,
      this.category,
      this.noteId});
  final bool isEdit;
  final String? noteTitle;
  final String? des;
  final String? date;
  final String? category;
  final String? noteId;
  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.isEdit) {
      titleController.text = widget.noteTitle ?? "";
      desController.text = widget.des ?? "";
      dateController.text = widget.date ?? "";
      NoteScreenController.onCategorySelection(widget.category);
      setState(() {});
    } else {
      NoteScreenController.onCategorySelection(null);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.isEdit == true ? "Update Note" : "Add Note",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            spacing: 16,
            children: [
              TextFormField(
                controller: titleController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter",
                  label: Text(
                    "Title",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              TextFormField(
                controller: desController,
                maxLines: 15,
                minLines: 5,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter",
                  label: Text(
                    "Note Description",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)),
                child: Row(
                  spacing: 20,
                  children: [
                    Text(
                      "Category  : ",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: DropdownButton(
                        style: TextStyle(color: Colors.grey),
                        isExpanded: true,
                        dropdownColor: Colors.black,
                        value: NoteScreenController.selectedCategory,
                        menuWidth: MediaQuery.sizeOf(context).width * .7,
                        hint: Text(
                          "Select",
                          style: TextStyle(color: Colors.grey),
                        ),
                        items: List.generate(
                          NoteScreenController.categories.length,
                          (index) => DropdownMenuItem(
                              value: NoteScreenController.categories[index],
                              child: Text(NoteScreenController.categories[index]
                                  .toUpperCase())),
                        ),
                        onChanged: (value) {
                          NoteScreenController.onCategorySelection(value);
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              TextFormField(
                controller: dateController,
                readOnly: true,
                onTap: () async {
                  dateController.text =
                      await NoteScreenController.onDateSelection(context);
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    label: Text(
                      "Date",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    suffixIcon: Icon(
                      Icons.calendar_month,
                      color: Colors.grey,
                    )),
              ),
              InkWell(
                onTap: () async {
                  if (widget.isEdit) {
                    //to edit exsisting note
                    NoteScreenController.updateNotes(
                        noteId: widget.noteId,
                        title: titleController.text,
                        des: desController.text,
                        date: dateController.text);
                  } else {
                    //adding new note
                    await NoteScreenController.addNote(
                        title: titleController.text,
                        des: desController.text,
                        date: dateController.text);
                  }

                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Text(
                    widget.isEdit ? "Update" : "Save",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
