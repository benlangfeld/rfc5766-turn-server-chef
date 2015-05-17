# Encoding: utf-8

require_relative 'spec_helper'

describe 'default' do
  describe service('rfc5766-turn-server') do
    it { should be_enabled }
    it { should be_running }
  end

  describe user('turnserver') do
    it { should exist }
  end

  # STUN
  describe port('3478') do
    it { should be_listening.with('tcp') }
    it { should be_listening.with('udp') }
  end
end
