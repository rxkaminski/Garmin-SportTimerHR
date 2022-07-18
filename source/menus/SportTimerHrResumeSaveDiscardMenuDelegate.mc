import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class SportTimerHrResumeSaveDiscardMenuDelegate extends WatchUi.MenuInputDelegate {
    
    private var _session;

    public function initialize(session) {
        MenuInputDelegate.initialize();

        _session = session;
    }

    public function onMenuItem(item as Symbol) as Void {
        if (item == :resumeMenuItem) {
            _session.resume();

        } else if (item == :saveMenuItem) {
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            WatchUi.pushView(new Rez.Menus.NoYesMenu(), new SportTimerHrNoYesMenuDelegate(method(:noCallback), method(:saveCallback)), WatchUi.SLIDE_UP);            
        
        } else if (item == :discardMenuItem) {
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            WatchUi.pushView(new Rez.Menus.NoYesMenu(), new SportTimerHrNoYesMenuDelegate(method(:noCallback), method(:discardCallback)), WatchUi.SLIDE_UP);            
        
        }
    }

    public function noCallback() as Void {
    }

    public function saveCallback() as Void {
        _session.save();
    }

    public function discardCallback() as Void {
        _session.discard();
    }
}