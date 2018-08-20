echo 'aaa-bbb-ccc' > temp.sh
touch parseId.sh
cat parseId.sh >> temp.sh
mv temp.sh parseId.sh
echo $(<parseId.sh)
