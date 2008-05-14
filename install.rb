require 'rbconfig'
require 'find'
require 'ftools'

include Config

$sitedir = CONFIG["sitelibdir"]
unless $sitedir
  version = CONFIG["MAJOR"] + "." + CONFIG["MINOR"]
  $libdir = File.join(CONFIG["libdir"], "ruby", version)
  $sitedir = $:.find {|x| x =~ /site_ruby/ }
  if !$sitedir
    $sitedir = File.join($libdir, "site_ruby")
  elsif $sitedir !~ Regexp.quote(version)
    $sitedir = File.join($sitedir, version)
  end
end

Dir.chdir("lib")

Find.find("fusion_charts", "fusion_charts.rb") { |f|
  if f[-3..-1] == ".rb"
    File::install(f, File.join($sitedir, *f.split(/\//)), 0644, true)
  else
    File::makedirs(File.join($sitedir, *f.split(/\//)))
  end
}
