#!/usr/bin/env bash
# ------------------------------------------------------------
# update and upgrade all template one per one
# ------------------------------------------------------------

# Directory that holds the template folders
TEMPLATE_DIR="/var/lib/qubes/vm-templates"

# ------------------------------------------------------------------
# Basic sanity checks
# ------------------------------------------------------------------
if [[ ! -d "$TEMPLATE_DIR" ]]; then
    echo "❌ Template directory not found: $TEMPLATE_DIR"
    exit 1
fi

# Helper to prepend timestamps to log messages
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

# ------------------------------------------------------------------
# Main processing loop
# ------------------------------------------------------------------
for dir in "$TEMPLATE_DIR"/*/ ; do
    # Strip trailing slash and keep only the folder name
    qube_name=$(basename "${dir%/}")

    # Skip empty names or names containing spaces (adjust if you need to support them)
    if [[ -z "$qube_name" || "$qube_name" =~ \  ]]; then
        log "⚠️  Skipping invalid entry: '$qube_name'"
        continue
    fi

    log "🔧 Processing template: $qube_name"

    # 1️⃣ Start the VM (if it isn’t already running)
    qvm-start "$qube_name"
    if [[ $? -ne 0 ]]; then
        log "❗ Failed to start $qube_name – moving to next template."
        continue
    fi
    sleep 3


    # 2️⃣ sudo apt update && upgrade in template
qvm-run "$qube_name" "sudo apt update -y"
qvm-run "$qube_name" "sudo apt upgrade -y"



    # 5️⃣ Shut the VM down after the update
    qvm-shutdown "$qube_name"
    if [[ $? -ne 0 ]]; then
        log "❗ Failed to shut down $qube_name."
    else
        log "✅ $qube_name updated and shut down successfully."
    fi

    # Small pause before processing the next template (optional)
    sleep 5
done

log "🎉 All templates processed."