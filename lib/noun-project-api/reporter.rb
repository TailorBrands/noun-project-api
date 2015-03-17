module NounProjectApi
  # Main class to hold reporting actions back to the Noun Project.
  class Reporter
    include Connection

    API_PATH = '/notify/publish'

    def report_used(ids)
      ids = [ids] if ids.is_a?(String) || ids.is_a?(Fixnum)
      fail(ArgumentError, 'Missing ids') if ids.nil? || ids.empty?

      result = access_token.post("#{API_BASE}#{API_PATH}", icons: ids.join(','))
      result.code == '200'
    end
  end
end
