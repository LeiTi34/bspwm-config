# Defined in - @ line 1
function activemq --wraps='doas /opt/activemq/apache-activemq-5.15.11/bin/linux-x86-64/wrapper' --wraps=/opt/activemq/apache-activemq-5.15.11/bin/linux-x86-64/wrapper --description 'alias activemq doas /opt/activemq/apache-activemq-5.15.11/bin/linux-x86-64/wrapper'
  doas /opt/activemq/apache-activemq-5.15.11/bin/linux-x86-64/wrapper $argv;
end
