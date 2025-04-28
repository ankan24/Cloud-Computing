#!/bin/bash

# Amazon Lex CLI Commands

# Configure AWS CLI (if not already done)
aws configure

# List all Lex bots
aws lexv2-models list-bots

# Create a new bot
aws lexv2-models create-bot \
    --bot-name "MyBot" \
    --data-privacy-type "None" \
    --bot-type "Bot" \
    --description "My Lex Bot" \
    --idle-session-ttl-in-seconds 300 \
    --role-arn "arn:aws:iam::123456789012:role/LexRole"

# Create a locale for the bot
aws lexv2-models create-bot-locale \
    --bot-id "BOT_ID" \
    --bot-version "DRAFT" \
    --locale-id "en_US" \
    --nlu-intent-confidence-threshold 0.40 \
    --voice-settings "engine=neural,voice-id=Joanna"

# Create an intent
aws lexv2-models create-intent \
    --bot-id "BOT_ID" \
    --bot-version "DRAFT" \
    --locale-id "en_US" \
    --intent-name "GreetingIntent" \
    --description "Intent to handle greeting interactions"

# Create a slot type
aws lexv2-models create-slot-type \
    --bot-id "BOT_ID" \
    --bot-version "DRAFT" \
    --locale-id "en_US" \
    --slot-type-name "ProductType" \
    --value-selection-setting '{"resolutionStrategy":"ORIGINAL_VALUE"}'

# Create a slot in an intent
aws lexv2-models create-slot \
    --bot-id "BOT_ID" \
    --bot-version "DRAFT" \
    --locale-id "en_US" \
    --intent-id "INTENT_ID" \
    --slot-name "ProductName" \
    --slot-type-id "SLOT_TYPE_ID" \
    --value-elicitation-setting '{"promptSpecification":{"messageGroups":[{"message":{"plainTextMessage":{"value":"What product are you looking for?"}}}],"maxRetries":2}}'

# Update sample utterances for an intent
aws lexv2-models update-intent \
    --bot-id "BOT_ID" \
    --bot-version "DRAFT" \
    --locale-id "en_US" \
    --intent-id "INTENT_ID" \
    --sample-utterances '[{"utterance":"Hello"},{"utterance":"Hi there"},{"utterance":"Good morning"}]'

# Build the bot
aws lexv2-models build-bot-locale \
    --bot-id "BOT_ID" \
    --bot-version "DRAFT" \
    --locale-id "en_US"

# Create a bot version
aws lexv2-models create-bot-version \
    --bot-id "BOT_ID" \
    --description "First version of my bot"

# Create an alias for the bot version
aws lexv2-models create-bot-alias \
    --bot-id "BOT_ID" \
    --bot-alias-name "Production" \
    --bot-version "1" \
    --description "Production alias"

# Test the bot with text input
aws lexv2-runtime recognize-text \
    --bot-id "BOT_ID" \
    --bot-alias-id "ALIAS_ID" \
    --locale-id "en_US" \
    --session-id "UniqueSessionID" \
    --text "Hello"

# Delete a bot (requires deleting all dependent resources first)
# Delete aliases
aws lexv2-models delete-bot-alias \
    --bot-id "BOT_ID" \
    --bot-alias-id "ALIAS_ID"

# Delete bot versions
aws lexv2-models delete-bot-version \
    --bot-id "BOT_ID" \
    --bot-version "1"

# Delete intents and slots
aws lexv2-models delete-intent \
    --bot-id "BOT_ID" \
    --bot-version "DRAFT" \
    --locale-id "en_US" \
    --intent-id "INTENT_ID"

# Delete the bot itself
aws lexv2-models delete-bot \
    --bot-id "BOT_ID"

# Get information about a bot
aws lexv2-models describe-bot \
    --bot-id "BOT_ID"

# List bot aliases
aws lexv2-models list-bot-aliases \
    --bot-id "BOT_ID"

# List bot locales
aws lexv2-models list-bot-locales \
    --bot-id "BOT_ID" \
    --bot-version "DRAFT"

# List intents
aws lexv2-models list-intents \
    --bot-id "BOT_ID" \
    --bot-version "DRAFT" \
    --locale-id "en_US"

# Export bot to a zip file
aws lexv2-models export \
    --resource-specification 'botExportSpecification={botId=BOT_ID,botVersion=DRAFT}' \
    --file-format "LexJson" \
    file://exported-bot.zip

# Import bot from a zip file
aws lexv2-models import \
    --resource-specification 'botImportSpecification={botName=ImportedBot,roleArn=arn:aws:iam::123456789012:role/LexRole,dataPrivacy={childDirected=false}}' \
    --merge-strategy "OVERWRITE_LATEST" \
    --file-format "LexJson" \
    --file-password "password" \
    file://bot-to-import.zip