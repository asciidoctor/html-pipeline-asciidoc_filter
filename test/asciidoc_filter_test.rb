require 'test_helper'
require 'html/pipeline/asciidoc_filter'

class HTML::Pipeline::AsciiDocFilterTest < Minitest::Test

  AsciiDocFilter = HTML::Pipeline::AsciiDocFilter

  def setup
    @doctitle_example = <<-EOS
= Sample Document
Author Name

Paragraph in preamble

== Sample Section

Paragraph in section
    EOS

    @hidden_doctitle_example = <<-EOS
= Sample Document
Author Name
:showtitle!:

Paragraph content
    EOS

    @duplicate_heading_example = <<-EOS
= Sample Document

== Section Heading

content

== Section Heading

content
    EOS

    @source_code_example = <<-EOS
```ruby
def hello()
  'world'
end
```
    EOS

    @checklist_example = <<-EOS
* [ ] todo
* [x] done
    EOS

    @compatibility_example = <<-EOS
`monospaced`

+{empty}+

`+{blank}+`
    EOS
  end

  def test_for_document_structure
    result = {}
    AsciiDocPipeline.call(@doctitle_example, {}, result)
    output = result[:output]
    assert_equal 1, output.css('h1').size
    assert_equal 1, output.css('h2').size
    assert_equal 2, output.css('p').size
  end

  def test_for_document_title
    doc = AsciiDocFilter.to_document(@doctitle_example)
    assert doc.kind_of?(HTML::Pipeline::DocumentFragment)
    assert_equal 1, doc.css('h1').size
    assert_equal 1, doc.css('#preamble p').size
    assert_equal 1, doc.css('h2#sample-section').size
  end

  def test_for_hidden_document_title
    doc = AsciiDocFilter.to_document(@hidden_doctitle_example)
    assert doc.kind_of?(HTML::Pipeline::DocumentFragment)
    assert_equal 0, doc.css('h1').size
    assert_equal 1, doc.css('.paragraph p').size
  end

  def test_for_id_deduplication_count
    doc = AsciiDocFilter.to_document(@duplicate_heading_example)
    assert doc.kind_of?(HTML::Pipeline::DocumentFragment)
    assert_equal 1, doc.css('h2#section-heading').size
    assert_equal 1, doc.css('h2#section-heading-1').size
    assert_equal 0, doc.css('h2#section-heading-2').size
  end

  def test_for_lang_attribute_on_source_code_block
    doc = AsciiDocFilter.to_document(@source_code_example)
    assert doc.kind_of?(HTML::Pipeline::DocumentFragment)
    assert_equal 1, doc.search('pre').size
    assert_equal 'ruby', doc.search('pre').first['lang']
  end
  
  AsciiDocPipeline =
    HTML::Pipeline.new [
      HTML::Pipeline::AsciiDocFilter,
      HTML::Pipeline::SanitizationFilter,
      HTML::Pipeline::SyntaxHighlightFilter
    ]
  AsciiDocPipeline.setup_instrumentation

  def test_syntax_highlighting
    result = {}
    AsciiDocPipeline.call(@source_code_example, {}, result)
    assert_equal_html %(<div>
<div>
<div class="highlight highlight-ruby">
<pre><span class="k">def</span> <span class="nf">hello</span><span class="p">()</span>
  <span class="s1">'world'</span>
<span class="k">end</span></pre>
</div>
</div>
</div>), result[:output].to_s
  end

  def test_for_checklist_markers
    result = {}
    AsciiDocPipeline.call(@checklist_example, {}, result)
    fragment = result[:output]
    assert fragment.kind_of?(HTML::Pipeline::DocumentFragment)
    output = fragment.to_s
    assert output.include?(%(#{entity 10063} todo))
    assert output.include?(%(#{entity 10003} done))
  end

  def test_for_compat_mode_off_by_default
    doc = AsciiDocFilter.to_document(@compatibility_example)
    assert doc.kind_of?(HTML::Pipeline::DocumentFragment)
    assert_equal 2, doc.css('code').size
    assert_equal 'monospaced', doc.css('code')[0].text
    assert_equal '{blank}', doc.css('code')[1].text
    assert_equal '{empty}', doc.css('p')[1].text
  end

  def entity(number)
    [number].pack('U*')
  end
end
