#!/bin/sh
echo "DRONE_ARCH: ${DRONE_ARCH},DRONE_REPO: ${DRONE_REPO},DRONE_REPO_OWNER: ${DRONE_REPO_OWNER},DRONE_REPO_NAME: ${DRONE_REPO_NAME},DRONE_REPO_SCM: ${DRONE_REPO_SCM},DRONE_REPO_LINK: ${DRONE_REPO_LINK},DRONE_REPO_AVATAR: ${DRONE_REPO_AVATAR},DRONE_REPO_BRANCH: ${DRONE_REPO_BRANCH},DRONE_REPO_PRIVATE: ${DRONE_REPO_PRIVATE},DRONE_REPO_TRUSTED: ${DRONE_REPO_TRUSTED},DRONE_REMOTE_URL: ${DRONE_REMOTE_URL},DRONE_COMMIT_SHA: ${DRONE_COMMIT_SHA},DRONE_COMMIT_REF: ${DRONE_COMMIT_REF},DRONE_COMMIT_BRANCH: ${DRONE_COMMIT_BRANCH},DRONE_COMMIT_LINK: ${DRONE_COMMIT_LINK},DRONE_COMMIT_MESSAGE: ${DRONE_COMMIT_MESSAGE},DRONE_COMMIT_AUTHOR: ${DRONE_COMMIT_AUTHOR},DRONE_COMMIT_AUTHOR_EMAIL: ${DRONE_COMMIT_AUTHOR_EMAIL},DRONE_COMMIT_AUTHOR_AVATAR: ${DRONE_COMMIT_AUTHOR_AVATAR},DRONE_BUILD_NUMBER: ${DRONE_BUILD_NUMBER},DRONE_BUILD_EVENT: ${DRONE_BUILD_EVENT},DRONE_BUILD_STATUS: ${DRONE_BUILD_STATUS},DRONE_BUILD_LINK: ${DRONE_BUILD_LINK},DRONE_BUILD_CREATED: ${DRONE_BUILD_CREATED},DRONE_BUILD_STARTED: ${DRONE_BUILD_STARTED},DRONE_BUILD_FINISHED: ${DRONE_BUILD_FINISHED},DRONE_PREV_BUILD_STATUS: ${DRONE_PREV_BUILD_STATUS},DRONE_PREV_BUILD_NUMBER: ${DRONE_PREV_BUILD_NUMBER},DRONE_PREV_COMMIT_SHA: ${DRONE_PREV_COMMIT_SHA},DRONE_JOB_NUMBER: ${DRONE_JOB_NUMBER},DRONE_JOB_STATUS: ${DRONE_JOB_STATUS},DRONE_JOB_EXIT_CODE: ${DRONE_JOB_EXIT_CODE},DRONE_JOB_STARTED: ${DRONE_JOB_STARTED},DRONE_JOB_FINISHED: ${DRONE_JOB_FINISHED},DRONE_YAML_SIGNED: ${DRONE_YAML_SIGNED},DRONE_YAML_VERIFIED: ${DRONE_YAML_VERIFIED},DRONE_BRANCH: ${DRONE_BRANCH},DRONE_COMMIT: ${DRONE_COMMIT},DRONE_TAG: ${DRONE_TAG},DRONE_PULL_REQUEST: ${DRONE_PULL_REQUEST},DRONE_DEPLOY_TO: ${DRONE_DEPLOY_TO}"

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
  \"text\": \"**${DRONE_JOB_STATUS}**: build [#${DRONE_BUILD_NUMBER}](${DRONE_BUILD_LINK}), in ${DRONE_COMMIT_BRANCH} of [${DRONE_REPO_NAME}](${DRONE_REPO_LINK})${PLUGIN_EXTERNAL_MSG}\",
  \"channel\": \"$PLUGIN_CHANNEL\",
  \"markdown\": true,
  \"attachments\": [
    {
      \"text\": \"[${DRONE_COMMIT_SHA:0:7}](${DRONE_COMMIT_LINK}) ${DRONE_COMMIT_MESSAGE} - ${DRONE_COMMIT_AUTHOR}\",
      \"color\": \"${BUILT_COLOR}\"
    }
  ]
}"
