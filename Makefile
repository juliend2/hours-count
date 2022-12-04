clean:
	rm *.beam

hours.beam:
	erlc hours.erl

all: hours.beam
	erl -noshell -s hours main -s init stop


