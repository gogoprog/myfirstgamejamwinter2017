package systems;

import ash.tools.ListIteratingSystem;

import components.*;
import gengine.components.*;
import nodes.*;
import gengine.*;
import gengine.math.*;

class LevelSystem extends ListIteratingSystem<LevelNode>
{
    private var engine:Engine;
    private var cameraEntity:Entity;
    private var loop:Int;
    private var zone:Int;
    private var levelCount:Int = 2;
    private var totalLength:Int;
    private var levelLength:Int;
    private var factor:Float;
    private var offset = new Vector3(-400, -400, 0);

    public function new(cameraEntity)
    {
        super(LevelNode, updateNode, onNodeAdded, onNodeRemoved);
        this.cameraEntity = cameraEntity;
    }

    public override function addToEngine(engine:Engine)
    {
        this.engine = engine;
        super.addToEngine(engine);

        var e = Factory.createMap();
        e.get(Level).index = 0;
        engine.addEntity(e);
        e.scale = new Vector3(1, 1, 1);
        e.get(TileMap2D).setTmxFile(Gengine.getResourceCache().getTmxFile2D("map.tmx", true));

        var e = Factory.createMap();
        e.get(Level).index = 1;
        engine.addEntity(e);
        e.scale = new Vector3(1, 1, 1);
        e.get(TileMap2D).setTmxFile(Gengine.getResourceCache().getTmxFile2D("map.tmx", true));

        levelLength = 48*64;
        totalLength = levelLength * levelCount;
    }

    public override function update(dt:Float):Void
    {
        var camPos = cameraEntity.position;
        loop = Math.floor((camPos.x - offset.x) / totalLength);
        zone = Math.floor((camPos.x - offset.x) / levelLength);
        while(zone < 0) zone += levelCount;
        zone = zone % levelCount;

        var x = camPos.x - offset.x;
        while(x < 0) x += levelLength;

        factor = (x % levelLength) / levelLength;

        super.update(dt);
    }

    private function updateNode(node:LevelNode, dt:Float):Void
    {
        var l = node.level.index;

        node.entity.position = new Vector3(offset.x + levelLength*l + totalLength*loop, offset.y, 0);

        if(factor < 0.5)
        {
            if(l == levelCount - 1 && zone == 0)
            {
                node.entity.position = new Vector3(offset.x + levelLength*l + totalLength*(loop - 1), offset.y, 0);
            }
        }

        if(factor > 0.5)
        {
            if(zone == levelCount-1 && l == 0)
            {
                node.entity.position = new Vector3(offset.x + levelLength*l + totalLength*(loop + 1), offset.y, 0);
            }
        }
    }

    private function onNodeAdded(node:LevelNode)
    {
    }

    private function onNodeRemoved(node:LevelNode)
    {
    }
}
