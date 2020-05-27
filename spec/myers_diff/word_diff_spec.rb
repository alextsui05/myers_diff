require 'myers_diff'

RSpec.describe MyersDiff::WordDiff do
  describe '#diff' do
    let(:differ) { described_class.new }
    subject { differ.diff(s1, s2) }

    context "when 'aba' vs 'abc'" do
      let(:s1) { 'aba' }
      let(:s2) { 'abc' }

      it do
        expect(subject.size).to eq(2)
      end
    end

    context "when 'the beginning' vs 'the end'" do
      let(:s1) { 'the beginning' }
      let(:s2) { 'the end' }

      it do
        expect(subject.size).to eq(3)
      end
    end

    context "when 'the beginning of time' vs 'the end of time'" do
      let(:s1) { 'the beginning of time' }
      let(:s2) { 'the end of time' }

      it do
        expect(subject.size).to eq(4)
      end
    end

    context "when 'with accuracy memories' vs 'memories accurately'" do
      let(:s1) { "I don't remember with accuracy memories when I was a child" }
      let(:s2) { "I don't remember memories accurately when I was a child" }

      it do
        expect(subject.size).to eq(5)
      end
    end

    context "when 'cousin' vs 'cousins'" do
      let(:s1) { "I have no cousin." }
      let(:s2) { "I have no cousins." }

      it do
        expect(subject.size).to eq(3)
      end
    end

    context "when 'on my schedule' vs 'at my own pace'" do
      let(:s1) { "I prefer to work alone because I can work on my schedule." }
      let(:s2) { "I prefer to work alone because I can work at my own pace." }

      it do
        expect(subject.size).to eq(6)
      end
    end

    context "when 'I'm able to share on the Internet' vs 'I can share them on the Internet'" do
      let(:s1) { "I'm able to share on the Internet." }
      let(:s2) { "I can share them on the Internet." }

      it do
        expect(subject.size).to eq(5)
      end
    end
  end
end
