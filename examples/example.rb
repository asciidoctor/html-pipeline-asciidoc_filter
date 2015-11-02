require 'html/pipeline'
require_relative '../lib/html/pipeline/asciidoc_filter'

filters = [
  HTML::Pipeline::AsciiDocFilter,
  HTML::Pipeline::SanitizationFilter,
  HTML::Pipeline::ImageMaxWidthFilter,
  HTML::Pipeline::EmojiFilter,
  HTML::Pipeline::MentionFilter,
  HTML::Pipeline::AutolinkFilter,
  HTML::Pipeline::TableOfContentsFilter
]

begin
  require 'linguist'
  filters << HTML::Pipeline::SyntaxHighlightFilter
rescue LoadError
end

context = {
  :asset_root => 'https://assets-cdn.github.com/images/icons'
}

pipeline = HTML::Pipeline.new filters, context
pipeline.setup_instrumentation

input = <<-EOS
= Sample Document
Author Name

Preamble paragraph.

== Sample Section

Section content.

.GitHub usernames
- @jch
- @rtomayko
- @mojavelinux

[source,ruby]
--
require 'asciidoctor'

puts Asciidoctor.convert('This filter brought to you by http://asciidoctor.org[Asciidoctor].')
--

See <<Sample Section>>.

[normal]
 :ship: 

* [ ] todo
* [x] done
EOS

puts <<-EOS
<!DOCTYPE html>
<html>
<head>
<link crossorigin="anonymous" href="https://assets-cdn.github.com/assets/github-4b3a5bbd58771cb35e8ab63d46cf27dbc5c339d72b3db8553f131c9efa8618af.css" integrity="sha256-SzpbvVh3HLNeirY9Rs8n28XDOdcrPbhVPxMcnvqGGK8=" media="all" rel="stylesheet">
<link crossorigin="anonymous" href="https://assets-cdn.github.com/assets/github2-00a8be553371a21678bd88362a07c328eda1b6f1a38d00f799b6bb3b99198706.css" integrity="sha256-AKi+VTNxohZ4vYg2KgfDKO2htvGjjQD3mba7O5kZhwY=" media="all" rel="stylesheet">
</head>
<body>
<div id="readme">
<article class="markdown-body entry-content">
#{pipeline.call(input)[:output]}
</article>
</div>
</body>
</html>
EOS
