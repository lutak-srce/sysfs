require 'spec_helper_acceptance'

describe 'sysfs class' do
  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'works idempotently with no errors' do
      pp = 'include sysfs::base'

      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(%r{error}i)
      end
      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to eq(%r{error}i)
      end
    end

    # do some basic checks
    pkg = 'sysfsutils'
    describe package(pkg) do
      it { is_expected.to be_installed }
    end
  end
end
