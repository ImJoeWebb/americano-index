defmodule Storage.CleanCase do
  use ExUnit.CaseTemplate


  setup context do
    storage_name = "#{context.case}#{context.test}" |> String.to_atom
    Storage.Agent.start_link(name: storage_name)
    Registry.register(:storage_names, self(), storage_name)

    %{storage_name: storage_name}
  end
end
