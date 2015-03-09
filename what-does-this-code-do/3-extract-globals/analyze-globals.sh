#!/bin/bash
grep -nP '^\S.*;' *.c | grep -v static | grep -vP '^\w+\.c:\d+:}'
