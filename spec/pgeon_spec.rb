require "pgeon"

describe Pgeon do
  context "connecting to the database" do
    let(:database_adapter) { double("database adapter").as_null_object }

    def config options
      Pgeon.config do |config|
        options.each do |param, value|
          config.send "#{param}=", value
        end
      end
    end

    def fly_pigeon dependency_injections
      Pgeon.fly dependency_injections
      Pgeon.land
    end

    it "should connect to the given host" do
      host = random_string
      config database_host: host

      expect(database_adapter).to receive(:connect).with hash_including host: host

      fly_pigeon database_adapter: database_adapter
    end

    it "should connect to the given database" do
      name = random_string
      config database_name: name

      expect(database_adapter).to receive(:connect).with hash_including dbname: name

      fly_pigeon database_adapter: database_adapter
    end

    it "should disconnect the database on landing" do
      Pgeon.fly database_adapter: database_adapter
      expect(database_adapter).to receive(:close)
      Pgeon.land
    end
  end

  context "context" do

  end
end

def random_string
  [*('a'..'z')].sample(10).join
end
