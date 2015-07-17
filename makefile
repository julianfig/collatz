FILES :=                              \
    .travis.yml                       \
    collatz-tests/EID-RunCollatz.in   \
    collatz-tests/EID-RunCollatz.out  \
    collatz-tests/EID-TestCollatz.py  \
    collatz-tests/EID-TestCollatz.out \
    Collatz.html                      \
    Collatz.log                       \
    Collatz.py                        \
    RunCollatz.py                     \
    RunCollatz.in                     \
    RunCollatz.out                    \
    TestCollatz.py                    \
    TestCollatz.out

clean:
	rm -f  .coverage
	rm -f  *.pyc
	rm -f  Collatz.html
	rm -f  Collatz.log
	rm -f  RunCollatz.out
	rm -f  TestCollatz.out
	rm -rf __pycache__

sync:
	make clean
	@echo `pwd`
	@rsync -r -t -u -v --delete \
    --include "Collatz.py"             \
    --include "gitignore.sample"       \
    --include "makefile.sample"        \
    --include "makefile"               \
    --include "RunCollatz.in"          \
    --include "RunCollatz.py"          \
    --include "RunCollatz.sample.out"  \
    --include "TestCollatz.py"         \
    --include "TestCollatz.sample.out" \
    --exclude "*"                      \
    . downing@$(CS):cs/cs373/github/python/collatz/

test: RunCollatz.out TestCollatz.out

RunCollatz.out: RunCollatz.py
	cat RunCollatz.in
	./RunCollatz.py < RunCollatz.in > RunCollatz.out
	cat RunCollatz.out

TestCollatz.out: TestCollatz.py
	coverage3 run    --branch TestCollatz.py >  TestCollatz.out 2>&1
	coverage3 report -m                      >> TestCollatz.out
	cat TestCollatz.out
