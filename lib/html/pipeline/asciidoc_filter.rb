require 'asciidoctor'
require 'html/pipeline/filter'
require 'html/pipeline/text_filter'

Asciidoctor::Compliance.unique_id_start_index = 1

class HTML::Pipeline
  # HTML Filter that converts AsciiDoc text into HTML.
  #
  # This filter is different from most in that it can take a non-HTML as
  # input. It must be used as the first filter in a pipeline.
  #
  # This filter does not write any additional information to the context hash.
  #
  # Examples
  #
  #   require 'html/pipeline'
  #   require 'html/pipeline/asciidoc_filter'
  #
  #   filters = [
  #     HTML::PipelineExt::AsciiDocFilter,
  #     HTML::Pipeline::SanitizationFilter,
  #     HTML::Pipeline::ImageMaxWidthFilter,
  #     HTML::Pipeline::EmojiFilter,
  #     HTML::Pipeline::MentionFilter,
  #     HTML::Pipeline::AutolinkFilter,
  #     HTML::Pipeline::TableOfContentsFilter,
  #     HTML::Pipeline::SyntaxHighlightFilter
  #   ]
  #
  #   context = {
  #     :asset_root => 'https://github.global.ssl.fastly.net/images/icons/emoji'
  #   }
  #
  #   pipeline = HTML::Pipeline.new filters, context
  #   pipeline.setup_instrumentation
  #
  #   input = <<EOS
  #   = Sample Document
  #   Author Name
  #
  #   Preamble paragraph.
  #
  #   == Sample Section
  #
  #   Section content.
  #
  #   .GitHub usernames
  #   - @jch
  #   - @jm
  #   - @mojavelinux
  #
  #   [source,ruby]
  #   --
  #   require 'asciidoctor'
  #   puts Asciidoctor.convert('This filter brought to you by http://asciidoctor.org[Asciidoctor].')
  #   --
  #
  #   :shipit: 
  #   EOS
  #
  #   puts pipeline.call(input)[:output]
  #
  class AsciiDocFilter < TextFilter
    def initialize(text, context = nil, result = nil)
      super text, context, result
    end
  
    # Convert AsciiDoc to HTML using Asciidoctor
    def call
      Asciidoctor.convert @text, :safe => :secure, :attributes => %w(showtitle=@ idprefix= idseparator=- env=github env-github source-highlighter=html-pipeline)
    end
  end
end
