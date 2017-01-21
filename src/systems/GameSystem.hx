package systems;

import gengine.*;
import gengine.math.*;
import ash.systems.*;

class GameSystem extends System
{
    private var engine:Engine;
    private var cameraEntity:Entity;

    public function new(cameraEntity)
    {
        super();
        this.cameraEntity = cameraEntity;
    }

    override public function addToEngine(_engine:Engine)
    {
        engine = _engine;
        cameraEntity.position = new Vector3(0, 0, 0);
    }

    override public function update(dt:Float):Void
    {

    }
}
