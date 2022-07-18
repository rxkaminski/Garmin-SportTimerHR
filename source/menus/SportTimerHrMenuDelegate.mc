import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class SportTimerHrMenuDelegate extends WatchUi.MenuInputDelegate {

    private var _controller;

    public function initialize(controller) {
        MenuInputDelegate.initialize();

        _controller = controller;
    }

    public function onMenuItem(item as Symbol) as Void {
        if (item == :exitMenuItem) {
            System.exit();
        } else if (item == :selectSportMenuItem) {
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            _controller.onSelectSport();
        }
    }
}