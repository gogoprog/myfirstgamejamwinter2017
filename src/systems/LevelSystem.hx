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
    private var zone:Int;
    private var levelCount:Int = 2;

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
    }

    public override function update(dt:Float):Void
    {
        var camPos = cameraEntity.position;
        zone = Std.int(camPos.x / (48*64 * levelCount));

        super.update(dt);
    }

    private function updateNode(node:LevelNode, dt:Float):Void
    {
        node.entity.position = new Vector3(-400 + 48*64 * node.level.index + 48*64*levelCount*zone, -400, 0);
    }

    private function onNodeAdded(node:LevelNode)
    {
    }

    private function onNodeRemoved(node:LevelNode)
    {
    }
}
