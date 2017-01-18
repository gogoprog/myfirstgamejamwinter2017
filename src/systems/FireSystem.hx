package systems;

import ash.tools.ListIteratingSystem;

import components.*;
import nodes.*;
import gengine.*;

class FireSystem extends ListIteratingSystem<FireNode>
{
    private var engine:Engine;

    public function new()
    {
        super(FireNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine)
    {
        this.engine = engine;
        super.addToEngine(engine);
    }

    private function updateNode(node:FireNode, dt:Float):Void
    {
        var ca = node.animated.getCurrentAnimation();

        if(!node.fire.done && node.animated.time > ca.duration * 0.5)
        {
            var p = node.entity.position;
            node.fire.done = true;

            // todo: fire bullet.
        }

        if(ca != node.fire.animation)
        {
            node.character.sm.changeState("idling");
        }
    }

    private function onNodeAdded(node:FireNode)
    {
        node.fire.animation = Factory.animations["fire"];
        node.animated.push2(node.fire.animation);
        node.character.mustFire = false;
        node.fire.done = false;
    }

    private function onNodeRemoved(node:FireNode)
    {
    }
}
