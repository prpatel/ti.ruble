require 'ruble'

bundle do |bundle|
  bundle.display_name = 'ti.ruble'
  bundle.author = 'Pratik Patel'
  bundle.copyright = <<END
(c) Copyright 2011 mypatelspace.com
Distributed under APL2 license.
END

bundle.description = <<END
This Ruble is to be used in Titanium Studio. The purpose of this Ruble is to 
make developing Titanium Mobile applications faster. This package offers several functions:
1) A REPL for a running Titanium iOS simulator or Android emulator.
2) Dynamic code update or insertion
3) Code completions and accelerators for a single-context Titanium Mobile project
END

  # uncomment with the url to the git repo if one exists
bundle.repository = 'git@github.com:prpatel/ti.ruble.git'

  # Use Commands > Bundle Development > Insert Bundle Section > Menu
  # to easily add new sections
  bundle.menu 'ti.ruble' do |menu|
    menu.command 'Invoke REPL'
    menu.command 'TEST REPL'
    menu.command 'Show commands'
    menu.separator
    menu.menu 'Configure ti.ruble' do |sub_menu|
        sub_menu.command 'Set'
    end
  end
end