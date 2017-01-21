package systems;

import gengine.*;
import gengine.math.*;
import ash.systems.*;
import nodes.*;
import components.*;
import js.jquery.*;

class GameSystem extends System
{
    private var engine:Engine;
    private var cameraEntity:Entity;
    private var playerEntity:Entity;
    private var farthest:Int;
    private var farthestSpan:JQuery;

    public function new(cameraEntity)
    {
        super();
        this.cameraEntity = cameraEntity;
    }

    override public function addToEngine(_engine:Engine)
    {
        engine = _engine;
        cameraEntity.position = new Vector3(0, 0, 0);
        AudioSystem.instance.playGameMusic();

        var list = engine.getNodeList(BotNode);

        for(n in list)
        {
            engine.updateComplete.addOnce(function() {
                engine.removeEntity(n.entity);
            });
        }

        var list = engine.getNodeList(PlayerInputNode);

        for(n in list)
        {
            playerEntity = n.entity;
        }

        farthest = 0;
        farthestSpan = new JQuery(".farthest");
        farthestSpan.text(""+farthest);
    }

    override public function update(dt:Float):Void
    {
        var playerPos = playerEntity.position;
        var ix = Std.int(playerPos.x / 100);

        if(ix > farthest)
        {
            farthest = ix;
            farthestSpan.text(""+farthest);

            onNewFarthest(ix);
        }
    }

    private function onNewFarthest(f:Int)
    {
        if(f % 10 == 0)
        {
            var e = Factory.createEnemy();

            e.position = new Vector3(cameraEntity.position.x + 400 + Std.random(10) * 20, Std.random(10) * - 25, 0);
            e.get(StreetElement).y = Std.random(10) * - 25;
            e.scale = new Vector3(-1,1,1);

            engine.addEntity(e);
        }
    }
}
