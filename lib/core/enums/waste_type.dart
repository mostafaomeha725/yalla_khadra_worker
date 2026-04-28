enum WasteType {
  unknown(0, 'Unknown'),
  plastic(1, 'Plastic'),
  paper(2, 'Paper'),
  glass(3, 'Glass'),
  metal(4, 'Metal'),
  organic(5, 'Organic'),
  electronic(6, 'Electronic'),
  construction(9, 'Construction'),
  textile(10, 'Textile'),
  mixed(11, 'Mixed');

  final int value;
  final String label;

  const WasteType(this.value, this.label);
}
