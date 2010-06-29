class FakeDocument
  def initialize(string, tab_width, soft_tabs)
    @string = string
    @tab_width, @soft_tab = tab_width, soft_tabs
  end
  
  def get_line(ix)
    lines[ix] + "\n"
  end
  
  def lines
    @string.split("\n")
  end
  
  def indentation
    Document::Indentation.new(self, @tab_width, @soft_tabs)
  end
end