#!/usr/bin/env python

import argparse
import copy
import os
import json


def fetch_pkg_expressions(url, branch):
    return json.loads(
        os.popen("nix-prefetch-git --quiet --url {} --branch-name".format(url, branch)).read())


desc = '''
Updates package lock(s) for one or more repositories in the `.nixpkgs-version.json`
package lock by moving the lock to the value of HEAD of that repository. Running this
program without arguments will attempt to move the git ref to HEAD of every package repository
lock. Specifying a value for 'REPO' will update just that lock.
'''
parser = argparse.ArgumentParser(description=desc)
parser.add_argument(
    'repo',
    metavar='REPO',
    nargs='?',
    type=str,
    default=None,
    help="Package repository to update.")

args = parser.parse_args()
workspace = os.environ["WORKSPACE"]
lock_path = os.path.join(workspace, ".nixpkgs-version.json")

with open(lock_path, 'r+') as lock_file:
    data = json.load(lock_file)
    original = copy.deepcopy(data)
    # Iterate through each repository
    for repo_id, repo in data.items():
        # Fetch and update the lock if the repository name is a match or if the
        # program was called without a value for the repository argument.
        if args.repo == None or repo_id == args.repo:
            print("Fetching {}...".format(repo_id))
            expr = fetch_pkg_expressions(repo['url'], repo['ref'])
            if data[repo_id]["sha256"] != expr["sha256"]:
                data[repo_id].update(expr)
    if original == data:
        print("Lockfile up to date.")
    else:
        print("Updating package lockfile: %s" % (lock_path))
        lock_file.seek(0)
        lock_file.truncate()
        json.dump(data,
                  lock_file,
                  indent=2,
                  sort_keys=True,
                  separators=(',', ': '))
