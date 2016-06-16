The Noun Project Ruby API Wrapper
===================

A Ruby API wrapper for [The Noun Project](https://thenounproject.com/) [API's](https://thenounproject.com/developers/)

[![Gem Version](https://badge.fury.io/rb/noun-project-api.svg)](http://badge.fury.io/rb/noun-project-api)[![Dependency Status](https://gemnasium.com/TailorBrands/noun-project-api.svg)](https://gemnasium.com/TailorBrands/noun-project-api)
[![Build Status](https://travis-ci.org/TailorBrands/noun-project-api.svg?branch=master)](https://travis-ci.org/TailorBrands/noun-project-api)
[![Circle CI](https://circleci.com/gh/TailorBrands/noun-project-api/tree/master.svg?style=svg)](https://circleci.com/gh/TailorBrands/noun-project-api/tree/master)  [![Code Climate](https://codeclimate.com/github/TailorBrands/noun-project-api/badges/gpa.svg)](https://codeclimate.com/github/TailorBrands/noun-project-api)  [![Test Coverage](https://codeclimate.com/github/TailorBrands/noun-project-api/badges/coverage.svg)](https://codeclimate.com/github/TailorBrands/noun-project-api)

```rb
gem "noun-project-api", "~> 1.0.0"
```

## Missing

Current version only wraps the Icon/Icons API's. Feel free to send a pull request with more API's wrapped!

## Usage

You need a valid pair of token and secret to use the Gem, you can get these by signing up [here](https://thenounproject.com/developers)

*Raises ArgumentError on bad arguments*

### Configuration
You can use an initializer for example if you're on Rails.
```rb
# initializers/noun_project_api.rb
NounProjectApi.configure do |config|
  # Will only show public domain icons when running in dev/test envs
  config.public_domain = ['development', 'test'].include?(ENV['RAILS_ENV'])
end
```

### Find single icon
Initialize
```rb
icon_finder = NounProjectApi::IconRetriever.new(token, secret)
```

Find an Icon by id [source](https://api.thenounproject.com/documentation.html#get--icon-(int-id))
```rb
result = icon_finder.find(1) # Returns a hash of the parsed JSON result.
```

Find an Icon by slug [source](https://api.thenounproject.com/documentation.html#get--icon-(string-term))
```rb
result = icon_finder.find_by_slug('globe') # Returns a hash of the parsed JSON result.
```

### Search icons
Initialize
```rb
icons_finder = NounProjectApi::IconsRetriever.new(token, secret)
```

*Optional arguments for both methods are limit, offset and page*

Find Icons [source](https://api.thenounproject.com/documentation.html#get--icons-(string-term))
```rb
result = icons_finder.find('cat') # Returns an array of the parsed JSON results.
```

Get recent Icons [source](https://api.thenounproject.com/documentation.html#get--icons-recent_uploads)
```rb
result = icons_finder.recent_uploads # Returns an array of the parsed JSON results.
```

### Find a collection of icons
Initialize
```rb
collection_finder = NounProjectApi::CollectionRetriever.new(token, secret)
```

Find a Collection by id [source](http://api.thenounproject.com/documentation.html#get--collection-(int-id))
```rb
result = collection_finder.find(1) # Returns a hash of the parsed JSON result.
```

Find a Collection by slug [source](http://api.thenounproject.com/documentation.html#get--collection-(slug))
```rb
result = collection_finder_finder.find_by_slug('national-park-service') # Returns a hash of the parsed JSON result.
```


#### Resulting objects
The resulting object is either a NounObjectApi::Icon or an array of ones.

```rb
result.class # NounProjectApi::Icon
result.id # 1
result.public_domain? # true/false
result.svg_url # url/nil
result.preview_url # 200 size preview url
result.preview_url(42) # 42 size preview url

# You can always access the original Hash at
result.original_hash
```

## TODOS

See [wiki](https://github.com/TailorBrands/noun-project-api/wiki/Todos)

## Disclaimer

This is completely unofficial and is not related to The Noun Project in any way.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## About Tailor Brands
[Check us out!](https://www.tailorbrands.com)
