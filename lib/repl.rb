require 'net/telnet'
require 'base64'

require 'json'


class Repl
  attr_reader :remote_connection
  def initialize()
    @remote_connection = Net::Telnet::new('Host' => 'localhost', 'Port' => 5061, 'Telnetmode' => true, 'Prompt' => /REPL> /)
  end

=begin
  TiREPL protocol

  /q or /quit Kill the current session and disconnect
  /session_id Get the unique session_id for this active session

  /message <base64 encoded JSON message object>
  “session-id” - Id of session this message belongs to.
  “id” Id of this message. Incremental id unique to this session.
  “type” Message type of this message. Currently there is only eval_src
  “src” The javascript source we want eval’d on the remote mobile device

  /message_response <base64 encoded JSON message object>
  “session-id” Id of session this message belongs to.
  “id” Id of the message being replied to.
  “type” Message type of this message. Currently there is only eval_response
  “status” status code for this evaluation, either ok or error
  “result” resulting object or exception object of the remote evaluation
=end

# this is just test code, guts will be used to pop open a window and get a real REPL directly from TiStudio
  def change_window_color(color)
    @remote_connection.cmd('/session_id')
    session_id = @remote_connection.cmd('/session_id').split(/\s+/)[1]

    puts "got session_id: #{session_id}"
    src = "win1.backgroundColor = '#{color}';"
    message_request = {:'session-id' => session_id, :id => 1, :type => 'eval_src', :src => src}
    # titanium.cmd(Base64.encode64(message_request.to_json)) do |c|
    # size += c.size
    # puts "Read #{c.size} bytes; total #{size}"
    # end
    puts "sending following to running Titanium App on port 5061: #{message_request.to_json}\n"
    result = @remote_connection.cmd("/message #{Base64.encode64(message_request.to_json)}").split(/\s+/)[1]
    # puts "received this raw data back: #{result}"
    puts "received this data back Base64 decoded: #{Base64.decode64(result)}"
  end

  def sendJS(jsString)
    @remote_connection.cmd('/session_id')
    session_id = @remote_connection.cmd('/session_id').split(/\s+/)[1]

    puts "got session_id: #{session_id}"
    src = jsString;
    message_request = {:'session-id' => session_id, :id => 1, :type => 'eval_src', :src => src}
    # titanium.cmd(Base64.encode64(message_request.to_json)) do |c|
    # size += c.size
    # puts "Read #{c.size} bytes; total #{size}"
    # end
    puts "sending following to running Titanium App on port 5061: #{message_request.to_json}\n"
    result = @remote_connection.cmd("/message #{Base64.encode64(message_request.to_json)}").split(/\s+/)[1]
    # puts "received this raw data back: #{result}"
    puts "received this data back Base64 decoded: #{Base64.decode64(result)}"
    return Base64.decode64(result)
  end  
end