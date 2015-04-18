TESTS = $(wildcard test_*.py)

all.PHONY: test
#.PHONY: test test3

test:
	@- $(foreach TEST,$(TESTS), \
		echo === Running test: $(TEST); \
		python $(TEST); \
		)
test3:
	@- $(foreach TEST,$(TESTS), \
		echo === Running python3 test: $(TEST); \
		python3 $(TEST); \
		)
