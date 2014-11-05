The Noun Project Ruby API Wrapper
===================

A Ruby API wrapper for [The Noun Project](https://thenounproject.com/) [API's](https://thenounproject.com/developers/)

[![Circle CI](https://circleci.com/gh/TailorBrands/noun-project-api/tree/master.png?style=badge)](https://circleci.com/gh/TailorBrands/noun-project-api/tree/master)  [![Code Climate](https://codeclimate.com/github/TailorBrands/noun-project-api/badges/gpa.svg)](https://codeclimate.com/github/TailorBrands/noun-project-api)  [![Test Coverage](https://codeclimate.com/github/TailorBrands/noun-project-api/badges/coverage.svg)](https://codeclimate.com/github/TailorBrands/noun-project-api)

```rb
gem "noun-project-api", "~> 0.0.4"
```

## Missing

Current version only wraps the Icon/Icons API's. Feel free to send a pull request with more API's wrapped!

## Usage

You need a valid pair of token and secret to use the Gem, you can get these by signing up [here](https://thenounproject.com/developers)

*Raises ArgumentError on bad arguments*

### Single Icon
Initialize
```rb
icon_finder = NounProjectApi::Icon.new(token, secret)
```

Find an Icon by id [source](https://api.thenounproject.com/documentation.html#get--icon-(int-id))
```rb
result = icon_finder.find(1) # Returns a hash of the parsed JSON result.
```

Find an Icon by slug [source](https://api.thenounproject.com/documentation.html#get--icon-(string-term))
```rb
result = icon_finder.find_by_slug('globe') # Returns a hash of the parsed JSON result.
```

### Icons
Initialize
```rb
icons_finder = NounProjectApi::Icons.new(token, secret)
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
