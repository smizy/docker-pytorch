@test "pytorch is the correct version" {
  run docker run smizy/pytorch:${TAG} python -c 'import torch; print(torch.__version__)'
  echo "${output}" 

  [ $status -eq 0 ]

  result="${lines[0]}"

  [ "${result%.*}" = "${VERSION%.*}" ]
}