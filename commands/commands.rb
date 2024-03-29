require 'ruble'
require 'repl'

@last_invoked_js = ''
@repl = Repl.new
command "Invoke REPL" do |cmd|
    cmd.key_binding = 'SHIFT+CTRL+A' # uncomment for a key binding
    cmd.invoke do |context|
      #Ruble::UI.alert(:info, 'Title', 'Message')
      #result =  Ruble::UI.request_string()
      require('multi_line_editor')
      help_text = 'Enter in JavaScript to execute in the simulator/emulator'
      selectedText = context.editor.selection
      CONSOLE.puts selectedText
      dialog = MultiInputDialog.new(org.eclipse.swt.widgets.Display.current.active_shell, 'Titanium REPL', help_text, selectedText.text, nil)
      return_value = dialog.value if dialog.open == org.eclipse.jface.window.Window::OK
      if return_value != ''
        @last_invoked_js = return_value
        context.exit_show_tool_tip('Result: ' + @repl.sendJS(return_value))
        # CONSOLE.puts (return_value)
      end
  end
end

command 'TEST REPL' do |cmd|
  cmd.scope = 'source'
  cmd.output = :show_as_tooltip
  cmd.input = :selection, :word
  cmd.invoke do |context|
    word = $stdin.gets

    repl.sendJS('win2.backgroundColor = \'green\'')
   # context.exit_discard if word.nil? # exit if the selection is null
   # print word.swapcase
  end
end

command "Run Last" do |cmd|
    cmd.key_binding = 'SHIFT+CTRL+Z' # uncomment for a key binding
    cmd.invoke do |context|
      #Ruble::UI.alert(:info, 'Title', 'Message')
      #result =  Ruble::UI.request_string()
      return_value = @last_invoked_js
      CONSOLE.puts return_value
      if return_value != ''
        context.exit_show_tool_tip('Result: ' + @repl.sendJS(return_value))
        # CONSOLE.puts (return_value)
      else
        context.exit_show_tool_tip('No last REPL command to run')
      end
  end
end


# Use Commands > Bundle Development > Insert Bundle Section > Command
# to easily add new commands