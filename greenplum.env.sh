# clean environment
unset LD_LIBRARY_PATH
unset PYTHONPATH
unset PYTHONHOME
# greenplum's setup
source /dfs/scratch0/netj/wrapped/greenplum.bin/../greenplum_path.sh
# and our own python virtualenv to isolate its dependency
source /dfs/scratch0/netj/wrapped/greenplum.bin/../python-virtualenv/bin/activate
