package components;

import gengine.math.*;
import gengine.Entity;
import ash.fsm.*;

class Character
{
    public var sm:EntityStateMachine;
    public var moveSpeed:Float = 100.0;
    public var moveTarget:Vector2 = null;
    public var life:Float = 100.0;
    public var nextHitAnimation:Animation;
    public var hitter:Entity;

    public function new()
    {
    }
}
