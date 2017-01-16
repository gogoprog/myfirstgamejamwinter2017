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

        for(c in charactersList)
        {
            c.sprite.setAlpha(1);
        }

        for(c in charactersList)
        {
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

        if(closestNode != null)
        {
            var closestPos = closestNode.entity.position;
            var distance = Maths.getVector3DistanceSquared(closestPos, playerPos);
            closestNode.sprite.setAlpha(0.4);

            if(distance < 40 * 40)
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

                    if(Math.random() < 0.5)
                    {
                        node.character.nextHitAnimation = Factory.animations["punch"];
                    }
                    else
                    {
                        node.character.nextHitAnimation = Factory.animations["punches"];
                    }
                }
            }
            else
            {
                var xSign = (playerPos.x - closestPos.x) / Math.abs(playerPos.x - closestPos.x);

                if(input.getMouseButtonPress(1 << 0))
                {
                    node.character.moveTarget = new Vector2(closestPos.x + 32 * xSign, closestNode.element.y);
                }
            }
        }
        else
        {
            if(input.getMouseButtonDown(1 << 0))
            {
                node.character.moveTarget = new Vector2(mouseWorldPosition.x, mouseWorldPosition.y);
            }
        }

        if(input.getMouseButtonDown(1 << 1))
        {
            node.character.sm.changeState("dying");
        }

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
