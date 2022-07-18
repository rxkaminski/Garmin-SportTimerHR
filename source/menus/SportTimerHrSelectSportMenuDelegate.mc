import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class SportTimeSelectSportMenuDelegate extends WatchUi.MenuInputDelegate {

    private var _sportsCollection;

    public function initialize(sportsCollection) {
        MenuInputDelegate.initialize();
        
        _sportsCollection = sportsCollection;
    }

    public function onMenuItem(item as Symbol) as Void {
        if (item == :weightTrainingMenuItem) {
            _sportsCollection.set(SPORT_TIMER_WEIGHT_TRAINING);
        } else if (item == :squashMenuItem) {
            _sportsCollection.set(SPORT_TIMER_SQUASH);
        }
    }
}