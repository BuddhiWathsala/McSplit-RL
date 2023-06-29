source configs/run.env
shopt -s globstar
file_name=results/${DATA_DIR}_${MCSP_HEURISTIC}.txt
execution_file=results/${DATA_DIR}_${MCSP_HEURISTIC}_EXEC.txt
rm -f $file_name
rm -f $execution_file
echo "Solution size, Nodes, Cut branches, Conflicts, Elapsed time, Best time" >> ${file_name}
echo "Patterns, Targets" >> ${execution_file}
echo $TYPE_1
echo $DATA_DIR
if $TYPE_1
then
  files=($(ls -la -d data/${DATA_DIR}/** | grep -v "^[d]" | awk '{print $(NF)}'))
  len=$([ $TEST == true ] && echo 2 || echo ${#files[@]})
  echo $len
  for i in $(seq 0 2 $len)
  do
      echo "${files[i]}, ${files[i+1]}" >> ${execution_file}
      ./bin/run.o $MCSP_HEURISTIC ./${files[i]} ./${files[i+1]} -l -q >> ${file_name}
  done
else
  patterns=($(ls -la -d data/${DATA_DIR}/patterns/** | grep -v "^[d]" | awk '{print $(NF)}'))
  targets=($(ls -la -d data/${DATA_DIR}/targets/** | grep -v "^[d]" | awk '{print $(NF)}'))
  len_patterns=$([ $TEST == true ] && echo 2 || echo ${#patterns[@]})
  len_targets=$([ $TEST == true ] && echo 2 || echo ${#patterns[@]})
  let len_patterns=$len_patterns-1
  let len_targets=$len_targets-1
  len_patterns=2
  len_targets=2
  for i in $(seq 0 $len_patterns)
  do
    for j in $(seq 0 $len_targets)
    do
      # echo "${patterns[i]} ${targets[j]}" >> sample.txt
      ./bin/run.o $MCSP_HEURISTIC ./${patterns[i]} ./${targets[j]} -l -q >> ${file_name}
    done
  done
fi