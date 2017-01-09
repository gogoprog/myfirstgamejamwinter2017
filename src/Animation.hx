import gengine.math.*;

class Animation
{
    public var frames:Array<Rect>;
    public var duration:Float;
    public var loop:Bool;

    public function new(line, from, to, framerate, frameWidth, frameHeight, width, height, loop)
    {
        var length = to - from + 1;
        frames = [];

        for(i in from...to+1)
        {
            frames.push(new Rect(new Vector2(frameWidth * (i) / width, frameHeight * (line+1) / height), new Vector2(frameWidth * (i+1) / width, frameHeight * (line) / height)));
        }

        duration = length / framerate;
        this.loop = loop;
    }
}
