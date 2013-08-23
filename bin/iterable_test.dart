
void main() {
  Map kidsBooks = {'Matilda': 'Roald Dahl',
                   'Green Eggs and Ham': 'Dr Seuss',
                   'Where the Wild Things Are': 'Maurice Sendak'};
  for (var book in kidsBooks.keys) {
    print('$book was written by ${kidsBooks[book]}');
  }
}
