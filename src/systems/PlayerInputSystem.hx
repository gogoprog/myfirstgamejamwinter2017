package systems;

import ash.tools.ListIteratingSystem;
import ash.core.NodeList;

import components.*;
import nodes.*;
import gengine.math.*;
import gengine.*;
import gengine.components.*;

class PlayerInputSystem extends ListIteratingSystem<PlayerInputNode>
{
    private var engine:Engine;
    private var cameraEntity:Entity;
    private var charactersList:NodeList<CharacterNode>;
    private var targetCircle:Entity;

    public function new(cameraEntity)
    {
        super(PlayerInputNode, updateNode, onNodeAdded, onNodeRemoved);
        this.cameraEntity = cameraEntity;
    }

    public override function addToEngine(engine_:Engine)
    {
        engine = engine_;

        super.addToEngine(engine);

        charactersList = engine.getNodeList(CharacterNode);

        targetCircle = Factory.createCircle();
        targetCircle.scale = new Vector3(2, 2, 1);

        engine.addEntity(targetCircle);
    }

    private function updateNode(node:PlayerInputNode, dt:Float):Void
    {
        var input = Gengine.getInput();
        var mousePosition = input.getMousePosition();

        var mouseScreenPosition = new Vector2(mousePosition.x / 800, mousePosition.y / 600);
        var mouseWorldPosition:Vector3 = cameraEntity.get(Camera).screenToWorldPoint(new Vector3(mouseScreenPosition.x, mouseScreenPosition.y, 0));

        var closestNode:CharacterNode = null;
        var closestDistance:Float = Math.POSITIVE_INFINITY;

        var playerPos = node.entity.position;
        var cameraPos = cameraEntity.position;

        if(node.character.moveTarget != null)
        {
            targetCircle.position = new Vector3(node.character.moveTarget.x, node.character.moveTarget.y - 16, 0);

        }
        else
        {
            targetCircle.position = new Vector3(-1000, -10000, 0);
        }

        for(c in charactersList)
        {
            c.sprite.setColor(c.character.baseColor);

            if(c.entity != node.entity && c.character.life > 0)
            {
                var p2 = c.entity.position;
                if(Math.abs(p2.x - mouseWorldPosition.x) < 35 && mouseWorldPosition.y > p2.y - 75 && mouseWorldPosition.y < p2.y + 32)
                {
                    var distance = Maths.getVector3DistanceSquared(mouseWorldPosition, p2);

                    if(distance < closestDistance)
                    {
                        closestDistance = distance;
                        closestNode = c;
                    }
                }
            }
        }

        if(input.getMouseButtonPress(1 << 0))
        {
            node.character.mustAttack = true;
        }

        if(closestNode != null)
        {
            var closestPos = closestNode.entity.position;
            targetCircle.position = new Vector3(closestPos.x, closestPos.y - 64, 0);

            var deltaX = Math.abs(closestPos.x - playerPos.x);
            var deltaY = Math.abs(closestPos.y - playerPos.y);
            var distance = Maths.getVector3DistanceSquared(closestPos, playerPos);
            closestNode.sprite.setColor(new Color(closestNode.character.baseColor.r, closestNode.character.baseColor.g - 0.2, closestNode.character.baseColor.b - 0.2, 1));

            if(deltaX < 40 && deltaY < 20)
            {
                if(input.getMouseButtonPress(1 << 0))
                {
                    if(playerPos.x < closestPos.x)
                    {
                        node.entity.scale = new Vector3(1, 1, 1);
                    }
                    else
                    {
                        node.entity.scale = new Vector3(-1, 1, 1);
                    }

                    node.character.mustAttack = true;
                }
            }

            {
                var xSign = (playerPos.x - closestPos.x) / Math.abs(playerPos.x - closestPos.x);

                if(input.getMouseButtonDown(1 << 2))
                {
                    node.character.moveTarget = new Vector2(closestPos.x + 32 * xSign, closestNode.element.y);
                }
            }
        }
        else
        {
            if(input.getMouseButtonDown(1 << 2))
            {
                node.character.moveTarget = new Vector2(mouseWorldPosition.x, mouseWorldPosition.y);
            }
        }

        /*if(input.getMouseButtonPress(1 << 0))
        {
            node.character.mustFire = true;
        }*/

        if(playerPos.x - cameraPos.x > 200)
        {
            cameraEntity.position = new Vector3(Std.int(playerPos.x - 200), 0, 0);
        }

        if(playerPos.x - cameraPos.x < -200)
        {
            cameraEntity.position = new Vector3(Std.int(playerPos.x + 200), 0, 0);
        }
    }

    private function onNodeAdded(node:PlayerInputNode)
    {
    }

    private function onNodeRemoved(node:PlayerInputNode)
    {
    }
}
