PACKAGE="Universal"
PACKAGE_LOWER=$(shell echo $(PACKAGE) | sed 's/.*/\L&/')
PIP_EXEC=pip
PYTHON_EXEC=python
PYTHON2_EXEC=python2.7
PYTHON3_EXEC=python3
NOSETESTS_EXEC=$(shell which nosetests)
VERSION = $(shell python -c 'import $(PACKAGE_LOWER); print($(PACKAGE_LOWER).__version__)')
TEST_FILES = $(wildcard tests/test_*.py)
TESTS = $(subst .py,,$(subst /,.,$(TEST_FILES)))

all.PHONY: nosetests_3 nosetests_2

nosetests_2:
	@echo "Running $(PYTHON2_EXEC) tests"
	@$(PYTHON2_EXEC) $(NOSETESTS_EXEC)

nosetests_3:
	@echo "Running $(PYTHON3_EXEC) tests"
	@$(PYTHON3_EXEC) $(NOSETESTS_EXEC)

install:
	@echo "Creating distribution package for version $(VERSION)"
	@echo "-----------------------------------------------"
	$(PYTHON_EXEC) setup.py sdist
	@echo "Installing package using $(PIP_EXEC)"
	@echo "----------------------------"
	$(PIP_EXEC) install --upgrade dist/$(PACKAGE)-$(VERSION).tar.gz

coverage:
	@coverage run $(NOSETESTS_EXEC)
	@coverage report

test:
	@- $(foreach TEST,$(TESTS), \
		echo === Running test: $(TEST); \
		$(PYTHON_EXEC) -m $(TEST) $(PYFLAGS); \
		)

test3:
	@- $(foreach TEST,$(TESTS), \
		echo === Running python3 test: $(TEST); \
		$(PYTHON3_EXEC) -m $(TEST) $(PYFLAGS); \
		)

clean:
	find . -type f -name '*.pyc' -exec rm {} +
	find . -type d -name '__pycache__' -exec rm -r {} +
