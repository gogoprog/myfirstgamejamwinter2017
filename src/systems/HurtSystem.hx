package systems;

import ash.tools.ListIteratingSystem;

import components.*;
import nodes.*;
import gengine.*;

class HurtSystem extends ListIteratingSystem<HurtNode>
{
    private var engine:Engine;

    public function new()
    {
        super(HurtNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine)
    {
        this.engine = engine;
        super.addToEngine(engine);
    }

    private function updateNode(node:HurtNode, dt:Float):Void
    {
        var ca = node.animated.getCurrentAnimation();

        if(ca != node.hurt.animation)
        {
            node.character.sm.changeState("idling");
        }
    }

    private function onNodeAdded(node:HurtNode)
    {
        node.hurt.animation = Factory.animations["death"];
        node.animated.push2(node.hurt.animation);
    }

    private function onNodeRemoved(node:HurtNode)
    {
    }
}
