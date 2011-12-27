require 'ruble'
require 'repl'


command 'Invoke REPL' do |cmd|
  cmd.key_binding = 'SHIFT+CTRL+A' # uncomment for a key binding
  cmd.scope = 'source'
  cmd.output = :show_as_tooltip
  cmd.input = :selection, :word
  cmd.invoke do |context|
    word = $stdin.gets
    repl = Repl.new
    repl.change_window_color('green')
   # context.exit_discard if word.nil? # exit if the selection is null
   # print word.swapcase
  end
end

# Use Commands > Bundle Development > Insert Bundle Section > Command
# to easily add new commands