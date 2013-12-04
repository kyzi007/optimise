package cellExample {
    import flash.geom.Rectangle;

    public class Cell {
        public static var SIZE_W:int = 100;
        public static var SIZE_H:int = 100;
        public var rect:Rectangle = new Rectangle(0, 0, SIZE_W, SIZE_H);
        private var _y:int;
        private var _x:int;

        public function Cell (x, y) {
            this._x = x;
            this._y = y;
            rect.x = x * SIZE_W;
            rect.y = y * SIZE_H;
        }
    }
}
