public class BearMonster extends Monster {

    public BearMonster(AttackBehavior a, DefenseBehavior d) {
        attackBehavior = a;
        defenseBehavior = d;
        name = "Bear!";
    }

    public void display() {
        System.out.println("Bear Monster!");
    }
}

