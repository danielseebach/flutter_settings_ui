import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/src/list/settings_list.dart';
import 'package:flutter_settings_ui/src/sections/abstract_settings_section.dart';
import 'package:flutter_settings_ui/src/utils/platform_utils.dart';
import 'package:flutter_settings_ui/src/utils/settings_theme.dart';
import 'package:flutter_settings_ui/src/utils/theme_provider.dart';

class SliverSettingsList extends StatefulWidget {
  const SliverSettingsList({
    required this.sections,
    this.shrinkWrap = false,
    this.physics,
    this.platform,
    this.lightTheme,
    this.darkTheme,
    this.brightness,
    this.contentPadding,
    this.applicationType = ApplicationType.material,
    Key? key,
  }) : super(key: key);

  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final DevicePlatform? platform;
  final SettingsThemeData? lightTheme;
  final SettingsThemeData? darkTheme;
  final Brightness? brightness;
  final EdgeInsetsGeometry? contentPadding;
  final List<AbstractSettingsSection> sections;
  final ApplicationType applicationType;

  @override
  State<SliverSettingsList> createState() => _SliverSettingsListState();
}

class _SliverSettingsListState extends State<SliverSettingsList> {
  Future<int?>? _androidSdkFuture;
  int? _androidSdkFallback;
  DevicePlatform? _androidFuturePlatform;

  @override
  Widget build(BuildContext context) {
    DevicePlatform platform;
    if (widget.platform == null || widget.platform == DevicePlatform.device) {
      platform = detectPlatform(context);
    } else {
      platform = widget.platform!;
    }

    _ensureAndroidSdkFuture(platform);

    if (_androidSdkFuture == null) {
      return _buildSliver(
        context: context,
        platform: platform,
        androidSdkInt: null,
      );
    }

    return FutureBuilder<int?>(
      future: _androidSdkFuture,
      initialData: _androidSdkFallback,
      builder: (context, snapshot) {
        return _buildSliver(
          context: context,
          platform: platform,
          androidSdkInt: snapshot.data ?? _androidSdkFallback,
        );
      },
    );
  }

  void _ensureAndroidSdkFuture(DevicePlatform platform) {
    if (platform != DevicePlatform.android) {
      _androidFuturePlatform = platform;
      _androidSdkFuture = null;
      _androidSdkFallback = null;
      return;
    }

    if (_androidFuturePlatform == platform && _androidSdkFuture != null) {
      return;
    }

    _androidFuturePlatform = platform;
    _androidSdkFallback = detectAndroidSdkInt(platform);
    _androidSdkFuture = resolveAndroidSdkInt(platform);
  }

  Widget _buildSliver({
    required BuildContext context,
    required DevicePlatform platform,
    required int? androidSdkInt,
  }) {
    final brightness = calculateBrightness(context, platform);
    final iosVersionInt = detectIosMajorVersion(platform);

    final themeData = getTheme(
      context: context,
      platform: platform,
      brightness: brightness,
      androidSdkInt: androidSdkInt,
      iosVersionInt: iosVersionInt,
    ).merge(
      theme:
          brightness == Brightness.dark ? widget.darkTheme : widget.lightTheme,
    );

    return SliverLayoutBuilder(
      builder: (context, layout) {
        final resolvedPadding = widget.contentPadding ??
            calculateDefaultPadding(platform, layout.crossAxisExtent);

        return SettingsTheme(
          themeData: themeData,
          platform: platform,
          androidSdkInt: androidSdkInt,
          iosVersionInt: iosVersionInt,
          child: DecoratedSliver(
            decoration: BoxDecoration(color: themeData.settingsListBackground),
            sliver: SliverPadding(
              padding: resolvedPadding,
              sliver: SliverList.builder(
                itemCount: widget.sections.length,
                itemBuilder: (BuildContext context, int index) {
                  final section = widget.sections[index];
                  final isAndroidSdk36OrAbove =
                      platform == DevicePlatform.android &&
                          (androidSdkInt ?? 0) >= 36;

                  if (!isAndroidSdk36OrAbove ||
                      index == widget.sections.length - 1) {
                    return section;
                  }

                  final sectionGap = themeData.androidGapBetweenSections ?? 28;
                  return Padding(
                    padding: EdgeInsets.only(bottom: sectionGap),
                    child: section,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  EdgeInsets calculateDefaultPadding(
    DevicePlatform platform,
    double width,
  ) {
    if (width > 810) {
      final padding = (width - 810) / 2;
      switch (platform) {
        case DevicePlatform.web:
          return EdgeInsets.symmetric(vertical: 20, horizontal: padding);
        case DevicePlatform.device:
          throw Exception(
            "You can't use the DevicePlatform.device in this context. "
            'Incorrect platform: SettingsList.calculateDefaultPadding',
          );
        case DevicePlatform.android:
        case DevicePlatform.fuchsia:
        case DevicePlatform.linux:
        case DevicePlatform.iOS:
        case DevicePlatform.macOS:
        case DevicePlatform.windows:
        default:
          return EdgeInsets.symmetric(horizontal: padding);
      }
    }

    switch (platform) {
      case DevicePlatform.android:
      case DevicePlatform.fuchsia:
      case DevicePlatform.linux:
      case DevicePlatform.iOS:
      case DevicePlatform.macOS:
      case DevicePlatform.windows:
        return EdgeInsets.zero;
      case DevicePlatform.web:
        return const EdgeInsets.symmetric(vertical: 20);
      case DevicePlatform.device:
        throw Exception(
          "You can't use the DevicePlatform.device in this context. "
          'Incorrect platform: SettingsList.calculateDefaultPadding',
        );
    }
  }

  Brightness calculateBrightness(
    BuildContext context,
    DevicePlatform resolvedPlatform,
  ) {
    final materialBrightness = Theme.of(context).brightness;
    final cupertinoBrightness = CupertinoTheme.of(context).brightness ??
        MediaQuery.of(context).platformBrightness;

    switch (widget.applicationType) {
      case ApplicationType.material:
        return materialBrightness;
      case ApplicationType.cupertino:
        return cupertinoBrightness;
      case ApplicationType.both:
        return resolvedPlatform != DevicePlatform.iOS
            ? materialBrightness
            : cupertinoBrightness;
    }
  }
}
