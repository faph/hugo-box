[![Docker Automated build](https://img.shields.io/docker/automated/faph/hugo-box.svg?maxAge=2592000)](https://hub.docker.com/r/faph/hugo-box/)

# Hugo Box

Docker container for building and deploying static websites with [Hugo](https://gohugo.io).

Based on [debian (stable) image](https://hub.docker.com/_/debian/). Additionally installed packages:

 - hugo
 - git
 - openssh-client

Designed to be used on [Wercker](https://wercker.com) to automatically and **super fast**—

 1. **Build** the website using Hugo when pushing to a GitHub repo
 2. **Publish** the generated website to a GitHub Pages repo (authorised by SSH key)

Separate Docker images are available for different Hugo releases, starting from version 0.16.

A complete `wercker.yml` config file could look like this (save this in the root of the repo):

```yaml
box: faph/hugo-box:0.22

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
  - faph/git-push:
      repo: ssh://git@github.com:{username}/{repo}.git
      branch: gh-pages
      basedir: public
```

## Terms & Conditions

Released under the [MIT License (MIT)](LICENSE).

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
