package tread {
    import flash.events.Event;

    public class CallManagerEvent extends Event {
        public var callback:Function;
        public static const FINISH:String = 'finish';

        public function CallManagerEvent (type:String, callback:Function) {
            super(type, bubbles, cancelable);
            this.callback = callback;
        }
    }
}
