package systems;

import ash.tools.ListIteratingSystem;

import components.*;
import nodes.*;
import gengine.*;
import gengine.math.*;

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
        var ca = node.animated.getCurrentAnimation();

        if(ca != node.hurt.animation)
        {
            node.character.sm.changeState("idling");
        }
    }

    private function onNodeAdded(node:HurtNode)
    {
        node.hurt.hitter = node.character.hitter;
        node.hurt.animation = Factory.animations["hit"];
        node.animated.push2(node.hurt.animation);

        var hitterPos = node.hurt.hitter.position;
        var p = node.entity.position;

        if(p.x < hitterPos.x)
        {
            node.entity.scale = new Vector3(1, 1, 1);
        }
        else
        {
            node.entity.scale = new Vector3(-1, 1, 1);
        }

        node.character.life -= 10;

        if(node.character.life <= 0)
        {
            node.character.sm.changeState("dying");
        }

        AudioSystem.instance.playSound("hurt", node.entity.position);
    }

    private function onNodeRemoved(node:HurtNode)
    {
    }
}
