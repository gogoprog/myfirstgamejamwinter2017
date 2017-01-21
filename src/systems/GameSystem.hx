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
    private var timeSinceDeath:Float;

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

        playerEntity.get(Character).life = 500;
        timeSinceDeath = 0;
        playerEntity.get(Character).sm.changeState("idling");
        playerEntity.get(Animated).animations = [];
        playerEntity.get(Animated).lock = false;
        playerEntity.get(Animated).push("idle");
        playerEntity.position = new Vector3(0, 0, 0);

        trace("START");
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

        if(playerEntity.get(Character).life <= 0)
        {
            timeSinceDeath += dt;

            if(timeSinceDeath > 3)
            {
                Application.changeState("menu");
                Application.pages.showPage(".menu");
            }
        }
    }

    private function onNewFarthest(f:Int)
    {
        if(f % 5 == 0)
        {
            var n = 1;

            n += Std.int(Math.random() * f / 20);

            for(i in 0...n)
            {
                var e = Factory.createEnemy();

                e.position = new Vector3(cameraEntity.position.x + 432 + Std.random(10) * 20, Std.random(10) * - 25, 0);
                e.get(StreetElement).y = Std.random(10) * - 25;
                e.scale = new Vector3(-1,1,1);
                e.get(Character).moveSpeed = 20 + f / 10;
                e.get(Bot).latency = new Vector2(2 - f/20, 2 - f/20 + 10/f);

                engine.addEntity(e);
            }
        }
    }
}
