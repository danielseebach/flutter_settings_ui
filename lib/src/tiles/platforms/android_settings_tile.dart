import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

class AndroidSettingsTile extends StatelessWidget {
  const AndroidSettingsTile({
    required this.tileType,
    required this.leading,
    required this.title,
    required this.description,
    required this.onPressed,
    required this.onToggle,
    required this.value,
    required this.initialValue,
    required this.activeSwitchColor,
    required this.enabled,
    required this.trailing,
    required this.backgroundColor,
    Key? key,
  }) : super(key: key);

  final SettingsTileType tileType;
  final Widget? leading;
  final Widget? title;
  final Widget? description;
  final Function(BuildContext context)? onPressed;
  final Function(bool value)? onToggle;
  final Widget? value;
  final bool initialValue;
  final bool enabled;
  final Color? activeSwitchColor;
  final Widget? trailing;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = SettingsTheme.of(context);
    // final scaleFactor = MediaQuery.of(context).textScaleFactor;
    final scaleFactor = MediaQuery.textScalerOf(context).scale(1);
    final leadingStartPadding =
        theme.themeData.androidLeadingStartPadding ?? 24;
    final contentHorizontalPadding =
        theme.themeData.androidTileHorizontalPadding ?? 24;
    final contentVerticalPadding =
        theme.themeData.androidTileVerticalPadding ?? 19;
    final titleFontSize = theme.themeData.androidTitleFontSize ?? 18;
    final titleFontWeight =
        theme.themeData.androidTitleFontWeight ?? FontWeight.w400;
    final tileBackgroundColor =
        backgroundColor ?? theme.themeData.androidTileBackgroundColor;
    final cantShowAnimation = tileType == SettingsTileType.switchTile
        ? onToggle == null && onPressed == null
        : onPressed == null;

    return IgnorePointer(
      ignoring: !enabled,
      child: Material(
        color: tileBackgroundColor ?? Colors.transparent,
        child: InkWell(
          onTap: cantShowAnimation
              ? null
              : () {
                  if (tileType == SettingsTileType.switchTile) {
                    onToggle?.call(!initialValue);
                  } else {
                    onPressed?.call(context);
                  }
                },
          highlightColor: theme.themeData.tileHighlightColor,
          child: Row(
            children: [
              if (leading != null)
                Padding(
                  padding:
                      EdgeInsetsDirectional.only(start: leadingStartPadding),
                  child: IconTheme(
                    data: IconTheme.of(context).copyWith(
                      color: enabled
                          ? theme.themeData.leadingIconsColor
                          : theme.themeData.inactiveTitleColor,
                    ),
                    child: leading!,
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: contentHorizontalPadding,
                    end: contentHorizontalPadding,
                    bottom: contentVerticalPadding * scaleFactor,
                    top: contentVerticalPadding * scaleFactor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextStyle(
                        style: TextStyle(
                          color: enabled
                              ? theme.themeData.settingsTileTextColor
                              : theme.themeData.inactiveTitleColor,
                          fontSize: titleFontSize,
                          fontWeight: titleFontWeight,
                        ),
                        child: title ?? Container(),
                      ),
                      if (value != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: DefaultTextStyle(
                            style: TextStyle(
                              color: enabled
                                  ? theme.themeData.tileDescriptionTextColor
                                  : theme.themeData.inactiveSubtitleColor,
                            ),
                            child: value!,
                          ),
                        )
                      else if (description != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: DefaultTextStyle(
                            style: TextStyle(
                              color: enabled
                                  ? theme.themeData.tileDescriptionTextColor
                                  : theme.themeData.inactiveSubtitleColor,
                            ),
                            child: description!,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (trailing != null && tileType == SettingsTileType.switchTile)
                Row(
                  children: [
                    trailing!,
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 8),
                      child: Switch(
                        value: initialValue,
                        onChanged: onToggle,
                        activeThumbColor: enabled
                            ? activeSwitchColor
                            : theme.themeData.inactiveTitleColor,
                      ),
                    ),
                  ],
                )
              else if (tileType == SettingsTileType.switchTile)
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 16, end: 8),
                  child: Switch(
                    value: initialValue,
                    onChanged: onToggle,
                    activeThumbColor: enabled
                        ? activeSwitchColor
                        : theme.themeData.inactiveTitleColor,
                  ),
                )
              else if (trailing != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: trailing,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
