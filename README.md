<p align="center">
    <h1 align="center">Oktopus Documentation Site</h1>
    <p align="center">This is the repository of the  Oktopus Documentation Site.
    <p align="center"><strong><a href="https://oktopus-project.org/">Public link to the site.</a></strong></p>
    <br>
</p>

## Getting started

Oktopus Documentation Site is a static site build with [Jekyll](https://help.github.com/en/github/working-with-github-pages/getting-started-with-github-pages). Jekyll provides a [Docker container](https://github.com/envygeeks/jekyll-docker/blob/master/README.md) to quickly build the site. First get the Docker image by running:

```sh
docker pull jekyll/jekyll
```

Then build the site by running:

```sh
export JEKYLL_VERSION=3.8
docker run --rm \
  --volume="$PWD:/srv/jekyll" \
  --volume="$PWD/vendor/bundle:/usr/local/bundle" \
  -it jekyll/jekyll:$JEKYLL_VERSION \
  jekyll build
```

To test the site locally, run:
```sh
docker run --rm \
  -p 4000:4000 \
  --volume="$PWD:/srv/jekyll" \
  --volume="$PWD/vendor/bundle:/usr/local/bundle" \
  -it jekyll/jekyll:$JEKYLL_VERSION \
  jekyll serve
```

Afterward, open your browser at `http://localhost:4000`. 
