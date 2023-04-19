#! /bin/bash

### Get Arguments
repo_name_template="cpe"
desc="repository created.. "

while IFS= read -r packagetype; do
    repo_key="$repo_name_template-$packagetype-local-apac"
    description="$packagetype $desc"
    replace_cmd="jq '.key = \"$repo_key\" | .packageType = \"$packagetype\" | .description = \"$description\"' repo-create-template.json"
    eval "$replace_cmd" > repo-update-template.json
    jf rt repo-delete $repo_key --quiet
    jf rt repo-create repo-update-template.json
done < "repos-to-create.txt"
