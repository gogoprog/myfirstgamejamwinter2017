package systems;

import ash.tools.ListIteratingSystem;
import ash.core.NodeList;

import components.*;
import nodes.*;
import gengine.*;

class HitSystem extends ListIteratingSystem<HitNode>
{
    private var engine:Engine;
    private var charactersList:NodeList<CharacterNode>;
    private var attackNames = [
        "punches",
        "lowkick",
        "middlekick",
        "highkick",
        "downwardkick",
        "roundkick",
        "uppercut"
        ];

    private var attacks:Array<Animation> = [];

    public function new()
    {
        super(HitNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine)
    {
        this.engine = engine;
        super.addToEngine(engine);
        charactersList = engine.getNodeList(CharacterNode);

        for(n in attackNames)
        {
            attacks.push(Factory.animations[n]);
        }
    }

    private function updateNode(node:HitNode, dt:Float):Void
    {
        var ca = node.animated.getCurrentAnimation();

        if(!node.hit.done && node.animated.time > ca.duration * 0.5)
        {
            var p = node.entity.position;
            node.hit.done = true;

            for(other in charactersList)
            {
                if(other.entity != node.entity && other.character.life > 0)
                {
                    var p2 = other.entity.position;
                    var delta = p2.x - p.x;

                    if(Math.abs(delta) < 40 && delta / Math.abs(delta) == node.entity.scale.x && Math.abs(p2.y - p.y) < 20)
                    {
                        other.character.hitter = node.entity;
                        other.character.sm.changeState("hurting");
                    }
                }
            }
        }

        if(ca != node.hit.animation)
        {
            node.character.sm.changeState("idling");
        }
    }

    private function onNodeAdded(node:HitNode)
    {
        node.hit.animation = attacks[Std.random(attacks.length)];
        node.animated.push2(node.hit.animation);
        node.character.mustAttack = false;
        node.character.moveTarget = null;
        node.hit.done = false;

        AudioSystem.instance.playSound("hit", node.entity.position);
    }

    private function onNodeRemoved(node:HitNode)
    {
        var ca = node.animated.getCurrentAnimation();

        if(ca == node.hit.animation)
        {
            node.animated.pop();
        }
    }
}
