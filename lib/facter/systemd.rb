# Fact: systemd
#
# Purpose:
#   Determine whether systemd is the init system on the node
#
# Resolution:
#   Check if the service_provider fact is systemd
#
# Caveats:
#   If you override the service provider then it will return false, even if the
#   underlying system still is systemd.
#
Facter.add(:systemd) do
  confine :kernel => :linux
  setcode do
    Facter.value(:service_provider) == 'systemd'
  end
end
