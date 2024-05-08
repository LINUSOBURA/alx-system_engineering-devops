#!/usr/bin/bash
# Curl command
DD_API_KEY='23283a3cdac0c4a631981d1b309a9088'
DD_APP_KEY='0acdd57a52560b16d8741ca9e4f01c5bb3ecdad3'
curl -X GET "https://api.datadoghq.com/api/v1/dashboard/lists/manual" \
        -H "Accept: application/json" \
        -H "DD-API-KEY: ${DD_API_KEY}" \
        -H "DD-APPLICATION-KEY: ${DD_APP_KEY}"

curl -X GET "https://api.datadoghq.com/api/v1/dashboard" -H "Content-Type: application/json" -H "DD-API-KEY: ${DD_API_KEY}" -H "DD-APPLICATION-KEY: ${DD_APP_KEY}"
