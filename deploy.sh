#!/bin/bash
az deployment sub create --template-file ./main.bicep --parameters './parameters.dev.json' --location westeurope --output jsonc