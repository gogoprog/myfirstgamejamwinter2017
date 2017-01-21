package systems;

import gengine.*;
import gengine.math.*;
import ash.systems.*;

class MenuSystem extends System
{
    private var engine:Engine;
    private var cameraEntity:Entity;
    private var offset = 0.0;

    public function new(cameraEntity)
    {
        super();
        this.cameraEntity = cameraEntity;
    }

    override public function addToEngine(_engine:Engine)
    {
        engine = _engine;
        AudioSystem.instance.playMenuMusic();
    }

    override public function update(dt:Float):Void
    {
        offset += 100 * dt;
        var p = cameraEntity.position;
        p.x = Std.int(offset);
        cameraEntity.position = p;
    }
}
