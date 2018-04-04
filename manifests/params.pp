class iptables::params
{
  case $::osfamily
  {
    'redhat' :
    {
      $iptablesrulesetfile_ipv4 = '/etc/sysconfig/iptables'
      $iptablesrulesetfile_ipv6 = undef
      $iptables_servicename = 'iptables'

      $service_ensure_default = 'running'
      $service_enable_default = true
      case $::operatingsystemrelease
      {
        /^5.*$/:
        {
          $iptables_pkgs = [ 'iptables' ]
        }
        /^6.*$/:
        {
          $iptables_pkgs = [ 'iptables' ]
        }
        /^7.*$/:
        {
          $iptables_pkgs = [ 'iptables', 'iptables-services' ]
        }
        default:
        {
          fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")
        }
      }
    }
    'Debian':
    {
      $iptablesrulesetfile_ipv4 = '/etc/iptables/rules.v4'
      $iptablesrulesetfile_ipv6 = '/etc/iptables/rules.v6'

      $service_ensure_default = 'running'
      $service_enable_default = true
      case $::operatingsystem
      {
        'Ubuntu':
        {
          $iptables_pkgs = [ 'iptables', 'iptables-persistent' ]
          case $::operatingsystemrelease
          {
            /^14.*$/:
            {
              $iptables_servicename = 'iptables-persistent'
            }
            /^16.*$/:
            {
              $iptables_servicename = 'netfilter-persistent'
            }
            default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
          }
        }
        'Debian': { fail('Unsupported')  }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    'Suse':
    {
      $iptablesrulesetfile_ipv4 = undef
      $iptablesrulesetfile_ipv6 = undef
      $iptables_servicename = 'SuSEfirewall2_setup'

      $service_ensure_default = 'stopped'
      $service_enable_default = false
      case $::operatingsystem
      {
        'SLES':
        {
          case $::operatingsystemrelease
          {
            '11.3':
            {
              $iptables_pkgs = [ 'iptables' ]
            }
            default: { fail("Unsupported operating system ${::operatingsystem} ${::operatingsystemrelease}") }
          }
        }
        default: { fail("Unsupported operating system ${::operatingsystem}") }
      }
    }
    default:
    {
      fail('Unsupported OS!')
    }
  }
}
