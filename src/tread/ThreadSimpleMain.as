package tread {
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.utils.getTimer;

    import utils.TimeDebug;

    [SWF(frameRate=20)]
    public class ThreadSimpleMain extends Sprite {

        private static const _FPS:int = 20;

        private var _frameTime:int;
        private var _testArray:Array;
        private var _countCall:int = 0;
        private var _maxCountCall:int = 0;
        private var _ui:ThreadUI;


        public function ThreadSimpleMain () {
            _ui = new ThreadUI();
            _ui.sliceCount.addEventListener(Event.CHANGE, changeSliceCountHandler);
            changeSliceCountHandler(null);

            _ui.sliceFrameRound.addEventListener(Event.CHANGE, changeSliceFrameRoundHandler);
            changeSliceFrameRoundHandler(null);

            _ui.btnNormal.addEventListener(MouseEvent.CLICK, clickBtnNormalHandler);
            _ui.btnEnterFrame.addEventListener(MouseEvent.CLICK, clickBtnEnterFrameHandler);

            _ui.x = 20;
            _ui.y = 20;
            addChild(_ui);
        }

        private function changeSliceFrameRoundHandler (event:Event):void {
            _frameTime = (_ui.sliceFrameRound.value / 100) * 1000 / 20;// fps * ms * percent
            _ui.labelFrameRound.text = "time calculations in frame" + _frameTime;
        }

        private function changeSliceCountHandler (event:Event):void {
            _maxCountCall = _ui.sliceCount.value * 1000;
            _ui.labelCount.text = "amount of calls" + _maxCountCall;
        }

        private function clickBtnEnterFrameHandler (event:MouseEvent):void {
            TimeDebug.start();
            _testArray = [];
            _countCall = 0;
            stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
            enterFrameHandler(null);
        }

        private function clickBtnNormalHandler (event:MouseEvent):void {
            TimeDebug.start();
            _testArray = [];
            _countCall = 0;
            while (_countCall < _maxCountCall) {
                make();
                _countCall++;
                _ui.bar.value = _countCall / _maxCountCall;
            }
            _ui.tf.appendText(
                ' normal time = '
                    + TimeDebug.end()
                    + ', count = ' + _maxCountCall
                    + '\n'
            );
        }

        private function enterFrameHandler (event:Event):void {
            var startTime:int = getTimer();
            while (_countCall < _maxCountCall && getTimer() - startTime < _frameTime) {
                make();
                _countCall++;
                _ui.bar.value = _countCall / _maxCountCall;
            }
            if (_countCall >= _maxCountCall) {
                _ui.tf.appendText(
                    ' enter frame time = '
                        + TimeDebug.end()
                        + ' count = ' + _maxCountCall
                        + ', frame time = ' + _frameTime
                        + '\n'
                );
                stage.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
            }
        }

        public function make ():void {
            var arr:Array = [];
            _testArray.push(arr);
            for (var i:int = 0; i < 100; i++) {
                var a:int = Math.random();
                var b:int = Math.random();
                arr.push(a + b);
            }
        }
    }
}
