import 'package:citystat_infra_ui/flowy_infra_ui.dart';
import 'package:citystat_svg/citystat_svg.dart';
import 'package:flutter/material.dart';

class FlowyColorOption {
  const FlowyColorOption({
    required this.color,
    required this.i18n,
    required this.id,
  });

  final Color color;
  final String i18n;
  final String id;
}

class FlowyColorPicker extends StatelessWidget {
  final List<FlowyColorOption> colors;
  final Color? selected;
  final Function(FlowyColorOption option, int index)? onTap;
  final double separatorSize;
  final double iconSize;
  final double itemHeight;
  final Border? border;

  const FlowyColorPicker({
    super.key,
    required this.colors,
    this.selected,
    this.onTap,
    this.separatorSize = 4,
    this.iconSize = 16,
    this.itemHeight = 32,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return VSpace(separatorSize);
      },
      itemCount: colors.length,
      physics: StyledScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return _buildColorOption(colors[index], index);
      },
    );
  }

  Widget _buildColorOption(
    FlowyColorOption option,
    int i,
  ) {
    Widget? checkmark;
    if (selected == option.color) {
      checkmark = const FlowySvg(FlowySvgData("grid/checkmark"));
    }

    final colorIcon = ColorOptionIcon(
      color: option.color,
      iconSize: iconSize,
    );

    return SizedBox(
      height: itemHeight,
      child: FlowyButton(
        text: FlowyText(option.i18n),
        leftIcon: colorIcon,
        rightIcon: checkmark,
        iconPadding: 10,
        onTap: () {
          onTap?.call(option, i);
        },
      ),
    );
  }
}

class ColorOptionIcon extends StatelessWidget {
  const ColorOptionIcon({
    super.key,
    required this.color,
    this.iconSize = 16.0,
  });

  final Color color;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: iconSize,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: color == Colors.transparent
              ? Border.all(color: const Color(0xFFCFD3D9))
              : null,
        ),
      ),
    );
  }
}
