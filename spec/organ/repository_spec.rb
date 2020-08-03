# frozen_string_literal: true

RSpec.describe 'Organ::EntityAccessRule' do
  before { setup_database }
  after { teardown_database }

  class TeamRepository
    include Organ::Repository
    ENTITY_CLASS = 'Team'
  end

  let(:repository) { TeamRepository.new }

  describe '#save' do
    subject { repository.save(user, entity) }

    let(:entity) { create(:team, owner: user) }
    let(:ou) { create(:organization_unit, parent: parent) }
    let(:parent) { create(:organization_unit) }
    let(:user) { create(:user, organization_unit: ou, roles: roles) }
    let(:roles) { [create(:role, entity_privileges: entity_privileges)] }
    let(:entity_privileges) { [create(:entity_privilege, :basic, entity_name: 'Team')] }

    it { expect { subject }.not_to raise_error }
  end

  describe '#destroy' do
    subject { repository.destroy(user, entity) }

    let(:entity) { create(:team, owner: user) }
    let(:ou) { create(:organization_unit, parent: parent) }
    let(:parent) { create(:organization_unit) }
    let(:user) { create(:user, organization_unit: ou, roles: roles) }
    let(:roles) { [create(:role, entity_privileges: entity_privileges)] }
    let(:entity_privileges) { [create(:entity_privilege, :basic, entity_name: 'Team')] }

    it { expect { subject }.not_to raise_error }
  end

  describe '#find' do
    subject { repository.find(user, Organ::Team, entity.id) }

    let(:entity) { create(:team, owner: user) }
    let(:entity2) { create(:team, owner: user) }
    let(:ou) { create(:organization_unit, parent: parent) }
    let(:parent) { create(:organization_unit) }
    let(:user) { create(:user, organization_unit: ou, roles: roles) }
    let(:roles) { [create(:role, entity_privileges: entity_privileges)] }
    let(:entity_privileges) { [create(:entity_privilege, :basic, entity_name: 'Team')] }

    before do
      entity
      entity2
    end
    it { is_expected.to eq entity }
  end

  describe '#find_by' do
    subject { repository.find_by(user, Organ::Team, { name: 'team2' }) }

    let(:entity) { create(:team, name: 'team1', owner: user) }
    let(:entity2) { create(:team, name: 'team2', owner: user) }
    let(:ou) { create(:organization_unit, parent: parent) }
    let(:parent) { create(:organization_unit) }
    let(:user) { create(:user, organization_unit: ou, roles: roles) }
    let(:roles) { [create(:role, entity_privileges: entity_privileges)] }
    let(:entity_privileges) { [create(:entity_privilege, :basic, entity_name: 'Team')] }

    before do
      entity
      entity2
    end
    it { is_expected.to eq entity2 }
  end

  describe '#select' do
    subject { repository.select(user, Organ::Team) }

    let(:entity) { create(:team, name: 'team1', owner: user) }
    let(:entity2) { create(:team, name: 'team2', owner: user) }
    let(:ou) { create(:organization_unit, parent: parent) }
    let(:parent) { create(:organization_unit) }
    let(:user) { create(:user, organization_unit: ou, roles: roles) }
    let(:roles) { [create(:role, entity_privileges: entity_privileges)] }
    let(:entity_privileges) { [create(:entity_privilege, :basic, entity_name: 'Team')] }

    before do
      entity
      entity2
    end
    it { is_expected.to eq [entity, entity2] }
  end
end
