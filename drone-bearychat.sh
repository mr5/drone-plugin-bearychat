#!/bin/sh

BUILT_COLOR='#C9CCD1'
if [ "$DRONE_JOB_STATUS" = 'success' ] ; then
  BUILT_COLOR='#00bfa5'
  if [ "$DRONE_JOB_STATUS" != "$DRONE_PREV_BUILD_STATUS" ] ; then
    BUILT_STATUS='Fixed'
  fi
fi

if [ "$DRONE_JOB_STATUS" = 'failure' ] ; then
  BUILT_COLOR='#f50057'
fi

curl $PLUGIN_URL \
  -H 'Content-Type: application/json' \
  -d "
{
  \"text\": \"*${DRONE_JOB_STATUS}*: build [#${DRONE_BUILD_NUMBER}](${DRONE_BUILD_LINK}), in ${DRONE_COMMIT_BRANCH} of [${DRONE_REPO_NAME}](${DRONE_REPO_LINK})${PLUGIN_EXTERNAL_MSG}\",
  \"channel\": \"$PLUGIN_CHANNEL\",
  \"markdown\": true,
  \"attachments\": [
    {
      \"text\": \"[${DRONE_COMMIT_SHA:0:7}](${DRONE_COMMIT_LINK}) ${DRONE_COMMIT_MESSAGE} - ${DRONE_COMMIT_AUTHOR}\",
      \"color\": \"${BUILT_COLOR}\"
    }
  ]
}"
