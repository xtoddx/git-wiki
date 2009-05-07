$: << 'lib'
require 'git_wiki'

GitWiki.repository_url = ENV['GIT_WIKI_REPO_DIR'] || '../gw_files'

require 'irb'
IRB.start
