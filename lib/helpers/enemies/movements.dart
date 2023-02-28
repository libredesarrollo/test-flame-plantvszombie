enum TypeEnemy { zombie1, zombie2 }

const sizeTileMap = 48;

class BehaviorEnemy {
  int position;
  TypeEnemy typeEnemy;

  BehaviorEnemy({required this.position, required this.typeEnemy});
}

//

const channelsMap1 = 7;

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

List enemiesInChannel = List.generate(channelsMap1, (index) => false);
