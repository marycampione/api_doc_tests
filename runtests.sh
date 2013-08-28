#!/bin/bash

shopt -s nullglob

EXITSTATUS=0
PASSING=0
WARNINGS=0
FAILURES=0

#####
# Type Analysis

#ANA="dart_analyzer --fatal-type-errors --extended-exit-code --type-checks-for-inferred-types"
# use new experimental analyzer
ANA="dartanalyzer --fatal-type-errors"

cmd="$ANA"
echo
echo "Type Analysis, running dart_analyzer..."

# Run pub.
pub_result=`pushd bin && pub install && popd`
cmd="$ANA --package-root bin/packages"

# Loop through each Dart file in this code directory.
files="bin/*.dart"
for file in $files
do
  results=`$cmd $file 2>&1`
  exit_code=$?
  if [ $exit_code -eq 2 ]; then
    let FAILURES++
    EXITSTATUS=1
    echo "$results"
    echo "$file: FAILURE."
  elif [ $exit_code -eq 1 ]; then
    let WARNINGS++
    echo "$results"
    echo "$file: WARNING."
  elif [ $exit_code -eq 0 ]; then
    let PASSING++
    echo "$results"
    echo "$file: Passed analysis."
  else
    echo "$file: Unknown exit code: $exit_code."
  fi
done

echo
echo "####################################################"
echo "PASSING = $PASSING"
echo "WARNINGS = $WARNINGS"
echo "FAILURES = $FAILURES"
echo "####################################################"
echo 
exit $EXITSTATUS
