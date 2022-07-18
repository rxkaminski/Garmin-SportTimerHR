using Toybox.Timer;
using Toybox.ActivityRecording;

class SportTimerHrController {

    private var _view;
    private var _sportsCollection;
    private var _session;
    private var _hrOn;

    private var _updateTimer;
    
    private var _viewModel;

    public function initialize(view) {
        _view = view;
        _sportsCollection =  new SportsCollection();
        _session = new SportTimerHrSession();
        _updateTimer = new Timer.Timer();

        _viewModel = new SportTimerHrViewModel();

        _updateTimer.start(method(:onUpdateView), 100, true);

        setHrOn(true);

        onUpdateView();
    }

    public function setHrOn(value) as Void {
        _hrOn = value;

        if(value) {
            Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);
        } else {
            Sensor.setEnabledSensors([]);
        }
    }

    public function onMenu() as Void {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new SportTimerHrMenuDelegate(self), WatchUi.SLIDE_UP);
    }

    public function onSelectSport() as Sport {
        WatchUi.pushView(new Rez.Menus.SportsMenu(), new SportTimeSelectSportMenuDelegate(_sportsCollection), WatchUi.SLIDE_UP);        
    }

    public function onBack() as Boolean {
        if(_session.isRecording()) {
            _session.addLap();
            return true;
        }

        return false;
    }

    public function onSelect() as Void {
        if(_session.isStatus(SESSION_STATUS_READY) || _session.isStatus(SESSION_STATUS_SAVED)) {            
            _session.start(_sportsCollection.getCurrentSport());
        } else if(_session.isStatus(SESSION_STATUS_STARTED) || _session.isStatus(SESSION_STATUS_STOPPED)) {
            _session.stop();

            WatchUi.pushView(new Rez.Menus.ResumeSaveDiscardMenu(), new SportTimerHrResumeSaveDiscardMenuDelegate(_session), WatchUi.SLIDE_UP);
        }
    }

    public function onUpdateView() as Void {
        
        if(_session != null) {

            updateStatus();

            _viewModel.activityInfo = _session.getActivityInfo();
            _viewModel.lapsCount = _session.getLapsCount();
        }

        _viewModel.clockTime = System.getClockTime();
        _viewModel.sport = _sportsCollection.getCurrentSport();

        _view.onUpdateStatus(_viewModel);
        
    }

    private function updateStatus() as Void {
        if(_session.isStatus(SESSION_STATUS_READY)) {
            _viewModel.status = Rez.Strings.ReadyLabel;
        } else if(_session.isStatus(SESSION_STATUS_STARTED)) {
            _viewModel.status = Rez.Strings.StartedLabel;
        } else if(_session.isStatus(SESSION_STATUS_STOPPED)) {
            _viewModel.status = Rez.Strings.StoppedLabel;
        } else if(_session.isStatus(SESSION_STATUS_SAVED)) {
            _viewModel.status = Rez.Strings.SavedLabel;
        }   
    }
}