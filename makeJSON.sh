lf="
"
double_quarto='"'
bslash="\\"

list=""

for file in src/*
do
plugin_code=$(cat $file)
plugin_code=${plugin_code//\\/\\\\\\\\}
plugin_code=${plugin_code//$lf/${bslash}${bslash}n}
plugin_code=${plugin_code//$double_quarto/$bslash$double_quarto}
target_file=json/${file//src\//}.json
echo "{
    \"type\": \"plugin\",
    \"data\": \"$plugin_code\"
}" > $target_file
hash=$(sha512sum $file)
list="${list}https://{HOST}/install-extentions?url=https://saranann.github.io/MisskeyPlugins/$target_file&hash=$hash
"
done

echo "$list" > hashlist.csv
