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
    }

    private function onNodeAdded(node:HurtNode)
    {
    }

    private function onNodeRemoved(node:HurtNode)
    {
    }
}
