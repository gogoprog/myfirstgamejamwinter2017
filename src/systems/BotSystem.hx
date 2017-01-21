package systems;

import ash.tools.ListIteratingSystem;

import components.*;
import nodes.*;
import gengine.*;

class BotSystem extends ListIteratingSystem<BotNode>
{
    private var engine:Engine;

    public function new()
    {
        super(BotNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine)
    {
        this.engine = engine;
        super.addToEngine(engine);
    }

    private function updateNode(node:BotNode, dt:Float):Void
    {
    }

    private function onNodeAdded(node:BotNode)
    {
    }

    private function onNodeRemoved(node:BotNode)
    {
    }
}
