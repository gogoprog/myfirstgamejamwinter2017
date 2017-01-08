import gengine.math.*;

class Animation
{
    public var frames:Array<Rect>;
    public var duration:Float;

    public function new(line, length, framerate, frameWidth, frameHeight, width, height)
    {
        frames = [];

        for(i in 0...length)
        {
            frames.push(new Rect(new Vector2(frameWidth * (i) / width, frameHeight * (line+1) / height), new Vector2(frameWidth * (i+1) / width, frameHeight * (line) / height)));
        }

        duration = length / framerate;
    }
}
