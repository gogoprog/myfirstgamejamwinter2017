import gengine.math.*;

class Animation
{
    public var line:Int;
    public var length:Int;
    public var framerate:Int;
    public var frames:Array<Rect>;

    public function new(line, length, framerate, frameWidth, frameHeight, width, height)
    {
        this.line = line;
        this.length = length;
        this.framerate = framerate;

        frames = [];

        for(i in 0...length)
        {
            frames.push(new Rect(new Vector2(frameWidth * (i) / width, frameHeight * (line+1) / height), new Vector2(frameWidth * (i+1) / width, frameHeight * (line) / height)));
        }
    }
}
