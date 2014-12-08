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
EOS

puts <<-EOS
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://assets-cdn.github.com/assets/github-2a88a7bf0ff1b660d7ff29c3220a68751650b37fc53d40d3a7068e835fd213ec.css">
<link rel="stylesheet" href="https://assets-cdn.github.com/assets/github2-ee4170e0122d252766e3edc8c97b6cc6ae381c974013b5047ed5ad8895c56fe0.css">
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
