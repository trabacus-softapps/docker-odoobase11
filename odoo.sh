#!/bin/bash
set -e
source /pd_build/buildconfig

header "Installing Odoo Runint Script... "

## Install Odoo runit service.
run mkdir /etc/service/odoo
run cp /pd_build/runit/odoo /etc/service/odoo/run
run touch /etc/service/odoo/down
header "Installing Odoo..."

## Install Odoo.
run sudo -i -u odoo
curl -Lf -o /opt/odoo/odoo.tar.gz http://nightly.odoo.com/11.0/nightly/src/odoo_11.0.20180403.tar.gz
run mkdir -p /opt/odoo/{bin,etc,sources/odoo/addons,additional_addons,data} && \
        cd /opt/odoo/sources/odoo && \
        tar -xvf /opt/odoo/odoo.tar.gz --strip 1 && \
	cp -r -p /opt/odoo/sources/odoo/setup/odoo /opt/odoo/sources/odoo/openerp-server && \
        rm /opt/odoo/odoo.tar.gz
run mkdir -p /opt/odoo/var/{run,log,egg-cache,ftp}

run cp /pd_build/sources/odoo.conf /opt/odoo/etc/odoo.conf
run chown -R odoo /opt/odoo
