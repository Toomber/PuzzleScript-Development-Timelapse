#!/bin/sh
if [ "$#" -ne 1 ] || [ "$1" == "help" ]
then
  echo "dump all git versions of a file to separate files"
  echo
  echo "usage: $0 FILENAME";
  echo
  echo "e.g."
  echo
  echo "$ $0 path/to/somefile.txt"
  echo
  echo "path/to/somefile.txt.1.0dea419"
  echo "path/to/somefile.txt.1.0dea419.logmsg"
  echo "path/to/somefile.txt.2.cdea8s9"
  echo "path/to/somefile.txt.2.cdea8s9.logmsg"
  echo "path/to/somefile.txt.3.fdsf2d"
  echo "path/to/somefile.txt.3.fdsf2d.logmsg"
  echo "..."
  exit 1
fi

index=1
for commit in $(git log --pretty=format:%h "$1")
do
  padindex=$(printf %03d "$index")
  out="$1.$padindex.$commit"
  # log="$out.logmsg"
  # echo "saving version $index to file $out for commit $commit"
  # echo "*******************************************************" > "$log"
  # git log -1 --pretty=format:"%s%nAuthored by %an at %ai%n%n%b%n" "$commit" >> "$log"
  # echo "*******************************************************" >> "$log"
  git show "$commit:./$1" > "$out"
  let index++
done


#Source: https://stackoverflow.com/questions/1964142/how-can-i-list-all-the-different-versions-of-a-file-and-diff-them-also/32849134#32849134
