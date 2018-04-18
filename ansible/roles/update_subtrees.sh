#!/bin/bash


set -x
git subtree pull --prefix ansible/roles/skydive skydive roles_only --squash

