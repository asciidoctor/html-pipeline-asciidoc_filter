require 'html/pipeline'
require_relative '../lib/html/pipeline/asciidoc_filter'

filters = [
  HTML::Pipeline::AsciiDocFilter,
  HTML::Pipeline::SanitizationFilter,
  HTML::Pipeline::ImageMaxWidthFilter,
  HTML::Pipeline::EmojiFilter,
  HTML::Pipeline::MentionFilter,
  HTML::Pipeline::AutolinkFilter,
  HTML::Pipeline::TableOfContentsFilter,
  HTML::Pipeline::SyntaxHighlightFilter
]

context = {
  :asset_root => 'https://github.global.ssl.fastly.net/images/icons/emoji'
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

puts Asciidoctor.render('This filter brought to you by http://asciidoctor.org[Asciidoctor].')
--

:shipit: 
EOS

puts pipeline.call(input)[:output]
