package systems;

import ash.tools.ListIteratingSystem;

import components.*;
import nodes.*;
import gengine.math.*;
import gengine.*;

class AnimatedSystem extends ListIteratingSystem<AnimatedNode>
{
    private var engine:Engine;

    public function new()
    {
        super(AnimatedNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine_:Engine)
    {
        engine = engine_;

        super.addToEngine(engine);
    }

    private function updateNode(node:AnimatedNode, dt:Float):Void
    {
        var animated = node.animated;
        var sprite = node.sprite;
        var animation = animated.animation;

        var duration = (animation.length / animation.framerate);

        animated.time += dt;

        if(animated.loop)
        {
            while(animated.time >= duration)
            {
                animated.time -= duration;
            }
        }
        else
        {
            if(animated.time > duration)
            {
                animated.time = duration - 0.0000001;
            }
        }

        var frame = Std.int((animated.time / duration) * animation.length);
        var line = animation.line;

        sprite.setTextureRect(new Rect(new Vector2(64 * (frame) / 1024, 64 * (line+1) / 1024), new Vector2(64 * (frame+1) / 1024, 64 * (line) / 1024)));
    }

    private function onNodeAdded(node:AnimatedNode)
    {
    }

    private function onNodeRemoved(node:AnimatedNode)
    {
    }
}
