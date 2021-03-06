class HTTPMessageParser
  def initialize(content)
    @content = content
  end

  def headers
    parts.first[1..-1].map do |line|
      line.strip.split(/:\s+/)
    end.to_h
  end

  def body
    return '' if parts.length == 1

    parts[1][1..-1].join
  end

  private

  attr_reader :content

  def parts
    lines.slice_before(/\A\s*\z/).to_a
  end

  def lines
    @lines ||= content.split("\n")
  end

  def request_line
    lines[0]
  end
end
