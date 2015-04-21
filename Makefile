TESTS_FILES = $(wildcard tests/test_*.py)
TESTS_TEMP = $(subst /,.,$(TESTS_FILES))
TESTS = $(subst .py,,$(TESTS_TEMP))

all.PHONY: test

test:
	@- $(foreach TEST,$(TESTS), \
		echo === Running test: $(TEST); \
		python -m $(TEST); \
		)

test3:
	@- $(foreach TEST,$(TESTS), \
		echo === Running python3 test: $(TEST); \
		python3 -m $(TEST); \
		)
