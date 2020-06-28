require "spec_helper"

RSpec.describe NounProjectApi::Reporter do
  it "raises an error when initialized without token" do
    expect { NounProjectApi::Reporter.new(nil, Faker::Internet.password(min_length: 16)) }.to raise_error(ArgumentError)
  end

  it "raises an error when initialized without secret" do
    expect { NounProjectApi::Reporter.new(Faker::Internet.password(min_length: 16), nil) }.to raise_error(ArgumentError)
  end

  it "initializes the values properly" do
    token = Faker::Internet.password(min_length: 16)
    secret = Faker::Internet.password(min_length: 16)
    reporter = NounProjectApi::Reporter.new(token, secret)

    expect(reporter.token).to eq(token)
    expect(reporter.secret).to eq(secret)
  end

  context "reports ids usage" do
    before :each do
      token = Faker::Internet.password(min_length: 16)
      secret = Faker::Internet.password(min_length: 16)
      @reporter = NounProjectApi::Reporter.new(token, secret)
    end

    it "reports a singular id" do
      valid_response = OpenStruct.new(
        body: Fakes::Results::REPORTED_ONE,
        code: "200"
      )

      id = 122

      expect(@reporter.access_token).to receive(
        :post
      ).with(
        "#{NounProjectApi::API_BASE}#{NounProjectApi::Reporter::API_PATH}",
        { icons: id.to_s }.to_json,
        "Accept" => "application/json", "Content-Type" => "application/json"
      ).and_return(
        valid_response
      )

      result = @reporter.report_used(id)
      expect(result).to be true
    end

    it "reports a singular id for a string" do
      valid_response = OpenStruct.new(
        body: Fakes::Results::REPORTED_ONE,
        code: "200"
      )

      id = "122"

      expect(@reporter.access_token).to receive(
        :post
      ).with(
        "#{NounProjectApi::API_BASE}#{NounProjectApi::Reporter::API_PATH}",
        { icons: id }.to_json,
        "Accept" => "application/json", "Content-Type" => "application/json"
      ).and_return(
        valid_response
      )

      result = @reporter.report_used(id)
      expect(result).to be true
    end



    it "reports multiple ids" do
      valid_response = OpenStruct.new(
        body: Fakes::Results::REPORTED_ONE,
        code: "200"
      )

      ids = [122, 4541, 342_11, 4352]

      expect(@reporter.access_token).to receive(
        :post
      ).with(
        "#{NounProjectApi::API_BASE}#{NounProjectApi::Reporter::API_PATH}",
        { icons: ids.join(",") }.to_json,
        "Accept" => "application/json", "Content-Type" => "application/json"
      ).and_return(
        valid_response
      )

      result = @reporter.report_used(ids)
      expect(result).to be true
    end
  end
end
