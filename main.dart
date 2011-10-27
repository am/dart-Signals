#import Signal;

void main(){
	Signal s = new Signal();
	s.add(onDispatch);
	s.dispatch(['one', 1]);
}

void onDispatch(List arguments){
	print('onDispatch ${arguments[0]} ${arguments[1]}'); //onDispatch one 1
}