module NounProjectApi
  class ServiceError < StandardError
    attr_reader :status, :body

    def initialize(status, body)
      @status = status
      @body = body

      super("Noun Project API Error")
    end
  end
end
