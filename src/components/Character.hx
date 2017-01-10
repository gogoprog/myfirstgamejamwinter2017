package components;

import gengine.math.*;

class Character
{
    public var moveTarget:Vector2 = null;
    public var moveStartPosition:Vector2 = null;
    public var moveTime:Float = 0;
    public var moveDuration:Float = 0;
    public var y:Float = 0;

    public var moveSpeed:Float = 100.0;

    public function new()
    {
    }
}
