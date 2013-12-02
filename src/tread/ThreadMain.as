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
        private var _slice:Slider;
        private var _label:Label;

        public function ThreadMain () {
            var box:VBox = new VBox(this);
            _label = new Label();

            _slice = new Slider();
            _slice.width = 200;
            _slice.value = 50;
            _slice.addEventListener(Event.CHANGE, changeSliceHandler);
            changeSliceHandler(null);

            _tf = new TextField();
            _tf.border = true;
            _tf.height = 100;
            _tf.width = 200;

            _btnNormal = new PushButton();
            _btnNormal.label = "test normal";
            _btnNormal.addEventListener(MouseEvent.CLICK, clickBtnNormalHandler);

            _btnEnterFrame = new PushButton();
            _btnEnterFrame.label = "test enter frame";
            _btnEnterFrame.addEventListener(MouseEvent.CLICK, clickBtnEnterFrameHandler);

            _bar = new ProgressBar();
            _bar.width = 200;

            box.addChild(_label);
            box.addChild(_slice);
            box.addChild(_tf);
            box.addChild(_bar);
            box.addChild(_btnNormal);
            box.addChild(_btnEnterFrame);
        }

        private function changeSliceHandler (event:Event):void {
            _maxCount = _slice.value * 1000;
            _label.text = "count " + _maxCount;
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
            _tf.appendText(_maxCount + ': normal ' + (getTimer() - _startTime) + '\n');
        }

        private function enterFrameHandler (event:Event):void {
            var startTime:int = getTimer();
            while (_count < _maxCount && getTimer() - startTime < 40) {// 50mc (frame time)  -  (~10 mc stage draw)
                make();
                _count++;
                _bar.value = _count / _maxCount;
            }
            if (_count >= _maxCount) {
                _tf.appendText(_maxCount + ': enter frame ' + (getTimer() - _startTime) + '\n');
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
