require 'myers_diff'

RSpec.describe MyersDiff do
  describe '#diff' do
    describe 'a, b' do
      subject { MyersDiff.new.diff('a', 'b') }
      it do
        expect(subject.size).to eq 2
        expect(subject.first[:removed]).to be_truthy
        expect(subject.first[:value]).to eq 'a'
        expect(subject.last[:added]).to be_truthy
        expect(subject.last[:value]).to eq 'b'
      end
    end
    describe 'abcabba cbabac' do
      subject { MyersDiff.new.diff('abcabba', 'cbabac') }
      it do
        expect(subject.size).to eq 8
      end
    end
  end

  describe '#push_component' do
    let(:components) { [ { count: 1, added: true, removed: nil } ] }
    let(:added) { true }
    let(:removed) { nil }
    before { MyersDiff.new.push_component(components, added, removed) }
    context 'when added' do
      it do
        expect(components.last[:count]).to eq 2
      end
    end
    context 'when removed' do
      let(:added) { nil }
      let(:removed) { true }
      it do
        expect(components.size).to eq 2
        expect(components.last[:count]).to eq 1
        expect(components.last[:added]).to eq added
        expect(components.last[:removed]).to eq removed
      end
    end
  end
end
