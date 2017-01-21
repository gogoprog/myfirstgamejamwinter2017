package systems;

import ash.tools.ListIteratingSystem;

import components.*;
import nodes.*;
import gengine.*;

class DeathSystem extends ListIteratingSystem<DeathNode>
{
    private var engine:Engine;

    public function new()
    {
        super(DeathNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine)
    {
        this.engine = engine;
        super.addToEngine(engine);
    }

    private function updateNode(node:DeathNode, dt:Float):Void
    {
        /*if(node.animated.getCurrentAnimation().name != "death")
        {
            node.animated.push("death");
            node.animated.lock = true;
            node.character.moveTarget = null;
        }*/
    }

    private function onNodeAdded(node:DeathNode)
    {
        node.animated.push("death");
        node.animated.lock = true;
        node.character.moveTarget = null;
        AudioSystem.instance.playSound("death", node.entity.position);
    }

    private function onNodeRemoved(node:DeathNode)
    {
    }
}
