package components;

class Animated
{
    public var animations:Array<Animation> = [];
    public var time:Float = 0;

    public function new()
    {
    }

    public function push(anim:String)
    {
        animations.push(Factory.animations[anim]);
        time = 0;
    }

    public function pop()
    {
        animations.pop();
        time = 0;
    }
}
