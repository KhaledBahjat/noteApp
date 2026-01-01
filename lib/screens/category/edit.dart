import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/screens/auth/widgets/coustom_text_form.dart';
import 'package:note_app/screens/auth/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditCategory extends StatefulWidget {
  final String docid;
  final String oldName;
  const EditCategory({super.key, required this.docid, required this.oldName});

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  CollectionReference category = FirebaseFirestore.instance.collection(
    'category',
  );
  bool isLoading = false;
  Future<void> editCategory() async {
    if (formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });
        await category.doc(widget.docid).update({
          'name': controller.text,
        });
        isLoading = false;
        Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
      } catch (e) {
        isLoading = false;
        setState(() {});
        print("error $e");
      }
    }
  }

  @override
  void initState() {
    controller.text = widget.oldName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Category'),
      ),
      body: Form(
        key: formKey,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                  strokeWidth: 3,
                ),
              )
            : Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextFeild(
                      suffixIcon: const Icon(Icons.category),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter Category';
                        }
                        return null;
                      },
                      controller: controller,
                      hintText: 'Enter Category',
                    ),
                  ),
                  CustomButton(
                    title: 'Save',
                    onPressed: () => editCategory(),
                  ),
                ],
              ),
      ),
    );
  }
}
