coreo_agent_selector_rule 'check-php' do
    action :define
    timeout 30
    control 'check-php' do
        describe command('php') do
            it { should exist }
        end
    end
end

coreo_agent_audit_profile 'php-baseline' do
    action :define
    selectors ['check-php']
    profile 'https://github.com/dev-sec/php-baseline/archive/master.zip'
    timeout 120
end

coreo_agent_rule_runner 'audit-php-profiles' do
    action :run
    profiles ${AUDIT_PHP_PROFILES_ALERT_LIST}
    filter(${FILTERED_OBJECTS}) if ${FILTERED_OBJECTS}
end
  