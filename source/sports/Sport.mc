class Sport {

    private var _sportName;
    private var _sport;
    private var _subSport;

    public function initialize(sportName, sport, subSport) {
        _sportName = sportName;
        _sport = sport;
        _subSport = subSport;
    }

    public function getSportName() as String {
        return _sportName;
    }

    public function getSport() as Number {
        return _sport;
    }

    public function getSubSport() as Number {
        return _subSport;
    }
}