import Toybox.Graphics;
import Toybox.WatchUi;

class SportTimerHrView extends WatchUi.View {

    private var _zerosLabel;
    private var _noneLabel;
    
    private var _statusValue;
    private var _timerTimeValue;
    private var _clockTimeValue;
    private var _hrValue;
    private var _lapsCountValue;
    private var _sportNameValue;

    private var _viewModel =  null;

    public function initialize() {
        View.initialize();

        _zerosLabel = Rez.Strings.ZerosLabel;
        _noneLabel = Rez.Strings.NoneLabel;
    }

    // Load your resources here
    public function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));

        _statusValue = findDrawableById("statusValue");
        _timerTimeValue = findDrawableById("timerTimeValue");
        _clockTimeValue = findDrawableById("clockTimeValue");
        _hrValue = findDrawableById("hrValue");     
        _lapsCountValue = findDrawableById("lapsCountValue");
        _sportNameValue = findDrawableById("sportNameValue");
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    public function onShow() as Void {
    }

    // Update the view
    public function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        if(_viewModel != null) {
            _statusValue.setText(_viewModel.status);

            if(_viewModel.activityInfo != null) {

                var timerTime = durationToString(_viewModel.activityInfo.timerTime);
                _timerTimeValue.setText(timerTime);

                var hr = hrToString(_viewModel.activityInfo.currentHeartRate);
                _hrValue.setText(hr);
            }

            _lapsCountValue.setText(_viewModel.lapsCount.format("%d"));

            var clockTime = timeToString(_viewModel.clockTime);
            _clockTimeValue.setText(clockTime);
            
            _sportNameValue.setText(_viewModel.sport.getSportName());
        }

        View.onUpdate(dc);
    }

    public function onUpdateStatus(viewModel) as Void {
        _viewModel = viewModel;

        WatchUi.requestUpdate();
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    public function onHide() as Void {
    }

    private function durationToString(durationValue) as String {
        if(durationValue == null) {
            return _zerosLabel;
        }

        var allSeconds = durationValue / 1000;
        var seconds = allSeconds % 60;
        var minutes = ((allSeconds - seconds) % 3600) / 60;
        var hours = allSeconds / 3600;
        
        return Lang.format("$1$:$2$:$3$", [hours.format("%02d"), minutes.format("%02d"), seconds.format("%02d")]);
    }

    private function hrToString(hrValue) as String {
        if(hrValue == null) {
            return _noneLabel;
        }

        return Lang.format("$1$", [hrValue.format("%03d")]);
    }

    private function timeToString(timeValue) as String {
        return Lang.format("$1$:$2$", [timeValue.hour.format("%02d"), timeValue.min.format("%02d")]);
    }
}
