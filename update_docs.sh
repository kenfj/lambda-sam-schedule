#!/bin/sh

if ! hash terraform-docs >/dev/null 2>&1; then
    echo Please run \"brew install terraform-docs\"
    exit 1
fi

MARK=the_below_is_auto_generated_by_terraform-docs

# first delete below the MARK
perl -i -0pe "s/${MARK}.+$/${MARK}\n\n/s" README.md
# then append the new doc
terraform-docs markdown . >> ./README.md
