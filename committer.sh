#! /bin/sh

echo "New version number:"
read version_number

git add .
git commit -m "Update to $version_number, see changelog on GitLab for details"
