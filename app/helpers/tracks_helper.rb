module TracksHelper
  def ugly_lyrics(lyrics)
    uglified = lyrics.to_s.split("\n").map do |line|
      "&#9835 #{h(line)}"
    end.join("\n")
    
    <<-HTML.html_safe
      <pre>#{uglified}</pre>
    HTML
  end
end
