if [ -z "$GITHUB_TOKEN" ]; then
  echo "Set GITHUB_TOKEN"
  exit 1
fi

if [ $# -eq 0 ]
then
  echo "Usage: ./run-org.sh org-name"
  exit 1
fi

dirname=github-backup-$1-$(date "+%Y-%m-%d-%H-%M-%S")
mkdir "$dirname"
cd "$dirname" || exit

curl -H "Accept: application/vnd.github.nebula-preview+json" \
    -H "Authorization: token $GITHUB_TOKEN" \
    "https://api.github.com/orgs/$1/repos?visibility=all&affiliation=owner&per_page=200" \
     | jq -r '.[] | .name' \
     | while IFS= read -r projectName; do
         curl -H "Authorization: token $GITHUB_TOKEN" -H "Accept: application/vnd.github.v3.raw" -L \
          "https://api.github.com/repos/$1/$projectName/zipball" --output "$projectName.zip"
      done

cd .. || exit 1
tar cf "$dirname.tar" -C "$dirname" .
rm -rf "$dirname"
