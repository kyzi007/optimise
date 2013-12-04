package tread {
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;

    import utils.TimeDebug;

    [SWF(frameRate=20)]
    public class ThreadSimpleMain extends Sprite {
        private var _testArray:Array;
        private var _countCall:int = 0;
        private var _maxCountCall:int = 0;

        private var _ui:ThreadUI;
        private var _callManager:SimpleCallManager;

        public function ThreadSimpleMain () {
            initCallManager();
            initUi();
        }

        private function initCallManager ():void {
            _callManager = new SimpleCallManager(stage);
            _callManager.fps = 20;
            _callManager.addEventListener(CallManagerEvent.FINISH, finishСalculation)
        }

        private function finishСalculation (event:CallManagerEvent):void {
            _ui.tf.appendText(
                ' enter frame time = '
                    + TimeDebug.end()
                    + ' count = ' + _maxCountCall
                    + ', frame round = ' + _callManager.frameRound
                    + '\n'
            );
        }

        private function initUi ():void {
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
            _callManager.frameRound = _ui.sliceFrameRound.value / 100;
            _ui.labelFrameRound.text = "time calculations in frame" + _callManager.frameRound;
        }

        private function changeSliceCountHandler (event:Event):void {
            _maxCountCall = _ui.sliceCount.value * 1000;
            _ui.labelCount.text = "amount of calls" + _maxCountCall;
        }

        private function clickBtnEnterFrameHandler (event:MouseEvent):void {
            TimeDebug.start();
            _testArray = [];
            _countCall = 0;
            _callManager.start(make);
        }

        private function clickBtnNormalHandler (event:MouseEvent):void {
            TimeDebug.start();
            _testArray = [];
            _countCall = 0;
            while (_countCall < _maxCountCall) {
                make();
            }
            _ui.tf.appendText(
                ' normal time = '
                    + TimeDebug.end()
                    + ', count = ' + _maxCountCall
                    + '\n'
            );
        }

        private function make ():Boolean {
            var arr:Array = [];
            _testArray.push(arr);
            for (var i:int = 0; i < 100; i++) {
                var a:int = Math.random();
                var b:int = Math.random();
                arr.push(a + b);
            }
            _countCall++;
            _ui.bar.value = _countCall / _maxCountCall;
            return _countCall >= _maxCountCall;
        }
    }
}
