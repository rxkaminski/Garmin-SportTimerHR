import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class SportTimerHrNoYesMenuDelegate extends WatchUi.MenuInputDelegate {

    private var _onNoCallback;
    private var _onYesCallback;

    public function initialize(onNoCallback, onYesCallback) {
        MenuInputDelegate.initialize();

        _onNoCallback = onNoCallback;
        _onYesCallback = onYesCallback;
    }

    public function onMenuItem(item as Symbol) as Void {
        if (item == :noMenuItem) {
            _onNoCallback.invoke();
        } else if (item == :yesMenuItem) {
            _onYesCallback.invoke();
        }
    }
}