import 'dart:io';

void main() {
  stdout.write('Entrez le premier nombre : ');
  int nombre1 = int.parse(stdin.readLineSync()!);

  stdout.write('Entrez le deuxième nombre : ');
  int nombre2 = int.parse(stdin.readLineSync()!);

  try {
    int resultat = nombre1 ~/ nombre2;
    print('Le résultat de la division est : $resultat');
  } catch (e) {
    print("Erreur : Division par zéro");
  }
  print("suite du programme");
}
