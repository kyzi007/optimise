package tread {
    import com.bit101.components.Label;
    import com.bit101.components.ProgressBar;
    import com.bit101.components.PushButton;
    import com.bit101.components.Slider;
    import com.bit101.components.VBox;

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.utils.getTimer;

    [SWF(frameRate=20)]
    public class ThreadMain extends Sprite {

        private var _maxCount:int = 0;
        private var _count:int = 0;
        private var _tf:TextField;
        private var _testArray:Array;
        private var _btnNormal:PushButton;
        private var _btnEnterFrame:PushButton;
        private var _bar:ProgressBar;
        private var _startTime:int;
        private var _sliceCount:Slider;
        private var _labelCount:Label;
        private var _labelFrameRound:Label;
        private var _sliceFrameRound:Slider;
        private var _frameTime:int;

        public function ThreadMain () {
            var box:VBox = new VBox(this);
            _labelCount = new Label();

            _sliceCount = new Slider();
            _sliceCount.width = 200;
            _sliceCount.value = 50;
            _sliceCount.addEventListener(Event.CHANGE, changeSliceCountHandler);
            changeSliceCountHandler(null);

            _labelFrameRound = new Label();

            _sliceFrameRound = new Slider();
            _sliceFrameRound.width = 200;
            _sliceFrameRound.value = 50;
            _sliceFrameRound.addEventListener(Event.CHANGE, changeSliceFrameRoundHandler);
            changeSliceFrameRoundHandler(null);

            _tf = new TextField();
            _tf.border = true;
            _tf.height = 100;
            _tf.width = 400;

            _btnNormal = new PushButton();
            _btnNormal.label = "test normal";
            _btnNormal.addEventListener(MouseEvent.CLICK, clickBtnNormalHandler);

            _btnEnterFrame = new PushButton();
            _btnEnterFrame.label = "test enter frame";
            _btnEnterFrame.addEventListener(MouseEvent.CLICK, clickBtnEnterFrameHandler);

            _bar = new ProgressBar();
            _bar.width = 200;

            box.addChild(_labelCount);
            box.addChild(_sliceCount);
            box.addChild(_labelFrameRound);
            box.addChild(_sliceFrameRound);
            box.addChild(_tf);
            box.addChild(_bar);
            box.addChild(_btnNormal);
            box.addChild(_btnEnterFrame);

            x = 20;
            y = 20;
        }

        private function changeSliceFrameRoundHandler (event:Event):void {
            _frameTime = (_sliceFrameRound.value / 100) * 1000 / 20;// fps * ms * percent
            _labelFrameRound.text = "time calculations in frame" + _frameTime;
        }

        private function changeSliceCountHandler (event:Event):void {
            _maxCount = _sliceCount.value * 1000;
            _labelCount.text = "amount of calls" + _maxCount;
        }

        private function clickBtnEnterFrameHandler (event:MouseEvent):void {
            _startTime = getTimer();
            _testArray = [];
            _count = 0;
            stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
            enterFrameHandler(null);
        }

        private function clickBtnNormalHandler (event:MouseEvent):void {
            _startTime = getTimer();
            _testArray = [];
            _count = 0;
            while (_count < _maxCount) {
                make();
                _count++;
                _bar.value = _count / _maxCount;
            }
            _tf.appendText(
                ' normal time = '
                    + (getTimer() - _startTime)
                    + ', count = ' + _maxCount
                    + '\n'
            );
        }

        private function enterFrameHandler (event:Event):void {
            var startTime:int = getTimer();
            while (_count < _maxCount && getTimer() - startTime < _frameTime) {
                make();
                _count++;
                _bar.value = _count / _maxCount;
            }
            if (_count >= _maxCount) {
                _tf.appendText(
                    ' enter frame time = '
                        + (getTimer() - _startTime)
                        + ' count = ' + _maxCount
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
