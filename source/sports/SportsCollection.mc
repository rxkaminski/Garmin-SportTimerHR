using Toybox.ActivityRecording;

enum {
    SPORT_TIMER_WEIGHT_TRAINING,
    SPORT_TIMER_SQUASH,
}

class SportsCollection {

    private var _sportsCollection;
    private var _currentSpot;

    public function initialize() {
        _sportsCollection = {
            SPORT_TIMER_WEIGHT_TRAINING => new Sport("Weight Training", ActivityRecording.SPORT_TRAINING, ActivityRecording.SUB_SPORT_STRENGTH_TRAINING),
            SPORT_TIMER_SQUASH => new Sport("Squash", ActivityRecording.SPORT_TENNIS, ActivityRecording.SUB_SPORT_GENERIC),                   
        };

        _currentSpot = SPORT_TIMER_WEIGHT_TRAINING;
    }

    public function getCurrentSport() as Sport {
        return _sportsCollection.get(_currentSpot);
    }

    public function set(sportKey) as Void {
        _currentSpot = sportKey;
    }

}