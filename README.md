# Wrapped Executables

Here are sets of wrapper commands for some awkward software installations, namely, Greenplum.
Most of them require you to set the correct LD_LIBRARY_PATH environment when invoking their executables, which is a hassle.
Moreover, the libraries they ship interfere with other software installed on the system, e.g., Python, Kerberos/AFS, etc., so if you naively set LD_LIBRARY_PATH from your ~/.bashrc or ~/.bash_profile, you will fall into all kinds of hard-to-fix issues.
Hence, this wrapper generator is here to save you from sacrificing your ordinary shell environment and to let you use these sloppy software packages by simply modifying your PATH environment and no more.

For example, add the following single line to your .bashrc to use Greenplum:

    export PATH=/dfs/scratch1/netj/wrapped/greenplum:$PATH

