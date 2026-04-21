# frozen_string_literal: true

require 'spec_helper'

describe 'dpkg_autostart' do
  step_into :dpkg_autostart

  context 'on ubuntu' do
    platform 'ubuntu', '24.04'

    context 'with multiple blocked services' do
      recipe do
        dpkg_autostart 'mysql-server' do
          allow false
        end

        dpkg_autostart 'apache2' do
          allow false
        end
      end

      let(:policy_rc_d) { chef_run.template('/usr/sbin/policy-rc.d') }

      it do
        expect(policy_rc_d.cookbook).to eq('dpkg_autostart')
        expect(policy_rc_d.source).to eq('policy-rc.d.erb')
        expect(policy_rc_d.mode).to eq('0755')
      end

      it do
        expect(policy_rc_d.variables).to include(
          disable_actions: %w(restart start),
          disabled_services: %w(apache2 mysql-server)
        )
      end
    end

    context 'when a resource is allowed' do
      recipe do
        dpkg_autostart 'mysql-server' do
          allow false
        end

        dpkg_autostart 'apache2' do
          allow true
        end
      end

      let(:policy_rc_d) { chef_run.template('/usr/sbin/policy-rc.d') }

      it do
        expect(policy_rc_d.variables).to include(
          disabled_services: ['mysql-server']
        )
      end
    end

    context 'with custom disabled actions' do
      recipe do
        dpkg_autostart 'mysql-server' do
          allow false
          disable_actions %w(start restart reload)
        end
      end

      let(:policy_rc_d) { chef_run.template('/usr/sbin/policy-rc.d') }

      it do
        expect(policy_rc_d.variables).to include(
          disable_actions: %w(reload restart start)
        )
      end
    end
  end

  context 'on almalinux' do
    platform 'almalinux', '9'

    recipe do
      dpkg_autostart 'mysql-server' do
        allow false
      end
    end

    it 'does not declare the policy template' do
      templates = chef_run.resource_collection.all_resources.select do |resource|
        resource.resource_name == :template && resource.name == '/usr/sbin/policy-rc.d'
      end

      expect(templates).to be_empty
    end
  end
end
