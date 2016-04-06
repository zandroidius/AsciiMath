BIN=asciimath
FILTER=pandoc-asciimath
GHC_OPT=

GENERATED=lexer.hs parser.hs
MODULES=asciimath

all: compiler filter

base: $(GENERATED)

filter: base
	ghc $(GHC_OPT) $(MODULES) pandoc-asciimath -o $(FILTER) 

compiler: base
	ghc $(GHC_OPT) $(MODULES) compiler -o $(BIN)

.SUFFIXES: .hs .x .y

%.hs: %.x
	alex -g $< 

%.hs: %.y
	happy -g $<

clean:
	rm -f *.o *.hi
	rm -f parser.info
	rm -f $(GENERATED)
	rm -f $(BIN) $(FILTER)

