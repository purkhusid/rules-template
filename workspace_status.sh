#!/usr/bin/env bash

set -e

# Set the correct COMMIT_SHA in case we are running in Github Actions and the workflow was triggered by a pull request
# If the workflow is triggered by a PR the GITHUB_SHA env is set to the sha of the merge commit so we need to
# override it so that the correct commit is used in the bazel build and tools that create github checks use the correct
# git commit to pin it to
if [ -n "${GITHUB_ACTIONS}" ]; then
    PR_HEAD_SHA="$(cat "${GITHUB_EVENT_PATH}" | jq -r '.pull_request.head.sha')"
    if [ "${PR_HEAD_SHA}" != "null" ]; then
        echo "ROLE CI"
        echo "COMMIT_SHA ${PR_HEAD_SHA}"
        echo "REPO_URL ${GITHUB_REPOSITORY}"
        echo "BRANCH_NAME ${GITHUB_HEAD_REF}"
    fi
fi
