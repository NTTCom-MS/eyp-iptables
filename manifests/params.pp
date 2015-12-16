class iptables::params
{
  case $::osfamily
  {
    'redhat' :
    {
      case $::operatingsystemrelease
      {
        /^5.*$/ :
        {
        }
        /^6.*$/ :
        {
        }
        default :
        {
          fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")
        }
      }

      # per debian
      # http://systemadmin.es/2014/02/reglas-de-iptables-persistentes-en-debian-ubuntu

    }
    default  :
    {
      fail('Unsupported OS!')
    }
  }
}
