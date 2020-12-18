require 'station'

describe Station do
  subject {described_class.new("Croydon", 5)}

  it 'knows its name' do
   expect(subject.name).to eq("Croydon")
  end

  it 'knows its zone' do
    expect(subject.zone).to eq(5)
  end
end