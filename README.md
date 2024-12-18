# Propshaft::Compressor

`Propshaft::Compressor` is an extension for the Propshaft asset pipeline for Rails. It adds automatic compression of assets. It is intended to be as plug-and-play as possible.

It is designed to be compatible with the new Rails 8 deployment idioms, but works with Rails 7.x too. Since it's a plugin to Propshaft, it requires the app to use Propshaft instead of Sprockets.

This gem will always compile `.gz` (gzip) versions of assets. It will add `.br` (brotli) versions if the `brotli` gem is present. Likewise, it will add `.zst` (zstandard) versions if the `zstd-ruby` gem is present.

All formats compile at max-compression.

Some common file types are automatically excluded from compression since they already contain dense or compressed content. These include: jpg, mp3, mp4, png, webp, woff, woff2.


## Installation

Just add the gem to your app's Gemfile. It will automatically hook into the `assets:precompile` task and compress all assets after compiling.

```ruby
gem "propshaft-compressor"

# optional (either or both)
gem "brotli"
gem "zstd-ruby"
```


## Usage

To make use of the precompressed assets, something needs to recognize and serve the compressed version when requested by client browsers.

If your app is using the built-in Rails file server (many do), no additional config is required. The Rails file server will automatically recognize and serve `gz` and `br`, but not `zst`.

Nginx has a built-in module that can recognize and use `gz` files. There are also addon modules for both `br` and `zst`.

Other webservers have varying support for serving pre-compressed assets.

This gem makes no effort to cleanup stale assets. If using Dockerfile-based deployments, this should be no problem. If using a deployment mechanism that leaves old assets behind, it may be necessary to periodically run `assets:clobber` (before `assets:precompile`).


## FAQ

###### Q: My webserver or CDN automatically compresses assets. Do I need this?

A: Possibly. Most on-the-fly compression will use lower compression levels to improve compression speed. Precompressing at a higher compression level will result in smaller files, faster downloads, and smaller bandwidth bills.

Additionally, some webservers and CDNs limit which formats they will use to dynamically compress content. Precompressing may give you more control over this.

###### Q: Does this compress dynamic content?

A: No, just static assets that are precompiled as part of the asset pipeline.

###### Q: Can I use this with Sprockets?

A: No, it's just for Propshaft.


## Contributing

Contributions welcomed. Please use standard GitHub Pull Requests.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
