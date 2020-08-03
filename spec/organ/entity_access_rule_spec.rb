# frozen_string_literal: true

RSpec.describe 'Organ::EntityAccessRule' do
  before { setup_database }
  after { teardown_database }

  describe '.satisfied_by?' do
    subject { Organ::EntityAccessRule.satisfied_by?(ctx) }

    let(:ctx) { Organ::EntityAccessContext.new(entity, access_type, user) }
    let(:entity) { create(:team, owner: user) }
    let(:access_type) { Organ::AccessRight::READ }
    let(:ou) { create(:organization_unit, parent: parent) }
    let(:parent) { create(:organization_unit) }
    let(:child) { create(:organization_unit, parent: ou) }
    let(:user) { create(:user, organization_unit: ou, roles: roles) }
    let(:roles) { [create(:role, entity_privileges: entity_privileges)] }
    let(:entity_privileges) { [create(:entity_privilege, :basic, entity_name: 'Team')] }

    context 'when user has no role' do
      let(:roles) { [] }

      it { is_expected.to be_falsy }
    end

    context 'when user has no priv' do
      let(:entity_privileges) { [] }

      it { is_expected.to be_falsy }
    end

    context 'when user has priv with basic level' do
      context 'if privilege is valid' do
        it { is_expected.to be_truthy }
      end

      context 'if entity belongs to other user' do
        let(:entity) { create(:team, owner: another) }
        let(:another) { create(:user, organization_unit: ou, roles: roles) }

        it { is_expected.to be_falsy }
      end
    end

    context 'when user has priv with local level' do
      let(:entity_privileges) { [create(:entity_privilege, :local, entity_name: 'Team')] }
      let(:entity) { create(:team, owner: another) }

      context 'if entity belongs to other user in lower organization' do
        let(:another) { create(:user, organization_unit: child, roles: roles) }

        it { is_expected.to be_falsy }
      end

      context 'if entity belongs to other user in same organization' do
        let(:another) { create(:user, organization_unit: ou, roles: roles) }

        it { is_expected.to be_truthy }
      end
    end

    context 'when user has priv with deep level' do
      let(:entity_privileges) { [create(:entity_privilege, :deep, entity_name: 'Team')] }
      let(:entity) { create(:team, owner: another) }

      context 'if entity belongs to other user in lower organization' do
        let(:another) { create(:user, organization_unit: child, roles: roles) }

        it { is_expected.to be_truthy }
      end

      context 'if entity belongs to other user in higher organization' do
        let(:another) { create(:user, organization_unit: parent, roles: roles) }

        it { is_expected.to be_falsy }
      end
    end

    context 'when user has priv with global level' do
      let(:entity_privileges) { [create(:entity_privilege, :global, entity_name: 'Team')] }
      let(:sibling) { create(:organization_unit, parent: parent) }
      let(:entity) { create(:team, owner: another) }

      context 'if entity belongs to other user in higher organization' do
        let(:another) { create(:user, organization_unit: parent, roles: roles) }

        it { is_expected.to be_truthy }
      end

      context 'if entity belongs to other user in sibling organization' do
        let(:another) { create(:user, organization_unit: sibling, roles: roles) }

        it { is_expected.to be_truthy }
      end

      context 'if entity belongs to other user in organization which has differnt root' do
        let(:another) { create(:user, organization_unit: other_ou, roles: roles) }
        let(:other_ou) { create(:organization_unit) }

        it { is_expected.to be_falsy }
      end
    end
  end

  describe '.select_satisfying' do
    subject { Organ::EntityAccessRule.select_satisfying(ctx, Organ::Team.all) }

    let(:ctx) { Organ::EntityAccessQueryContext.new('Team', Organ::AccessRight::READ, user) }
    let(:entity) { create(:team, owner: user) }
    let(:access_type) { Organ::AccessRight::READ }
    let(:ou) { create(:organization_unit, parent: parent) }
    let(:parent) { create(:organization_unit) }
    let(:child) { create(:organization_unit, parent: ou) }
    let(:user) { create(:user, organization_unit: ou, roles: roles) }
    let(:roles) { [create(:role, entity_privileges: entity_privileges)] }
    let(:entity_privileges) { [create(:entity_privilege, :basic, entity_name: 'Team')] }

    before { entity }

    context 'when user has no role' do
      let(:roles) { [] }

      it { is_expected.to be_empty }
    end

    context 'when user has no priv' do
      let(:entity_privileges) { [] }

      it { is_expected.to be_empty }
    end

    context 'when user has priv with basic level' do
      context 'if privilege is valid' do
        it { is_expected.to eq [entity] }
      end

      context 'if entity belongs to other user' do
        let(:entity) { create(:team, owner: another) }
        let(:another) { create(:user, organization_unit: ou, roles: roles) }

        it { is_expected.to be_empty }
      end
    end

    context 'when user has priv with local level' do
      let(:entity_privileges) { [create(:entity_privilege, :local, entity_name: 'Team')] }
      let(:entity) { create(:team, owner: another) }

      context 'if entity belongs to other user in lower organization' do
        let(:another) { create(:user, organization_unit: child, roles: roles) }

        it { is_expected.to be_empty }
      end

      context 'if entity belongs to other user in same organization' do
        let(:another) { create(:user, organization_unit: ou, roles: roles) }

        it { is_expected.to eq [entity] }
      end
    end

    context 'when user has priv with local level' do
      let(:entity_privileges) { [create(:entity_privilege, :local, entity_name: 'Team')] }
      let(:entity) { create(:team, owner: another) }

      context 'if entity belongs to other user in lower organization' do
        let(:another) { create(:user, organization_unit: child, roles: roles) }

        it { is_expected.to be_empty }
      end

      context 'if entity belongs to other user in same organization' do
        let(:another) { create(:user, organization_unit: ou, roles: roles) }

        it { is_expected.to eq [entity] }
      end
    end

    context 'when user has priv with deep level' do
      let(:entity_privileges) { [create(:entity_privilege, :deep, entity_name: 'Team')] }
      let(:entity) { create(:team, owner: another) }

      context 'if entity belongs to other user in lower organization' do
        let(:another) { create(:user, organization_unit: child, roles: roles) }

        it { is_expected.to eq [entity] }
      end

      context 'if entity belongs to other user in higher organization' do
        let(:another) { create(:user, organization_unit: parent, roles: roles) }

        it { is_expected.to be_empty }
      end
    end

    context 'when user has priv with global level' do
      let(:entity_privileges) { [create(:entity_privilege, :global, entity_name: 'Team')] }
      let(:sibling) { create(:organization_unit, parent: parent) }
      let(:entity) { create(:team, owner: another) }

      context 'if entity belongs to other user in higher organization' do
        let(:another) { create(:user, organization_unit: parent, roles: roles) }

        it { is_expected.to eq [entity] }
      end

      context 'if entity belongs to other user in sibling organization' do
        let(:another) { create(:user, organization_unit: sibling, roles: roles) }

        it { is_expected.to eq [entity] }
      end

      context 'if entity belongs to other user in organization which has differnt root' do
        let(:another) { create(:user, organization_unit: other_ou, roles: roles) }
        let(:other_ou) { create(:organization_unit) }

        it { is_expected.to be_empty }
      end
    end
  end
end
