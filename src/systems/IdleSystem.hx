package systems;

import ash.tools.ListIteratingSystem;

import components.*;
import nodes.*;
import gengine.*;

class IdleSystem extends ListIteratingSystem<IdleNode>
{
    private var engine:Engine;

    public function new()
    {
        super(IdleNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine)
    {
        this.engine = engine;
        super.addToEngine(engine);
    }

    private function updateNode(node:IdleNode, dt:Float):Void
    {
        var c = node.character;

        if(c.moveTarget != null)
        {
            trace("YES TARGET");
            trace(c.moveTarget);
            c.sm.changeState("moving");
        }
    }

    private function onNodeAdded(node:IdleNode)
    {
    }

    private function onNodeRemoved(node:IdleNode)
    {
    }
}
