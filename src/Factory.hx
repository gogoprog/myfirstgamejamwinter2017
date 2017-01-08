import gengine.*;
import gengine.components.*;
import ash.systems.*;
import ash.fsm.*;
import components.*;
import gengine.math.*;
import haxe.ds.Vector;

class Factory
{
    static var catSprite:Dynamic;
    public static var animations:Map<String, Animation>;

    static public function init()
    {
        catSprite = Gengine.getResourceCache().getSprite2D("cat.png", true);

        animations = new Map();

        animations["idle"] = new Animation(0, 4, 15, 64, 64, 1024, 1024);
        animations["walk"] = new Animation(1, 8, 15, 64, 64, 1024, 1024);
    }

    static public function createAnimatedSprite():Entity
    {
        var e = new Entity();
        e.add(new StaticSprite2D());
        e.get(StaticSprite2D).setDrawRect(new Rect(new Vector2(-32, -32), new Vector2(32, 32)));
        e.get(StaticSprite2D).setUseDrawRect(true);
        e.get(StaticSprite2D).setTextureRect(new Rect(new Vector2(0, 64/1024), new Vector2(64/1024, 0)));
        e.get(StaticSprite2D).setUseTextureRect(true);
        e.get(StaticSprite2D).setSprite(catSprite);
        e.get(StaticSprite2D).setLayer(0);

        e.add(new Animated());
        e.get(Animated).animation = animations["walk"];

        return e;
    }

    static public function createCamera()
    {
        var cameraEntity = new Entity();
        cameraEntity.add(new Camera());
        cameraEntity.get(Camera).setOrthoSize(new Vector2(1024, 768));
        cameraEntity.get(Camera).setOrthographic(true);

        return cameraEntity;
    }
}
