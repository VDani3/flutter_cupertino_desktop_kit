import 'package:example/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_desktop_cupertino/dsk_widgets.dart';

class LayoutSidebarLeft extends StatefulWidget {
  final List<String> options;
  final Function(int, String) onSelect;

  const LayoutSidebarLeft(
      {Key? key, this.options = const [], required this.onSelect})
      : super(key: key);

  @override
  State<LayoutSidebarLeft> createState() => LayoutButtonsState();
}

class LayoutButtonsState extends State<LayoutSidebarLeft> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    String selectedRadio = DSKThemeManager.appearanceConfig;
    return Container(
        color: DSKColors.backgroundSecondary1,
        child: ListView(children: [
          const SizedBox(height: 50),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(widget.options.length, (int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    widget.onSelect(index, widget.options[index]);
                    _selectedIndex = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: _selectedIndex == index ? DSKColors.accent : null,
                    ),
                    child: Text(
                      widget.options[index],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14,
                          color: _selectedIndex == index
                              ? DSKColors.white
                              : DSKThemeManager.isLight
                                  ? DSKColors.black
                                  : DSKColors.white),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 25),
          Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
          const Text("Theme: ",
                            style: TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          DSKButtonRadio(
              label: "Sytem",
              isSelected: selectedRadio == "system",
              onSelected: (bool? isSelected) {
                setState(() {
                  selectedRadio = "system";
                  App.of(context)?.setAppearance("system");
                });
              },
            ),
          const SizedBox(height: 8),
          DSKButtonRadio(
              label: "Light",
              isSelected: selectedRadio == "light",
              onSelected: (bool? isSelected) {
                setState(() {
                  selectedRadio = "light";
                  App.of(context)?.setAppearance("light");
                });
              },
            ),
          const SizedBox(height: 8),
          DSKButtonRadio(
              label: "Dark",
              isSelected: selectedRadio == "dark",
              onSelected: (bool? isSelected) {
                setState(() {
                  selectedRadio = "dark";
                  App.of(context)?.setAppearance("dark");
                });
              },
            ),
          const SizedBox(height: 16),
          const Text("Primary color: ",
                            style: TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          DSKButtonsColors(
                colors: DSKColors.systemColors,
                selectedColor: DSKThemeManager.themeColor,
                onColorChanged: (String colorName) {
                  App.of(context)?.setActiveColor(colorName);
                },
              ),
        ]))]));
  }
}
