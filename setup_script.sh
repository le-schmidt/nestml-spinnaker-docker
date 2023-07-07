#!/bin/bash
cd /home/spinnaker/source
python PyNN8Examples/examples/va_benchmark.py
cd /home/nestml
git checkout spinnaker-new
python setup.py install --user
cd spinnaker-install
python setup.py develop
cd ..
pytest tests/spinnaker_tests/test_spinnaker_iaf_psc_exp.py
python spinnaker-install/examples/iaf_psc_exp_nestml_chain_example.py

