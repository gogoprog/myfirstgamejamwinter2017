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
        var c = node.character;
        var b = node.bot;

        if(c.hitter != null)
        {
            b.willAttack = true;
        }

        b.timeLeft -= dt;

        if(b.timeLeft < 0)
        {
            b.timeLeft = b.latency.x + (b.latency.y - b.latency.x) * Math.random();

            if(b.willAttack)
            {
                b.willAttack = false;
                c.mustAttack = true;
            }
        }
    }

    private function onNodeAdded(node:BotNode)
    {
    }

    private function onNodeRemoved(node:BotNode)
    {
    }
}
