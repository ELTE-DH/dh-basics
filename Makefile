# Minimal makefile for Sphinx documentation
#
SHELL := /bin/bash
SOURCE_DATE_EPOCH := $(shell git log -1 --pretty=%ct)

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?= -W
# SPHINXOPTS    ?= -W -b spelling
SPHINXBUILD   ?= ./venv/bin/sphinx-build
SOURCEDIR     ?= source
BUILDDIR      ?= $(shell mktemp -d)

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

venv:
	python3 -m pip install virtualenv
	python3 -m virtualenv -p python3 venv
	./venv/bin/python3 -m pip install -r requirements.txt
.PHONY: venv

github:
	BUILDDIR=${BUILDDIR} make venv html push-gh-pages

push-gh-pages:
	set -eo pipefail
	git fetch --depth=1
	BRANCH="$$(git rev-parse --abbrev-ref HEAD)"
	if [[ "$$BRANCH" != "main" ]]; then echo 'Not pushing, as we are not on main!'; exit 0; fi
	git show-branch remotes/origin/gh-pages && git checkout gh-pages || git checkout --orphan gh-pages
	# Clean the directory
	find -not -path "./.git/*" -not -name ".git" -delete
	# Copy built files
	cp -a "${BUILDDIR}/html/." .

	# Adds .nojekyll file to the root to signal to GitHub that
	# directories that start with an underscore (_) can remain
	touch .nojekyll

	# Add README
	cat > README.md <<EOF
	# README for the GitHub Pages Branch
	This branch is simply a cache for the website served from $${GITHUB_IO_URL}, and is
	 not intended to be viewed on github.com.
	<!--- The goal of this comment is to force Makefile not to skip this line -->
	For further information see the default branch of the repository: https://github.com/$${GITHUB_REPOSITORY}.
	EOF

	# Add built html pages to the gh-pages branch
	git add .

	# Set user name and email and make a commit with changes and any new files (even an empty commit)
	git config user.name "$${GITHUB_ACTOR}" && \
	git config user.email "$${GITHUB_ACTOR}@users.noreply.github.com" && \
	git commit --allow-empty -am "Updating Docs for commit $${GITHUB_SHA} made on `date -d"@${SOURCE_DATE_EPOCH}" --iso-8601=seconds` from $${GITHUB_REF} by $${GITHUB_ACTOR}"

	# Push the contents to the gh-pages branch on our github.com repo
	git push origin gh-pages
.ONESHELL: push-gh-pages
.PHONY: push-gh-pages

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
