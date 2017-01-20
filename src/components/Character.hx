package components;

import gengine.math.*;
import gengine.Entity;
import ash.fsm.*;

class Character
{
    public var sm:EntityStateMachine;
    public var moveSpeed:Float = 250.0;
    public var moveTarget:Vector2 = null;
    public var life:Float = 100.0;
    public var mustAttack:Bool;
    public var mustFire:Bool;
    public var hitter:Entity;
    public var baseColor:Color;

    public function new()
    {
    }
}
