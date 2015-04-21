TEST_FILES = $(wildcard tests/test_*.py)
TESTS = $(subst .py,,$(subst /,.,$(TEST_FILES)))

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
