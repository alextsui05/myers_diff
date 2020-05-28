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
        expect(subject.size).to eq(9)
        expect(subject[0][:value]).to eq("I don't remember ")
        expect(subject.find { |chunk| chunk[:removed] }[:value]).to eq('with')
        expect(subject.find { |chunk| chunk[:added] }[:value]).to eq('memories')
      end
    end

    context "when 'cousin' vs 'cousins'" do
      let(:s1) { "I have no cousin." }
      let(:s2) { "I have no cousins." }

      it do
        expect(subject.size).to eq(4)
        expect(subject.first[:value]).to eq('I have no ')
        expect(subject.find { |chunk| chunk[:removed] }[:value]).to eq('cousin')
        expect(subject.find { |chunk| chunk[:added] }[:value]).to eq('cousins')
        expect(subject.last[:value]).to eq('.')
      end
    end

    context "when 'on my schedule' vs 'at my own pace'" do
      let(:s1) { "I prefer to work alone because I can work on my schedule." }
      let(:s2) { "I prefer to work alone because I can work at my own pace." }

      it do
        expect(subject.size).to eq(7)
        expect(subject.find { |chunk| chunk[:removed] }[:value]).to eq('on')
        expect(subject.find { |chunk| chunk[:added] }[:value]).to eq('at')
      end
    end

    context "when 'I'm able to share on the Internet' vs 'I can share them on the Internet'" do
      let(:s1) { "I'm able to share on the Internet." }
      let(:s2) { "I can share them on the Internet." }

      it do
        expect(subject.size).to eq(10)
        expect(subject.last[:value]).to eq('on the Internet.')
      end
    end

    context "when 'A miracle' vs 'A (miracle)'" do
      let(:s1) { "A miracle" }
      let(:s2) { "A (miracle)" }

      it do
        expect(subject.find { |chunk| chunk[:added] }[:value]).to eq('(')
      end
    end
  end
end
