require 'etc'

Etc.passwd do |pw|
  user = pw.name.gsub(/[^a-zA-Z0-9_]/, '')
  homedir = pw.dir
  key = false

  if File.exists?("#{homedir}/.ssh/rsnapshot.rsa.pub")
    key = IO.read("#{homedir}/.ssh/rsnapshot.rsa.pub")
  end

  if key
    Facter.add("sshpubkey_rsnapshot") do
      setcode do
        key
      end
    end
  end
end
