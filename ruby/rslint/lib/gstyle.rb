require 'main'

Main {

  argument('filename') {
    description "The filename to be parsed."
  }

  option('meta') {
    default false
    description "Check for metaprogramming violations.  Defaults to false."
  }

  def run
    nil
  end

}
