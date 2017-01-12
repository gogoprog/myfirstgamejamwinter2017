package components;

class Animated
{
    public var animations:Array<Animation> = [];
    public var time:Float = 0;
    public var lock = false;

    public function new()
    {
    }

    public function push(anim:String)
    {
        animations.push(Factory.animations[anim]);
        time = 0;
    }

    public function push2(anim:Animation)
    {
        animations.push(anim);
        time = 0;
    }

    public function pop()
    {
        animations.pop();
        time = 0;
    }

    public function getCurrentAnimation()
    {
        return animations[animations.length - 1];
    }
}
