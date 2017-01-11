package systems;

import ash.tools.ListIteratingSystem;

import components.*;
import nodes.*;
import gengine.math.*;
import gengine.*;

class StreetSystem extends ListIteratingSystem<StreetElementNode>
{
    private var engine:Engine;

    public function new()
    {
        super(StreetElementNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine_:Engine)
    {
        engine = engine_;

        super.addToEngine(engine);
    }

    private function updateNode(node:StreetElementNode, dt:Float):Void
    {
        var p = node.entity.position;
        p.y = node.element.y + node.element.offset;
        node.entity.position = p;
        node.sprite.setOrderInLayer(Std.int(-p.y));
    }

    private function onNodeAdded(node:StreetElementNode)
    {
    }

    private function onNodeRemoved(node:StreetElementNode)
    {
    }
}
