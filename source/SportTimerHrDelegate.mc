import Toybox.Lang;
import Toybox.WatchUi;
using Toybox.ActivityRecording;

class SportTimerHrDelegate extends WatchUi.BehaviorDelegate {

    private var _controller;

    public function initialize(controller) {
        BehaviorDelegate.initialize();

        _controller = controller;
    }

    public function onMenu() as Boolean {
        _controller.onMenu();

        return true;
    }

    // use the select Start/Stop or touch for recording
    public function onSelect() as Boolean {
        _controller.onSelect();

        return true;
    }

    public function onBack() as Boolean {
        return _controller.onBack();
    }
}