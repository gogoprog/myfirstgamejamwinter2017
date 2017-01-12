package systems;

import ash.tools.ListIteratingSystem;

import components.*;
import nodes.*;
import gengine.*;

class HitSystem extends ListIteratingSystem<HitNode>
{
    private var engine:Engine;

    public function new()
    {
        super(HitNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine)
    {
        this.engine = engine;
        super.addToEngine(engine);
    }

    private function updateNode(node:HitNode, dt:Float):Void
    {
        if(node.animated.getCurrentAnimation() != node.hit.animation)
        {
            node.character.sm.changeState("idling");
        }
    }

    private function onNodeAdded(node:HitNode)
    {
        node.hit.animation = node.character.nextHitAnimation;
        node.animated.push2(node.hit.animation);
        node.character.nextHitAnimation = null;
    }

    private function onNodeRemoved(node:HitNode)
    {
    }
}
