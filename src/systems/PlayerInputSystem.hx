package systems;

import ash.tools.ListIteratingSystem;

import components.*;
import nodes.*;
import gengine.math.*;
import gengine.*;
import gengine.components.*;

class PlayerInputSystem extends ListIteratingSystem<PlayerInputNode>
{
    private var engine:Engine;
    private var cameraEntity:Entity;

    public function new(cameraEntity)
    {
        super(PlayerInputNode, updateNode, onNodeAdded, onNodeRemoved);
        this.cameraEntity = cameraEntity;
    }

    public override function addToEngine(engine_:Engine)
    {
        engine = engine_;

        super.addToEngine(engine);
    }

    private function updateNode(node:PlayerInputNode, dt:Float):Void
    {
        var input = Gengine.getInput();
        var mousePosition = input.getMousePosition();

        var mouseScreenPosition = new Vector2(mousePosition.x / 640, mousePosition.y / 480);
        var mouseWorldPosition:Vector3 = cameraEntity.get(Camera).screenToWorldPoint(new Vector3(mouseScreenPosition.x, mouseScreenPosition.y, 0));

        if(input.getMouseButtonDown(1 << 2))
        {
            node.character.moveTarget = new Vector2(mouseWorldPosition.x, mouseWorldPosition.y);
        }

        if(input.getMouseButtonPress(1 << 0))
        {
            if(Math.random() < 0.5)
            {
                node.character.nextHitAnimation = Factory.animations["punch"];
            }
            else
            {
                node.character.nextHitAnimation = Factory.animations["punches"];
            }
        }

        if(input.getMouseButtonDown(1 << 1))
        {
            node.character.sm.changeState("dying");
        }
    }

    private function onNodeAdded(node:PlayerInputNode)
    {
    }

    private function onNodeRemoved(node:PlayerInputNode)
    {
    }
}
