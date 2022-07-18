import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class SportTimerHrApp extends Application.AppBase {

    private var _view;
    private var _delegate;
    private var _controller;

    public function initialize() {
        AppBase.initialize();

        _view = new SportTimerHrView();
        _controller = new SportTimerHrController(_view);
        _delegate = new SportTimerHrDelegate(_controller);

    }

    // onStart() is called on application start up
    public function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    public function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    public function getInitialView() as Array<Views or InputDelegates>? {
        return [_view , _delegate ] as Array<Views or InputDelegates>;
    }

}

public function getApp() as SportTimerHrApp {
    return Application.getApp() as SportTimerHrApp;
}