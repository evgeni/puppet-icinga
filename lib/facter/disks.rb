Facter.add(:disks) do
  confine :kernel => :linux
  setcode do
    disks = []
    Dir.glob("/sys/block/*/device").each do |d|
      d = d.split('/')[3]
      if File.open('/sys/block/%s/removable' % d).readline.strip == '0'
        disks.push(d)
      end
    end
    disks.sort.uniq.join(',')
  end
end
