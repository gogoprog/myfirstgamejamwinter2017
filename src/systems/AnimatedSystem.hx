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

    }

    private function onNodeAdded(node:AnimatedNode)
    {
    }

    private function onNodeRemoved(node:AnimatedNode)
    {
    }
}
