import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:workflow/core/components/color_radio_button.dart';
import 'package:workflow/core/components/custom_dropdown_menu.dart';
import 'package:workflow/core/components/custom_text_field.dart';
import 'package:workflow/core/components/outlined_icon_button.dart';
import 'package:workflow/core/extensions/datetime_conversions_ext.dart';
import 'package:workflow/data/models/task.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  static const iconOptions = [
    EvaIcons.fileText,
    EvaIcons.folderRemove,
    EvaIcons.map,
    EvaIcons.cube,
  ];
  static final colorOptions = [
    Color(0xFF3b72e3),
    Colors.blueGrey.shade800,
    Color(0xFFff7043),
    Color(0xFFabc3d8)
  ];

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  Task task = Task.empty().copyWithSafe(
    estimatedMaterials: List.empty(),
    usedMaterials: List.empty(),
  );

  // Text field Controllers
  final titleController = TextEditingController(),
      dueDateController = TextEditingController();

  // Add new Material estimation
  bool addMaterialEstimation = false;

  updateTitle(String title) => task.copyWithSafe(title: title);

  updateDueDate(String dateUnparsed) {
    final parsedDate = dateUnparsed.parseFlexibleDate();

    if (parsedDate == null) {
      // show some text field error border on date field
    } else {
      task.copyWithSafe(dueDate: parsedDate);
    }
  }

  onAddMaterialEstimation() {
    setState(() {
      addMaterialEstimation = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Create Task", style: textTheme.headlineMedium),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
              hintText: "Task name",
              controller: titleController,
              onFinished: updateTitle,
              label: "Task name"),
          SizedBox(height: 15.0),
          Text("Color", style: textTheme.titleMedium),
          SizedBox(height: 7.0),
          SizedBox(
            height: 45,
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(4, (index) {
                  return ColorRadioButton(
                    margin: const EdgeInsets.only(right: 12),
                    selected:
                        CreateTaskScreen.colorOptions[index] == task.color,
                    onPressed: () {
                      setState(() {
                        task.color = CreateTaskScreen.colorOptions[index];
                      });
                    },
                    color: CreateTaskScreen.colorOptions[index],
                  );
                })),
          ),
          SizedBox(height: 15.0),
          Text("Icon", style: textTheme.titleMedium),
          SizedBox(height: 7.0),
          SizedBox(
            height: 50,
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: OutlinedIconButton(
                      onPressed: () {
                        setState(() {
                          task.icon = CreateTaskScreen.iconOptions[index];
                        });
                      },
                      iconColor: task.color ?? Colors.blueGrey.shade800,
                      selected:
                          CreateTaskScreen.iconOptions[index] == task.icon,
                      icon: CreateTaskScreen.iconOptions[index],
                    ),
                  );
                })),
          ),
          SizedBox(height: 15.0),
          Text("Assignees", style: textTheme.titleMedium),
          SizedBox(height: 7.0),
          SizedBox(
            height: 45,
            child: ListView(scrollDirection: Axis.horizontal, children: [
              ...List.generate(2, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Container(
                    width: 45,
                    decoration: BoxDecoration(
                        color: Color(0xFFf7f8fa),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Color(0xFFe7eaef))),
                    child: Icon(EvaIcons.person,
                        size: 32, color: Colors.blueGrey.shade800),
                  ),
                );
              }),
              Container(
                width: 45,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Color(0xFFe7eaef))),
                child: Icon(EvaIcons.plus, color: Colors.blueGrey.shade800),
              ),
            ]),
          ),
          SizedBox(height: 15.0),
          CustomTextField(
            hintText: "Search members...",
            prefixIcon: EvaIcons.search,
          ),

          // Due date (required field)
          SizedBox(height: 15.0),
          CustomTextField(
            hintText: "Due date",
            prefixIcon: EvaIcons.calendarOutline,
            controller: dueDateController,
            onFinished: updateDueDate,
            label: "Due date",
          ),

          // Estimated Materials
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Estimated Materials", style: textTheme.titleMedium),
              // Special Icon Button
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 32.5,
                    width: 32.5,
                    decoration: BoxDecoration(
                      color: Color(0xFFa8d2fe),
                      borderRadius: BorderRadius.circular(50),
                      // border: Border.all()
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    style: IconButton.styleFrom(
                        foregroundColor: Color(0xFFdbebfe), iconSize: 34),
                    icon: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 9,
                        ),
                        Icon(EvaIcons.info),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          if (!addMaterialEstimation && task.estimatedMaterials.isEmpty) ...[
            SizedBox(height: 15),
            SvgPicture.asset(
              'assets/icons/alert_cube.svg',
              width: 65,
              height: 65,
              color: Colors.blueGrey.shade700,
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Text("No estimated materials",
                  style: textTheme.titleMedium!.copyWith(
                      color: Colors.blueGrey.shade800,
                      fontWeight: FontWeight.normal)),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 125,
                child: FilledButton(
                  onPressed: onAddMaterialEstimation,
                  child: Text("Add"),
                ),
              ),
            )
          ],

          if (addMaterialEstimation) ...[
            SizedBox(height: 10.0),
            CustomDropdownMenu(
              labelText: "Material name",
            ),
            SizedBox(height: 10.0),
            CustomDropdownMenu(
              labelText: "Estimated quantity",
            ),
            SizedBox(height: 10.0),
            CustomDropdownMenu(
              labelText: "Unit",
            ),
            SizedBox(height: 10.0),
            // Special Icon Button
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 38.5,
                  width: 38.5,
                  decoration: BoxDecoration(
                    color: Color(0xFFe3eaf1),
                    borderRadius: BorderRadius.circular(50),
                    // border: Border.all()
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  style: IconButton.styleFrom(
                      foregroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      iconSize: 42),
                  icon: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 11,
                      ),
                      Icon(EvaIcons.plusCircle),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () {}, child: Text("Cancel")),
                SizedBox(width: 15.0),
                SizedBox(
                    width: 125,
                    child: FilledButton(onPressed: () {}, child: Text("Save")))
              ],
            )
          ]
        ],
      ),
    );
  }
}
