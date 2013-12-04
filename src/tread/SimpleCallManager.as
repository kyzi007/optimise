package tread {
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.utils.getTimer;

    public class SimpleCallManager extends EventDispatcher {
        public var fps:int = 25;

        private var _frameTime:int;
        private var _callback:Function;
        private var _frameRound:Number = 1;
        private var _dispatcher:EventDispatcher;

        public function SimpleCallManager (dispatcher:EventDispatcher) {
            _dispatcher = dispatcher;
        }

        /**
         * start calculations
         * @param callback
         */
        public function start (callback:Function):void {
            _callback = callback;
            _dispatcher.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
            enterFrameHandler(null);
        }

        private function enterFrameHandler (event:Event):void {
            var time:int = getTimer();
            // one call target
            while (true) {
                if (!_callback()) {
                    if (getTimer() - time > _frameTime) {
                        break;
                    }
                } else {
                    finish();
                    dispatchEvent(new CallManagerEvent(CallManagerEvent.FINISH, _callback));
                    break;
                }
            }
        }

        private function finish ():void {
            _dispatcher.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
            _callback = null;
        }

        /**
         * make time for other calculations (stage draw, for example)
         * @param value
         */
        public function set frameRound (value:Number):void {
            _frameRound = value;
            _frameTime = _frameRound * 1000 / fps;
        }

        public function get frameRound ():Number {
            return _frameRound;
        }
    }
}
