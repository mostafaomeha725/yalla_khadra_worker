enum WasteType {
  battery(0, 'Battery'),
  brownGlass(1, 'Brown Glass'),
  clothes(2, 'Clothes'),
  biological(3, 'Biological'),
  greenGlass(4, 'Green Glass'),
  paper(5, 'Paper'),
  trash(6, 'Trash'),
  shoes(7, 'Shoes'),
  whiteGlass(8, 'White Glass'),
  metal(9, 'Metal'),
  cardboard(10, 'Cardboard'),
  plastic(11, 'Plastic');

  final int value;
  final String label;

  const WasteType(this.value, this.label);
}
