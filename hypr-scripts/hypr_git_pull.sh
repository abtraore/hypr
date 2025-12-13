#!/bin/bash

cd "$HYPR_DIR" && git pull && hyprctl reload
