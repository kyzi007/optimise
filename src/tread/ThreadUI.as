package tread {
    import com.bit101.components.Label;
    import com.bit101.components.ProgressBar;
    import com.bit101.components.PushButton;
    import com.bit101.components.Slider;
    import com.bit101.components.VBox;

    import flash.display.Sprite;
    import flash.text.TextField;

    public class ThreadUI extends Sprite {
        public var bar:ProgressBar;

        public var btnNormal:PushButton;
        public var btnEnterFrame:PushButton;

        public var sliceCount:Slider;
        public var sliceFrameRound:Slider;

        public var labelCount:Label;
        public var labelFrameRound:Label;
        public var tf:TextField;

        public function ThreadUI () {
            var box:VBox = new VBox(this);
            labelCount = new Label();

            sliceCount = new Slider();
            sliceCount.width = 200;
            sliceCount.value = 50;

            labelFrameRound = new Label();

            sliceFrameRound = new Slider();
            sliceFrameRound.width = 200;
            sliceFrameRound.value = 50;

            tf = new TextField();
            tf.border = true;
            tf.height = 100;
            tf.width = 300;

            btnNormal = new PushButton();
            btnNormal.label = "test normal";

            btnEnterFrame = new PushButton();
            btnEnterFrame.label = "test enter frame";

            bar = new ProgressBar();
            bar.width = 200;

            box.addChild(labelCount);
            box.addChild(sliceCount);
            box.addChild(labelFrameRound);
            box.addChild(sliceFrameRound);
            box.addChild(tf);
            box.addChild(bar);
            box.addChild(btnNormal);
            box.addChild(btnEnterFrame);
        }
    }
}
