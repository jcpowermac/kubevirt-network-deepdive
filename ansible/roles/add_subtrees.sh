#!/bin/bash


set -x

git remote add -f skydive git@github.com:jcpowermac/skydive.git
git subtree add --prefix ansible/roles/skydive skydive roles_only --squash
