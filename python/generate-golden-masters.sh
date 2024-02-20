for num in $(seq 0 799)
do
  gameId=$((7777 + num * 15))
  python python/play_trivia_for_testing.py --seed $gameId > python/test/golden_masters/golden-master-$gameId.txt
done
