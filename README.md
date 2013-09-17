
![Build Status](https://api.travis-ci.org/zohlgren/plagiarism.png) &nbsp;
![Code Climate](https://codeclimate.com/github/zohlgren/plagiarism.png) &nbsp;
![Coverage Status](https://coveralls.io/repos/zohlgren/plagiarism/badge.png?branch=master)



## Plagiarism

Search for plagiarism and check the originality of your content with Copyscape.

Plagiarism is a Ruby wrapper for the Copyscape (http://copyscape.com) Premium API.



### Getting Started


    gem install plagiarism


Once you have your Copyscape username and API key you'll need to configure them.

    Plagiarism.username = "username"
    Plagiarism.api_key = "123456"


You can enable test mode to have Copyscape search against their example page,
http://www.copyscape.com/example.html.

    Plagiarism.test_mode = true


### Usage


##### Check a URL for plagiarism

    search = Plagiarism.url_seach("http://example.com")

    if search.results? # => true

      # How many results were found?
      search.count # => 324

      # Wow! That's a lot of results. Let's take a look...
      search.results_url # => "http://view.copyscape.com/search/hm2yx3g9kg"

    end



##### Check some text for plagiarism

    # Some text to search against (15 words minimum)
    excerpt = "When in the course of human events, it becomes necessary
      for one people to dissolve the political bands"

    search = Plagiarism.text_seach(excerpt)

    if search.results? # => true

      # How many results were found?
      search.count # => 324

      # Wow! That's a lot of results. Let's take a look...
      search.results_url # => "http://view.copyscape.com/search/hm2yx3g9kg"

    end



##### Check your account balance (in cents)

    Plagiarism.balance # => 9900



##### Check your remaining search credits

    Plagiarism.credits # => 1980


