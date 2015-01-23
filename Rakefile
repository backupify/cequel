require File.expand_path('../lib/cequel_cql2/version', __FILE__)
require 'rspec/core/rake_task'

task :default => :release
task :release => [:verify_changelog, :test, :build, :tag, :update_stable, :push, :cleanup]

desc 'Build gem'
task :build do
  system 'gem build cequel.gemspec'
end

desc 'Create git release tag'
task :tag do
  system "git tag -a -m 'Version #{CequelCQL2::VERSION}' #{CequelCQL2::VERSION}"
  system "git push origin #{CequelCQL2::VERSION}:#{CequelCQL2::VERSION}"
end

desc 'Update stable branch on GitHub'
task :update_stable do
  if CequelCQL2::VERSION =~ /^(\d+\.)+\d+$/ # Don't push for prerelease
    system "git push -f origin HEAD:stable"
  end
end

desc 'Push gem to repository'
task :push do
  system "gem push cequel-#{CequelCQL2::VERSION}.gem"
end

task 'Push gem to geminabox'
task :inabox do
  system "gem inabox cequel-#{CequelCQL2::VERSION}.gem"
end

task 'Remove packaged gems'
task :cleanup do
  system "rm -v *.gem"
end

desc 'Run the specs'
task :test do
  abort unless system 'bundle', 'exec', 'rspec', 'spec/examples'
end

desc 'Update changelog'
task :changelog do
  require './lib/cequel_cql2/version.rb'

  last_tag = `git tag`.each_line.map(&:strip).last
  existing_changelog = File.read('./CHANGELOG.md')
  File.open('./CHANGELOG.md', 'w') do |f|
    f.puts "## #{CequelCQL2::VERSION}"
    f.puts ""
    f.puts `git log --no-merges --pretty=format:'* %s' #{last_tag}..`
    f.puts ""
    f.puts existing_changelog
  end
end

task :verify_changelog do
  require './lib/cequel_cql2/version.rb'

  if File.read('./CHANGELOG.md').each_line.first.strip != "## #{CequelCQL2::VERSION}"
    abort "Changelog is not up-to-date."
  end
end
