#!/bin/bash
# Only register if not already configured
if [ ! -f ".runner" ]; then
    ./config.sh \
        --url https://github.com/MHSnodgrass/fifa-api \
        --token ${RUNNER_TOKEN} \
        --name fifa-api-runner \
        --labels self-hosted,linux \
        --unattended
fi

./run.sh