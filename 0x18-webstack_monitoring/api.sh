#!/usr/bin/bash

curl -X GET "https://api.datadoghq.com/api/v1/dashboard/lists/manual" \
        -H "Accept: application/json" \
        -H "DD-API-KEY: ${DD_API_KEY}" \
        -H "DD-APPLICATION-KEY: ${DD_APP_KEY}"

curl -X GET "https://api.datadoghq.com/api/v1/dashboard" -H "Content-Type: application/json" -H "DD-API-KEY: ${DD_API_KEY}" -H "DD-APPLICATION-KEY: ${DD_APP_KEY}"
