$: << 'lib'
require 'git_wiki'

GitWiki.repository_url = ENV['GIT_WIKI_REPO_DIR'] || '../gw_files'
if ENV['GIT_WIKI_REPO_BRANCH']
  GitWiki.repository_branch = ENV['GIT_WIKI_REPO_BRANCH']
end


require 'irb'
IRB.start
