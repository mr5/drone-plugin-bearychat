#!/usr/bin/env bash
BUILT_STATUS='Unknown'
if [ -n "$DRONE_BUILD_STATUS" ] 
then
  BUILT_STATUS=$DRONE_BUILD_STATUS
fi

BUILT_COLOR='#C9CCD1'
if [ "$BUILT_STATUS" = 'success' ] 
then
  BUILT_COLOR='#4BC0C0'
  if [ "$BUILT_STATUS" != "$DRONE_PREV_BUILD_STATUS" ] 
  then
    BUILT_STATUS='Fixed'
  fi
fi

if [ "$BUILT_STATUS" = 'failure' ] 
then
  BUILT_COLOR='#FF6384'
fi

curl $PLUGIN_URL \
  -H 'Content-Type: application/json' \
  -d "
{
  \"text\": \"${BUILT_STATUS}: build [#${DRONE_JOB_NUMBER}](${DRONE_BUILD_LINK}), in ${DRONE_COMMIT_BRANCH} of [${DRONE_REPO_NAME}](${DRONE_COMMIT_LINK})${PLUGIN_EXTERNAL_MSG}\",
  \"channel\": \"$PLUGIN_CHANNEL\",
  \"markdown\": true,
  \"attachments\": [
    {
      \"text\": \"[${DRONE_COMMIT_REF}](${DRONE_COMMIT_LINK}) - ${DRONE_COMMIT_AUTHOR}\",
      \"color\": \"${BUILT_COLOR}\"
    }
  ]
}"
