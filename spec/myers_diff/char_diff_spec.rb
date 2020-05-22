require 'myers_diff'

RSpec.describe MyersDiff::CharDiff do
  describe '#diff' do
    describe 'a, b' do
      subject { described_class.new.diff('a', 'b') }
      it do
        expect(subject.size).to eq 2
        expect(subject.first[:removed]).to be_truthy
        expect(subject.first[:value]).to eq 'a'
        expect(subject.last[:added]).to be_truthy
        expect(subject.last[:value]).to eq 'b'
      end
    end
    describe 'abcabba cbabac' do
      subject { described_class.new.diff('abcabba', 'cbabac') }
      it do
        expect(subject.size).to eq 8
      end
    end
    describe 'abcd bde' do
      subject { described_class.new.diff('abcd', 'bde') }
      it do
        expect(subject.size).to eq 5
      end
    end
    describe 'french' do
      let(:s1) { "Toutefois, ils sont consciemment sûrs que ce n'est pas possible d'être donner les conseils par leur parents à leur propre soucies dont les problèmes sexuels ou sentimentaux: ça se compose la possibilité de blesser leur honneur ou leur privée." }
      let(:s2) { "Toutefois, les jeunes ont généralement conscience du fait qu'ils ne peuvent pas tout partager avec leur parents: Les soucis d'ordre sentimental ou sexuel font partie de leur vie privée et ne sont pas des sujets qu'ils souhaitent aborder dans leur famille." }
      subject { described_class.new.diff(s1, s2) }
      it do
        expect(subject.size).to be_truthy
      end
    end
  end

  describe '#push_component' do
    let(:components) { [ { count: 1, added: true, removed: nil } ] }
    let(:added) { true }
    let(:removed) { nil }
    before { described_class.new.push_component(components, added, removed) }
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
