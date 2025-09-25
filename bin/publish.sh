#!/bin/sh
set -e

SCRIPT_PATH=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ROOT_PATH="$SCRIPT_PATH/.."
cd $ROOT_PATH

SERVICE_NAME=$(jq -r ".name" package.json)
CURRENT_VERSION=$(jq -r ".version" package.json)

echo "Current version: $CURRENT_VERSION"

NEXT_VERSION=$(echo $CURRENT_VERSION | awk -F. -v OFS=. '{$NF++;print}')
echo "Next version: $NEXT_VERSION"

jq ".version = \"$NEXT_VERSION\"" package.json > package.json.tmp && mv package.json.tmp package.json

echo "Publishing $SERVICE_NAME@$NEXT_VERSION..."
npm publish --access public
echo "✅ Published $SERVICE_NAME@$NEXT_VERSION"
