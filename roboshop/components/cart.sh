#!/bin/bash
source components/common.sh
log=/tmp/roboshop.log
rm -rf $log

ADD_USER
NODEJS "cart"
SET_SYSTEMD_SERVICE "cart"