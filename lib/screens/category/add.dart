import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/screens/auth/widgets/coustom_text_form.dart';
import 'package:note_app/screens/auth/widgets/custom_button.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
      ),
      body: Form(
        key: formKey,
        child: Column(
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
                },
                controller: controller,
                hintText: 'Enter Category',
              ),
            ),
            CustomButton(
              title: 'Add',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
