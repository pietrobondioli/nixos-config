#!/usr/bin/env bash
# Reusable logging utility for bash scripts
# Usage: source this file and call log_info, log_error, etc.

# Initialize logging for the current script
# Creates a log file in /tmp with the script's name
_init_logger() {
  # Get the name of the calling script (not this library)
  # Use the last element of BASH_SOURCE which is the main script
  local script_name
  local main_script="${BASH_SOURCE[-1]}"

  # If BASH_SOURCE[-1] is bash or empty, fall back to $0
  if [[ "$main_script" == "bash" ]] || [[ -z "$main_script" ]]; then
    main_script="$0"
  fi

  script_name=$(basename "$main_script")

  # Create log file in /tmp
  export LOG_FILE="/tmp/${script_name}.log"

  # Optional: Rotate log if it gets too large (>10MB)
  if [ -f "$LOG_FILE" ] && [ $(stat -c%s "$LOG_FILE" 2>/dev/null || stat -f%z "$LOG_FILE" 2>/dev/null || echo 0) -gt 10485760 ]; then
    mv "$LOG_FILE" "$LOG_FILE.old"
  fi

  # Create/touch the log file
  touch "$LOG_FILE"
}

# Internal logging function
_log() {
  local level="$1"
  shift
  local message="$*"
  local timestamp
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')

  echo "[$timestamp] [$level] $message" >> "$LOG_FILE"
}

# Public logging functions
log_info() {
  _log "INFO" "$@"
}

log_warn() {
  _log "WARN" "$@"
}

log_error() {
  _log "ERROR" "$@"
}

log_debug() {
  _log "DEBUG" "$@"
}

# Log and also print to stderr
log_error_stderr() {
  log_error "$@"
  echo "ERROR: $*" >&2
}

# Log command output (useful for debugging)
# Usage: some_command 2>&1 | log_output
log_output() {
  while IFS= read -r line; do
    _log "OUTPUT" "$line"
  done
}

# Show last N lines of log
# Usage: log_tail [lines]
log_tail() {
  local lines="${1:-20}"
  tail -n "$lines" "$LOG_FILE"
}

# Initialize logger when sourced
_init_logger
