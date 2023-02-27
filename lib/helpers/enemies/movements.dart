enum TypeEnemy { zombie1, zombie2 }

const sizeTileMap = 48;

class BehaviorEnemy {
  int position;
  TypeEnemy typeEnemy;

  BehaviorEnemy({required this.position, required this.typeEnemy});
}

List<BehaviorEnemy> enemiesMap1 = [
  BehaviorEnemy(typeEnemy: TypeEnemy.zombie1, position: 4 * sizeTileMap),
  BehaviorEnemy(typeEnemy: TypeEnemy.zombie2, position: 1 * sizeTileMap),
  BehaviorEnemy(typeEnemy: TypeEnemy.zombie1, position: 2 * sizeTileMap),
  BehaviorEnemy(typeEnemy: TypeEnemy.zombie1, position: 3 * sizeTileMap),
  BehaviorEnemy(typeEnemy: TypeEnemy.zombie2, position: 4 * sizeTileMap),
  BehaviorEnemy(typeEnemy: TypeEnemy.zombie1, position: 5 * sizeTileMap),
  BehaviorEnemy(typeEnemy: TypeEnemy.zombie2, position: 6 * sizeTileMap),
  BehaviorEnemy(typeEnemy: TypeEnemy.zombie2, position: 7 * sizeTileMap),
];



/*


enum TypeEnemyMovement { random, pattern }

class BehaviorEnemy {
  BehaviorEnemy(
      {this.movementEnemies = const [],
      required this.typeEnemyMovement,
      required this.typeEnemy});

  List<PlayerDirection> movementEnemies;
  TypeEnemyMovement typeEnemyMovement;
  TypeEnemy typeEnemy;
}

List<BehaviorEnemy> enemiesMap1 = [
  BehaviorEnemy(
      typeEnemyMovement: TypeEnemyMovement.random, typeEnemy: TypeEnemy.zombie),
  BehaviorEnemy(
      typeEnemyMovement: TypeEnemyMovement.random, typeEnemy: TypeEnemy.skeleton),
  BehaviorEnemy(
      typeEnemyMovement: TypeEnemyMovement.random, typeEnemy: TypeEnemy.zombie),
  BehaviorEnemy(
      typeEnemyMovement: TypeEnemyMovement.random, typeEnemy: TypeEnemy.skeleton),
  BehaviorEnemy(
      typeEnemyMovement: TypeEnemyMovement.random, typeEnemy: TypeEnemy.skeleton),
  BehaviorEnemy(
      typeEnemyMovement: TypeEnemyMovement.random, typeEnemy: TypeEnemy.zombie),
  BehaviorEnemy(
      typeEnemyMovement: TypeEnemyMovement.random, typeEnemy: TypeEnemy.skeleton),
  BehaviorEnemy(
      typeEnemyMovement: TypeEnemyMovement.pattern,
      typeEnemy: TypeEnemy.zombie,
      movementEnemies: [
        PlayerDirection.right,
        PlayerDirection.right,
        PlayerDirection.down,
        PlayerDirection.left,
        PlayerDirection.down,
        PlayerDirection.up,
      ]),
  BehaviorEnemy(
      typeEnemyMovement: TypeEnemyMovement.pattern,
      typeEnemy: TypeEnemy.skeleton,
      movementEnemies: [
        PlayerDirection.right,
        PlayerDirection.left
      ]),
];*/