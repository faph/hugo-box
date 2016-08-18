# Hugo Box

Docker container for building and deploying static websites with Hugo

Based on debian (stable) image. Installed packages:

 - hugo
 - git
 - openssh-client

Designed to be used on [Wercker](https://wercker.com) to automatically—

 1. Build the website using Hugo when pushing to a GitHub repo
 2. Publish the generated website to a GitHub Pages repo (authorised by SSH key)

A complete `wercker.yml` config file could look like this (save this in the root of the repo):

```yaml
box: faph/hugo-box

build:
  steps:
  - script:
      name: hugo-build
      code: hugo --source="${WERCKER_SOURCE_DIR}" --verbose

publish:
  steps:
  - wercker/add-ssh-key@1.0.3:
      host: github.com
      keyname: github_publish  # generate ssh key-pair on wercker.com, add public key to GitHub repo
  - wercker/add-to-known_hosts@2.0.1:
      hostname: github.com
      fingerprint: 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48
  - lordlothar99/git-push@0.7.18:
      host: github.com
      repo: {github_username}/{repo_name}
      gh_pages: true
      gh_pages_domain: example.org
      basedir: public
      clean_removed_files: true
```
