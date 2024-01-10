lf="
"
double_quarto='"'

list=""

for file in src/*
do
plugin_code=$(cat $file)
plugin_code=${plugin_code//$lf/\\\\n}
plugin_code=${plugin_code//$double_quarto/\\$double_quarto}
target_file=json/${file//src\//}.json
echo $plugin_code > $target_file
hash=$(sha512sum $target_file)
echo "{
    \"type\": \"plugin\",
    \"data\": \"$plugin_code\"
}" > $target_file

list="${list}https://{HOST}/install-extentions?url=https://saranann.github.io/MisskeyPlugins/$target_file&hash=$hash
"
done

echo "$list" > hashlist.csv
