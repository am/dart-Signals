class Signal {

	List<SignalHelper> _helpers;
	
	Signal(){
		_helpers = List<SignalHelper>.empty(growable: true);
	}
	
	List<SignalHelper> get helpers => _helpers;
	int get numListeners => _helpers.length;
	
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
		_helpers.removeWhere((element) => element.fnc == fnc);
	}

	void removeAll(){
		_helpers.clear();
	}

	void dispatch([arguments]){
		_helpers.forEach((SignalHelper e){
			Function f = e.fnc;
			if (arguments != null) {
				f(arguments);
			}
			else{
				f();
			}

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