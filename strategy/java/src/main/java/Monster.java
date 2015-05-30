public abstract class Monster {

    // Monsters have behaviors, but they are specific to the type
    AttackBehavior attackBehavior;
    DefenseBehavior defenseBehavior;
    String name;

    public Monster() {}

    public abstract void display();

    public String performAttack() {
        return attackBehavior.attack();
    }

    public String performDefense() {
        return defenseBehavior.defend();
    }
}

