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
        var animation = animated.getCurrentAnimation();

        var duration = animation.duration;

        animated.time += dt;

        if(animation.loop)
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

                if(animated.animations.length > 1)
                {
                    animated.pop();
                }
            }
        }

        var frame = Std.int((animated.time / duration) * animation.frames.length);

        sprite.setTextureRect(animation.frames[frame]);
    }

    private function onNodeAdded(node:AnimatedNode)
    {
    }

    private function onNodeRemoved(node:AnimatedNode)
    {
    }
}
