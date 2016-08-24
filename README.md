[![Gem Version](https://badge.fury.io/rb/researchmap2bib.svg)](https://badge.fury.io/rb/researchmap2bib)
[![Build Status](https://travis-ci.org/ychubachi/researchmap2bib.svg?branch=master)](https://travis-ci.org/ychubachi/researchmap2bib)

# Researchmap2bib

A script to a generate LaTeX (BibTeX) bibliography file of your published papers list stored in the [researchmap](https://researchmap.jp/) database.

[researchmap](https://researchmap.jp/)のデータベースに登録された論文一覧からLaTeX（BibTeX）のbibliographyファイルを作成するスクリプトです．

## Usage

[researchmap](https://researchmap.jp/)にログインしてXML形式で業績をダウンロードしてください．zipファイルが1つダウンロードされます．このファイル名がresearcher.zipだとするとき，次のコマンドでbibliographyファイルが生成できます．

```bash
resarchmap2bib generate researcher.zip
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'researchmap2bib'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install researchmap2bib

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/researchmap2bib.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

