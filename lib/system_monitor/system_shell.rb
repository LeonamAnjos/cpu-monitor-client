#encoding: UTF-8

module SystemShell

  def self.execute(command)
    %x[#{command}]
  end
end