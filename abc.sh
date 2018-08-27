version=$(curl \
  -H "X-HockeyAppToken: $HOCKEYAPP_TOKEN" \
  https://rink.hockeyapp.net/api/2/apps/$APP_ID/app_versions | jq -r '.app_versions[0].id')
echo $version

resignedUrl=$(curl \
-H "X-HockeyAppToken: $HOCKEYAPP_TOKEN" \
https://rink.hockeyapp.net/api/2/apps/$APP_ID/app_versions/$version?format=$FILE_FORMAT | jq -r '.headers.location')

echo $resignedUrl