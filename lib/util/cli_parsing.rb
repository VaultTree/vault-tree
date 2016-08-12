module VaultTree
  module CliParsing

    def parse_action!(vaults, arguments)
      input = {vaults: vaults, arguments: arguments}
      pipe(input, through: [ :output_setup, :json_input, :door_action, :vault_id, :external_input, :extract_output ])
    end

    def display_summary?(vaults, arguments)
      vaults.nil? && arguments.empty?
    end

    def parse_exception!(ex)
      {type: ex.class.to_s , message: ex.message}
    end

    def output_setup(i)
      c = i.clone; c = c.merge({input: '', door_action: '', vault_id: '', external_input: {}}); c;
    end

    def json_input(i)
      pipe(i, through: [:set_json_input])
    end

    def door_action(i)
      pipe(i, through: [:set_door_action, :check_door_action])
    end

    def vault_id(i)
      pipe(i, through: [:set_vault_id, :check_vault_id])
    end

    def external_input(i)
      pipe(i, through: [:remove_ei_pairs, :check_ei_pairs, :set_external_input])
    end

    def extract_output(i)
      c = i.clone; c = c.delete_if {|k,v| [:vaults, :arguments].include?(k)}; c;
    end

    protected

    def remove_ei_pairs(i)
      c = i.clone; c[:ei_pairs] = i[:arguments].slice(2,i.length); c;
    end

    def check_ei_pairs(i)
      i[:ei_pairs].each {|p| assert_valid_string!(p); assert_valid_ei_pair!(p) }; i;
    rescue
      raise 'external input strings must be seperate cli arguments of the form key=value'
    end

    def set_external_input(i)
      c = i.clone; i[:ei_pairs].each do |p|
        key = p.split('=').first
        val = p.split('=').last
        c[:external_input][key] = val
      end
      return c;
    end

    def set_vault_id(i)
      c = i.clone; c[:vault_id] = i[:arguments][1]; c;
    end

    def check_vault_id(i)
      assert_valid_string!(i[:vault_id]); return i;
    rescue
      raise 'must specify a valid vault id'
    end

    def set_json_input(i)
      c = i.clone; c[:input] = i[:vaults]; c;
    end

    def check_door_action(i)
      assert_included!(i[:door_action], ['open','close']); return i;
    rescue
      raise 'must specify vault open or close'
    end

    def set_door_action(i)
      c = i.clone; c[:door_action] = i[:arguments][0]; c;
    end

    def assert_included!(input, list = [])
      raise 'not included in list' unless list.include?(input)
    end

    def assert_valid_string!(input)
      raise 'not a valid string' unless (input.is_a?(String) && !input.empty?)
    end

    def assert_valid_ei_pair!(input)
      unless (input.split('=').is_a?(Array) && input.split('=').length == 2)
        raise 'not a valid external input pair'
      end
    end

    # pipe - express ruby behavior like unix pipes
    #
    # contract:
    #   * each method in the [through] array must take exactly one input argument
    #   * each method must return a value
    #
    # Examples:
    #   pipe(5, through: [ :add_one, :add_two, :subtract_four, :add_ten])
    #      => 14
    #
    #   pipe(5, through: [])
    #      => 5
    #
    # original idea:
    # http://developer.teamsnap.com/blog/2015/02/28/implementing-pipe-in-ruby-part-2/
    def pipe(input, s = {through: []})
      s[:through].each {|mth| input = send(mth, input)}; input;
    end
  end
end
