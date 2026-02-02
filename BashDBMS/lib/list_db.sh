#!/bin/bash

echo "Available Databases:"
ls ./databases 2>/dev/null || echo "No databases found"
