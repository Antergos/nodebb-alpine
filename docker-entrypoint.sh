#!/bin/bash

# Give Redis some time to come up
sleep 10

./nodebb upgrade && ./nodebb dev

exit 1