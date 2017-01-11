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
    }

    private function onNodeAdded(node:HitNode)
    {
    }

    private function onNodeRemoved(node:HitNode)
    {
    }
}
