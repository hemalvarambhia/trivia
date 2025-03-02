Legacy Code Retreat code base
======

Use this code base to run your own [Legacy Code Retreat](http://legacycoderetreat.jbrains.ca).

As of this writing, there isn't really a single place to get all the information you might want about Legacy Code Retreat. Search the web and ask your colleagues. Most importantly, don't panic! If you've been to Code Retreat even once, then you know most of what you need to run a Legacy Code Retreat. Give it a try!

## Python

Start the shell to begin with using `pipenv shell` and deactivate using `deactivate` once
you're done.

### Running the tests

To run tests in python, perform the following steps:

Simply run `PYTHONPATH=src:tests pipenv run python -m unittest`


### Generating the Golden Masters

Simply run `sh -x generate-golden-masters.sh`

### Running the Code Against Golden Masters

Simply run `sh -x test-against-golden-masters.sh`




5. `deactivate`