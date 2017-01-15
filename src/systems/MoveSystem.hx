package systems;

import ash.tools.ListIteratingSystem;

import components.*;
import nodes.*;
import gengine.*;
import gengine.math.*;

class MoveSystem extends ListIteratingSystem<MoveNode>
{
    private var engine:Engine;

    public function new()
    {
        super(MoveNode, updateNode, onNodeAdded, onNodeRemoved);
    }

    public override function addToEngine(engine:Engine)
    {
        this.engine = engine;
        super.addToEngine(engine);
    }

    private function updateNode(node:MoveNode, dt:Float):Void
    {
        var p = node.entity.position;
        var c = node.character;
        var m = node.move;
        var e = node.element;

        var f:Float;

        if(c.moveTarget != m.moveTarget)
        {
            m.moveTime = 0;
            m.moveTarget = c.moveTarget;
            m.moveSpeed = c.moveSpeed;
            m.moveStartPosition = new Vector2(p.x, e.y);
            m.moveDuration = Maths.getVector2Distance(m.moveStartPosition, c.moveTarget) / c.moveSpeed;
        }

        m.moveTime += dt;

        if(m.moveTime > m.moveDuration)
        {
            f = 1;
        }
        else
        {
            f = m.moveTime / m.moveDuration;
        }

        var result = m.moveStartPosition + (m.moveTarget - m.moveStartPosition) * f;

        p.x = result.x;
        e.y = result.y;
        e.y = Math.min(e.y, 0);
        e.y = Math.max(e.y, -200);

        if(m.moveTarget.x > m.moveStartPosition.x)
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
            c.sm.changeState("idling");
        }

        node.entity.position = p;
    }

    private function onNodeAdded(node:MoveNode)
    {
        node.animated.push("walk");
    }

    private function onNodeRemoved(node:MoveNode)
    {
        node.animated.pop();
    }
}
