RSpec.describe Api::V1::Comment::Operation::Index do
  describe '#call' do
    let(:user) { create(:user) }
    let(:task) { create(:task, project: create(:project, user: user), comments: create_list(:comment, 3)) }

    context 'when params is valid' do
      let(:comment_params) { { task_id: task.id } }

      it 'success' do
        expect(described_class.call(params: comment_params, current_user: user)).to be_success
      end
    end

    context 'when user does not own task' do
      let(:comment_params) { { task_id: create(:task).id } }

      it 'returns policy error' do
        expect(described_class.call(params: comment_params, current_user: user)['result.policy.default']).to be_failure
      end
    end
  end
end