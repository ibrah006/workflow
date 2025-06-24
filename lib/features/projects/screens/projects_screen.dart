import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workflow/core/components/custom_card.dart';
import 'package:workflow/core/config/app_routes.dart';
import 'package:workflow/core/providers/projects_provider.dart';
import 'package:workflow/features/projects/components/project_card.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final projects = context.watch<ProjectsProvider>().projects;

    return Scaffold(
      appBar: AppBar(
        title: Text("Projects", style: textTheme.headlineMedium),
        centerTitle: false,
        actions: [
          IconButton.filledTonal(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.createProject);
            },
            style: ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(Color(0xFF3b72e3)),
                backgroundColor: WidgetStatePropertyAll(
                    Color(0xFF3b72e3).withValues(alpha: .07))),
            icon: Icon(EvaIcons.plus),
          ),
          SizedBox(width: 20)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  prefixIcon: Icon(
                    EvaIcons.search,
                    color: Color(0xFF72838f),
                  ),
                  hintText: "Search Projects...",
                  hintStyle: textTheme.bodyLarge!.copyWith(
                      color: Color(0xFF72838f), fontWeight: FontWeight.w500),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  filled: true,
                  fillColor: Colors.white),
            ),
            SizedBox(height: 10),
            // Search options
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: CustomCard(
                    hasShadow: false,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            EvaIcons.chevronDown,
                            color: Color(0xFF1d1e1f),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(EvaIcons.folderOutline,
                                color: Color(0xFF1d1e1f)),
                            SizedBox(width: 8),
                            Expanded(
                              child: DropdownButton(
                                  underline: SizedBox(),
                                  dropdownColor: Colors.white,
                                  icon: SizedBox(),
                                  items: [
                                    DropdownMenuItem(
                                        child: Text("All Status",
                                            style: textTheme.bodyLarge!
                                                .copyWith(
                                                    color: Color(0xFF1d1e1f))))
                                  ],
                                  onChanged: (value) {}),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: CustomCard(
                    hasShadow: false,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(EvaIcons.funnelOutline, color: Color(0xFF1d1e1f)),
                        SizedBox(width: 8),
                        Text("Filter",
                            style: textTheme.bodyLarge!
                                .copyWith(color: Color(0xFF1d1e1f)))
                      ],
                    ),
                  ),
                ),
                CustomCard(
                  padding: EdgeInsets.symmetric(vertical: 13, horizontal: 9),
                  hasShadow: false,
                  child: Icon(EvaIcons.moreHorizontal),
                )
              ],
            ),
            SizedBox(height: 20),

            // Projects listing
            ...List.generate(projects.length, (index) {
              return ProjectCard(projects[index]);
            })
          ],
        ),
      ),
    );
  }
}
