#!/bin/bash
set -e
source /pd_build/buildconfig

run /pd_build/odoo.sh \
&& /pd_build/finalize.sh
