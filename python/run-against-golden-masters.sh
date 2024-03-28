
for num in $(seq 0 799)
do
  gameId=$((7777 + num * 15))
  python play_trivia_for_testing.py --seed $gameId > test/runs/test-run-$gameId.txt
  diff test/runs/test-run-$gameId.txt test/golden_masters/golden-master-$gameId.txt
  rm test/runs/test-run-$gameId.txt
done
