# appserver domain directory
describe file('/home/psadm2/appserv/KIT') do
  it { should be_directory }
  its(:owner) { should eq 'psadm2' }
  its(:group) { should eq 'oinstall' }
  its(:mode) { should eq 0755 }
end

# psappsrv.cfg
describe file('/home/psadm2/appserv/KIT/psappsrv.cfg') do
  its(:owner) { should eq 'psadm2' }
  its(:group) { should eq 'oinstall' }
  its(:mode) { should eq 0755 }
  its(:content) { should match(/Allow Dynamic Changes=Y/) }
  its(:content) { should match(/Domain ID=KIT/) }
  its(:content) { should match(/SMTPServer=localhost/) }
  its(:content) { should match(/DBName=KITCHEN/) }
  its(:content) { should match(/DBType=ORACLE/) }
  its(:content) { should match(/UserId=opr_user_id/) }
  its(:content) { should match(%r{UserPswd=jDXqb7hxyNrGCuqEcPo9tyw7jzI8m1jcDo4\/k1iPapc=}) }
  its(:content) { should match(/Add to PATH=/) }
  its(:content) { should match(/ConnectId=connect_id/) }
  its(:content) { should match(/ConnectPswd=gCr2Xqhh2ffaHRLms90uaqsvvSICS1u4RZG4qQx7/) }
  its(:content) { should match(%r{DomainConnectionPwd=hyr1b65tw8a3NZMqDcyjnaR8IbXuJngFVBW5tji\/}) }
end

# psappsrv.ubb
describe file('/home/psadm2/appserv/KIT/psappsrv.ubb') do
  its(:owner) { should eq 'psadm2' }
  its(:group) { should eq 'oinstall' }
  its(:mode) { should eq 0644 }
  its(:content) { should match(/\{PUBSUB\}:\s*FALSE/) }
  its(:content) { should match(/\{QUICKSRV\}:\s*FALSE/) }
  its(:content) { should match(/\{QUERYSRV\}:\s*TRUE/) }
  its(:content) { should match(/\{JOLT\}:\s*TRUE/) }
  its(:content) { should match(/\{JRAD\}:\s*FALSE/) }
  its(:content) { should match(/\{WSL\}:\s*TRUE/) }
  its(:content) { should match(/\{DBGSRV\}:\s*FALSE/) }
  its(:content) { should match(/\{RENSRV\}:\s*FALSE/) }
  its(:content) { should match(/\{MCF\}:\s*FALSE/) }
  its(:content) { should match(/\{PPM\}:\s*FALSE/) }
  its(:content) { should match(/\{ANALYTICSRV\}:\s*FALSE/) }
  its(:content) { should match(/\{DOMAIN_GW\}:\s*FALSE/) }
  its(:content) { should match(/\{SERVER_EVENTS\}:\s*FALSE/) }
end
