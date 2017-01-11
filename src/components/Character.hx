package components;

import gengine.math.*;
import ash.fsm.*;

class Character
{
    public var sm:EntityStateMachine;
    public var moveSpeed:Float = 100.0;
    public var moveTarget:Vector2 = null;

    public function new()
    {
    }
}
