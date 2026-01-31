IMAGE_NAME := ""

build:
    #!/usr/bin/env bash
    set -eo pipefail
    if [ -z "{{IMAGE_NAME}}" ]; then
        echo "Error: IMAGE_NAME is not set."
        echo "This justfile is intended to be imported by model-specific justfiles."
        echo "Please run 'just build' from a subdirectory (e.g., prompt-writer/)."
        exit 1
    fi
    read -p "Enter version number: " version
    echo "Building {{IMAGE_NAME}}:v$version..."
    ollama create "{{IMAGE_NAME}}:v$version" -f Modelfile

clean:
    #!/usr/bin/env bash
    set -eo pipefail
    if [ -z "{{IMAGE_NAME}}" ]; then
        echo "Error: IMAGE_NAME is not set."
        echo "This justfile is intended to be imported by model-specific justfiles."
        echo "Please run 'just clean' from a subdirectory (e.g., prompt-writer/)."
        exit 1
    fi
    echo "Cleaning up {{IMAGE_NAME}} versions..."
    ollama list | grep "^{{IMAGE_NAME}}" | awk '{print $1}' | while read -r model; do
        echo "Removing $model..."
        ollama rm "$model"
    done
