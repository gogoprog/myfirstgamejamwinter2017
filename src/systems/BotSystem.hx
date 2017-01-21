package systems;

import ash.tools.ListIteratingSystem;

import components.*;
import nodes.*;
import gengine.*;
import gengine.math.*;

class BotSystem extends ListIteratingSystem<BotNode>
{
    private var engine:Engine;
    private var playerEntity:Entity;

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

        if(c.life <= 0)
        {
            return;
        }

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
                b.targetPlayer = true;
            }
            else
            {
                if(Math.random() < 0.1)
                {
                    c.mustAttack = true;
                }
                else
                {
                    if(b.targetPlayer)
                    {
                        if(Math.random() < 0.5)
                        {
                            var x = playerEntity.position.x;
                            var y = playerEntity.get(StreetElement).y;

                            c.moveTarget = new Vector2(Math.random() < 0.5 ? x - 32 : x + 32, y - 16 + 32 * Math.random());
                            b.willAttack = true;
                        }
                        else
                        {
                            c.mustAttack = true;
                        }
                    }
                    else
                    {
                        var x = node.entity.position.x;
                        var y = node.element.y;

                        var x = x - Math.random() * 100 - 32;
                        var y = y - 64 + Math.random() * 128;

                        c.moveTarget = new Vector2(x, y);
                    }
                }
            }
        }
    }

    private function onNodeAdded(node:BotNode)
    {
        if(playerEntity == null)
        {
            var list = engine.getNodeList(PlayerInputNode);

            for(n in list)
            {
                playerEntity = n.entity;
            }
        }
    }

    private function onNodeRemoved(node:BotNode)
    {
    }
}
