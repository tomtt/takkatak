cucumber_gem_dir = nil
Dir["#{RAILS_ROOT}/vendor/gems/*"].each do |subdir|
  cucumber_gem_dir = subdir if subdir.gsub("#{RAILS_ROOT}/vendor/gems/","") =~ /^(\w+-)?cucumber-(\d+)/ && File.exist?("#{subdir}/lib/cucumber/rake/task.rb")
end
cucumber_plugin_dir = "#{RAILS_ROOT}/vendor/plugins/cucumber"

if cucumber_gem_dir && File.directory?( cucumber_plugin_dir )
  raise "\n#{'*'*50}\nYou have cucumber installed in both vendor/gems and vendor/plugins\nPlease pick one and dispose of the other.\n#{'*'*50}\n\n"
end

if cucumber_gem_dir
  $LOAD_PATH.unshift("#{cucumber_gem_dir}/lib") 
elsif File.directory?(cucumber_plugin_dir)
  $LOAD_PATH.unshift("#{cucumber_plugin_dir}/lib")
end

require 'cucumber/rake/task'

task :default => "features:committed"

Cucumber::Rake::Task.new(:features => 'db:test:prepare') do |t|
  t.cucumber_opts = "--format pretty"
end

namespace :features do
  desc "Run Committed Features with Cucumber"
  Cucumber::Rake::Task.new(:committed => 'db:test:prepare') do |t|
    t.cucumber_opts = %w(--strict -f progress -t committed features)
  end
  desc "Run Trasitional Features with Cucumber"
  Cucumber::Rake::Task.new(:transitional => 'db:test:prepare') do |t|
    t.cucumber_opts = %w(-f progress -t transitional features)
  end
  desc "Run Development Features with Cucumber"
  Cucumber::Rake::Task.new(:development => 'db:test:prepare') do |t|
    t.cucumber_opts = %w(-f progress -t development features)
  end
  desc "Run currently tested features with Cucumber"
  Cucumber::Rake::Task.new(:current => 'db:test:prepare') do |t|
    t.cucumber_opts = %w(-f progress -t current features)
  end
  desc "Run debugged features with Cucumber"
  Cucumber::Rake::Task.new(:debug => 'db:test:prepare') do |t|
    t.cucumber_opts = %w(-f progress -t debug features)
  end
  desc "Show stages of features"
  Cucumber::Rake::Task.new(:stages => 'db:test:prepare') do |t|
    t.cucumber_opts = %w(-f Cucumber::Formatter::DevelopmentStage --dry-run features)
  end
  desc "Generate html file with cucumber result for each trac tag"
  Cucumber::Rake::Task.new(:html_files => 'db:test:prepare') do |t|
    t.cucumber_opts = %w(-f Cucumber::Formatter::HtmlFiles features)
  end
  desc "Generate html files for visual inspection"
  Cucumber::Rake::Task.new(:screenshots => 'db:test:prepare') do |t|
    t.cucumber_opts = %w(-f Cucumber::Formatter::ScreenShots features)
  end
end
