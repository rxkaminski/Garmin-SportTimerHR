using Toybox.ActivityRecording;
using Toybox.Timer;
using Toybox.Activity;

enum {  
    SESSION_STATUS_READY, 
    SESSION_STATUS_STARTED, 
    SESSION_STATUS_STOPPED,
    SESSION_STATUS_SAVED
}

class SportTimerHrSession {
    
    private var _session = null; 
    private var _sport;
    private var _status;
    private var _activityInfo;
    private var _lapsCount;

    public function initialize() {
        _status = SESSION_STATUS_READY;
        _lapsCount = 0;
    }

    public function start(sport) as Void {
        if (Toybox has :ActivityRecording) {                          
            if ((_session == null) || (_session.isRecording() == false)) {
                _session = ActivityRecording.createSession({        
                        :name => sport.getSportName(),                              
                        :sport => sport.getSport(),     
                        :subSport => sport.getSubSport(),                   
                });

                _activityInfo = new Activity.Info();
                _sport = sport;

                resume();
            }
        }
    }

    public function resume() as Void {
        if(_session == null) {
            return;
        }
                
        _session.start();  
        _status = SESSION_STATUS_STARTED;  

        Attention.playTone(Attention.TONE_START);
    }

    public function stop() as Void {
        
        if(_session == null) {
            return;
        }

        _session.stop();
        _status = SESSION_STATUS_STOPPED; 

        Attention.playTone(Attention.TONE_STOP);
    }

    public function save() as Void {

        if(_session == null || _session.isRecording()) {
            return;
        }

        _session.stop();
        _session.save();

        _session = null; 
        _activityInfo = null;
        _status = SESSION_STATUS_SAVED; 
    }

    public function discard() as Void {
        _session.discard();
        _session = null; 
        _activityInfo = null;
        _status = SESSION_STATUS_READY;
    }
    
    public function isStatus(status) as Boolean {
        return _status == status;
    }

    public function isRecording() as Boolean {
        return _session != null && _session.isRecording();
    }

    public function addLap() as Void {
        if(_session != null) {
            _session.addLap();
            _lapsCount++;
        }
    }

    public function getLapsCount() as Number {
        if(_session != null) {
            return _lapsCount; 
        }

        return 0; 
    }

    public function getActivityInfo() as ActivityInfo {

        if(_activityInfo == null) {
            return null;
        }
        
        return _activityInfo.getActivityInfo();
    }
}