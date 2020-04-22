#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""For sort the modules in requirements.txt."""

import sys

try:
    with open("requirements.txt", "r") as f:
        modules = f.read().splitlines()

    modules = sorted([x.lower() for x in set(modules)])

    with open("requirements.txt", "w") as f:
        for item in modules:
            f.write("%s\n" % item)

    print("requirements.txt sorted with success!!")
    sys.exit(0)
except Exception as e:
    print("Something went wrong!!")
    print(e)
    sys.exit(1)

# EOF
