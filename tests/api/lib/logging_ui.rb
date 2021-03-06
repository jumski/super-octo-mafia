require_relative 'errors'
require_relative 'base_ui'

class LoggingUI < BaseUI
  def step_response_differs(step, diff, _request, _response)
    scenario = step.scenario

    output.print "\r"
    output.puts Paint["- #{scenario.name}", :red]
    output.print '  -> failed on step '
    output.puts Paint[step.name, :yellow]
    output.puts
    output.puts diff.to_s(:color)
    output.puts
  end

  def ask_to_cache(_step, _diff, _request, _response)
    false
  end

  def step_failed(_step)
    output.puts
    output.puts
    raise StepFailed
  end

  def scenario_failed(scenario)
    failed_scenarios.push(scenario)
  end

  def exit_with_status
    status = 0
    status = 1 if failed_scenarios.any?

    exit status
  end
end
