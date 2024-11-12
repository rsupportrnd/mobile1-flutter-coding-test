enum SectionSwitchType {
  normal('Default'),
  colorsAndBorders('Custom Colors and Borders'),
  onAndOff("With 'On' and 'Off' text and custom text colors"),
  customSize('Custom size'),
  borderRadiusAndPadding('Custom border radius and padding'),
  customText('Custom text'),
  iconInToggle(
    'Icon in toggle',
    subtitle: 'Inspired by the colors from Github Dark Mode switch',
  ),
  imageAsToggleIcon('Image as toggle icon');

  const SectionSwitchType(
    this.title, {
    this.subtitle,
  });
  final String title;
  final String? subtitle;
}
