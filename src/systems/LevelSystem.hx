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
        e.position = new Vector3(-400, -400, 0);
        e.get(TileMap2D).setTmxFile(Gengine.getResourceCache().getTmxFile2D("map.tmx", true));

        var e = Factory.createMap();
        e.get(Level).index = 1;
        engine.addEntity(e);
        e.scale = new Vector3(1, 1, 1);
        e.position = new Vector3(-400, -400, 0);
        e.get(TileMap2D).setTmxFile(Gengine.getResourceCache().getTmxFile2D("map.tmx", true));

        levelLength = 48*64;
        totalLength = levelLength * levelCount;
    }

    public override function update(dt:Float):Void
    {
        var camPos = cameraEntity.position;
        loop = Std.int(camPos.x / totalLength);
        zone = Std.int(camPos.x / levelLength);
        zone = zone % levelCount;

        factor = (camPos.x % levelLength) / levelLength;

        super.update(dt);
    }

    private function updateNode(node:LevelNode, dt:Float):Void
    {
        var l = node.level.index;

        node.entity.position = new Vector3(-400 + levelLength*l + totalLength*loop, -400, 0);

        if(factor < 0.5)
        {
            if(l == levelCount - 1 && zone == 0)
            {
                node.entity.position = new Vector3(-400 + levelLength*l + totalLength*(loop - 1), -400, 0);
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
