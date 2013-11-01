
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

    search = Plagiarism.url_search("http://example.com")

    # Was the request successful?
    search.success? # => true

    # Were any results found?
    search.results? # => true

    # Return the number results found
    search.count # => 324

    # Return the number of words checked
    search.words # => 1340

    # Return the Copyscape results URL
    search.results_url # => "http://view.copyscape.com/search/hm2yx3g9kg"

When using the <em>full_comparisons</em> option with a value >= 3 you get the following
extra result information:

    # Search with full comparisons (must be between 0 and 10)
    search = Plagiarism.url_search("http://example.com", full_comparisons: 3)

    # Was the request successful?
    search.success? # => true

    # Return the number of words matched from the source
    search.words_matched # => 1323

    # Return the percentage of words matched from the source
    search.percentage_matched # => 98


##### Check some text for plagiarism

    # Some text to search against (15 words minimum)
    excerpt = "When in the course of human events, it becomes necessary
      for one people to dissolve the political bands"

    search = Plagiarism.text_search(excerpt)

    # Was the request successful?
    search.success? # => true

    # Were any results found?
    search.results? # => true

    # Return the number results found
    search.count # => 324

    # Return the number of words checked
    search.words # => 1340

    # Return the Copyscape results URL
    search.results_url # => "http://view.copyscape.com/search/hm2yx3g9kg"



##### Check your account balance (in cents)

    Plagiarism.balance # => 9900



##### Check your remaining search credits

    Plagiarism.credits # => 1980


