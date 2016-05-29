#encoding: UTF-8
os = RUBY_PLATFORM

if os.include? 'linux'
  require 'system_monitor/linux'
else
  raise 'Unsupported OS! Only Linux Operating System is supported.'
end
