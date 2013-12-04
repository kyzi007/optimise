package utils {
    import flash.utils.getTimer;

    public class TimeDebug {
        private static var _time:int;

        public static function start ():void {
            _time = getTimer();
        }

        public static function end ():int {
            return getTimer() - _time;
        }
    }
}
