#! /bin/sh

echo "New version number:"
read version_number

echo "Retrieving new sha256 from the new url"
new_url="https://gitlab.com/jjocram/asciimoji/-/archive/v$version_number/asciimoji-v$version_number.tar.gz"
new_sha=$(curl ${new_url} | sha256sum | /usr/bin/grep -oh "[a-zA-Z0-9_.-]*")

echo "Update asciimoji.rb file"
old_url=$(sed '4!d' asciimoji.rb | awk 'match($0,/"[^"]*"/) {print substr($0,RSTART+1,RLENGTH-2)}')
old_sha=$(sed '5!d' asciimoji.rb | awk 'match($0,/"[^"]*"/) {print substr($0,RSTART+1,RLENGTH-2)}')

sed -i '' -e "4s|${old_url}|${new_url}|g" asciimoji.rb
sed -i '' -e "5s/${old_sha}/${new_sha}/g" asciimoji.rb

#git add .
#git commit -m "Update to $version_number, see changelog on GitLab for details"
