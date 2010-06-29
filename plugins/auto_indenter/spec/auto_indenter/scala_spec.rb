require File.join(File.dirname(__FILE__), "..", "spec_helper")
require File.join(File.dirname(__FILE__), "fake_document")

include Redcar

describe AutoIndenter::Analyzer do
  
  scala = File.open(File.join(File.dirname(__FILE__), "sample.scala"), "r").read
  
  def should_indent(src, options)
    simple_rules = AutoIndenter::Rules.new(
    /^.*\{[^}"']*$|^\s*(def|class|object|trait|val|var|private|protected):\s*$/, 
    /^(.*\*\/)?\s*\}([^}{"']*\{)?[;\s]*(\/\/.*|\/\*.*\*\/\s*)?$|^\s*(def|class|object|trait|val|var|private|protected):\s*$/, 
    /^(?!(.*[};:])?\s*(\/\/|\/\*.*\*\/\s*$)).*[^\s;:{}]\s*$/
    )
    
    analyzer = AutoIndenter::Analyzer.new(simple_rules, FakeDocument.new(src, 2, false), 2, false)                  
    analyzer.calculate_for_line(options[:line]).should == options[:indent]
  end

  describe "with Scala's real indentation rules loaded" do
    it "should indent correctly after curly braces" do
      should_indent(scala, :line => 0, :indent => 0)
      should_indent(scala, :line => 1, :indent => 0)
      should_indent(scala, :line => 7, :indent => 2)
      should_indent(scala, :line => 9, :indent => 2)
      should_indent(scala, :line => 10, :indent => 3)
      
      # ticket: http://redcar.lighthouseapp.com/projects/25090/tickets/244-indenter-has-trouble-with-scala
      should_indent(scala, :line => 11, :indent => 2)
    end
  end
end