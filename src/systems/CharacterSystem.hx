package systems;

import ash.tools.ListIteratingSystem;

import components.*;
import nodes.*;
import gengine.math.*;
import gengine.*;

class CharacterSystem extends ListIteratingSystem<CharacterNode>
{
    private var engine:Engine;

    public function new()
    {
        super(CharacterNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine_:Engine)
    {
        engine = engine_;

        super.addToEngine(engine);
    }

    private function updateNode(node:CharacterNode, dt:Float):Void
    {

    }

    private function onNodeAdded(node:CharacterNode)
    {
    }

    private function onNodeRemoved(node:CharacterNode)
    {
    }
}
