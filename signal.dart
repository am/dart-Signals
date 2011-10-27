#library('signals');

class Signal {

	List<SignalHelper> _helpers;
	
	Signal(){
		_helpers = new List<SignalHelper>();
	}
	
	List<SignalHelper> get helpers() => _helpers;
        int get numListeners() => _helpers.length;
	
	void add(Function fnc){
		_add(fnc, false);
	}
	
	void addOnce(Function fnc){
		_add(fnc, true);
	}
	
	void _add(Function fnc, bool once){
		SignalHelper e = new SignalHelper(fnc);
		e.once = once;
		_helpers.add(e);
	}
	      
	void remove(Function fnc){
		_helpers.forEach((SignalHelper e){
			if(e.fnc==fnc){
				int index = _helpers.indexOf(e, 0);
			  	_helpers.removeRange(index, 1);
			}
		});
	}

	void dispatch(arguments){

		_helpers.forEach((SignalHelper e){
			Function f = e.fnc;
			f(arguments);
			if(e.once) {
				remove(e.fnc);
			}
		});
	}
}

class SignalHelper {
	bool once;
	Function fnc;
	SignalHelper(Function this.fnc);
}