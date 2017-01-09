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
        var p = node.entity.position;
        var c = node.character;
        p.y = node.character.y;

        if(c.moveTarget != null)
        {
            var f:Float;

            if(c.moveStartPosition == null)
            {
                c.moveTime = 0;
                c.moveStartPosition = new Vector2(p.x, c.y);
                c.moveDuration = Maths.getVector2Distance(c.moveStartPosition, c.moveTarget) / c.moveSpeed;

                if(node.animated.getCurrentAnimation().name != "walk")
                {
                    node.animated.push("walk");
                }
            }

            c.moveTime += dt;

            if(c.moveTime > c.moveDuration)
            {
                f = 1;
            }
            else
            {
                f = c.moveTime / c.moveDuration;
            }

            var result = c.moveStartPosition + (c.moveTarget - c.moveStartPosition) * f;

            p.x = result.x;
            c.y = p.y = result.y;

            if(c.moveTarget.x > c.moveStartPosition.x)
            {
                node.entity.scale = new Vector3(1, 1, 1);
            }
            else
            {
                node.entity.scale = new Vector3(-1, 1, 1);
            }

            if(f == 1)
            {
                c.moveTarget = null;
                c.moveStartPosition = null;
                node.animated.pop();
            }
        }

        node.entity.position = p;
        node.sprite.setOrderInLayer(Std.int(-p.y));
    }

    private function onNodeAdded(node:CharacterNode)
    {
    }

    private function onNodeRemoved(node:CharacterNode)
    {
    }
}
