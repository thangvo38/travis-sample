x=$(curl \
  -H "X-HockeyAppToken: $HOCKEYAPP_TOKEN" \
  https://rink.hockeyapp.net/api/2/apps/$APP_ID/app_versions | jq -r '.app_versions[0].id')
echo $x