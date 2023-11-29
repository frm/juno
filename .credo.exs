base_checks = [
  {Credo.Check.Design.TagTODO, exit_status: 0},
  {Credo.Check.Design.TagFIXME, exit_status: 0},

  # MaxLineLength is already enforced by formatter
  # credo throws warnings for commented lines, which is just annoying
  {Credo.Check.Readability.MaxLineLength, false},
  {Credo.Check.Readability.ModuleDoc, false},

  # This should be a product of our common sense and detailed in reviews
  {Credo.Check.Refactor.FunctionArity, false},
  {Credo.Check.Refactor.PipeChainStart, false}
]

test_checks = [
  {Credo.Check.Refactor.VariableRebinding, false}
  | base_checks
]

%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["lib/", "src/", "web/", "apps/"],
        excluded: [
          ~r"/node_modules/",
          ~r"/_build/",
          ~r"/deps/",
          ~r/test/,
          ~r/seeds.exs/,
          ~r"telemetry"
        ]
      },
      strict: true,
      color: true,
      checks: base_checks
    },
    %{
      name: "test",
      files: %{
        included: ["test/"],
        excluded: [
          ~r"/_build/",
          ~r"/deps/",
          ~r"lib/",
          ~r"telemetry"
        ]
      },
      strict: true,
      color: true,
      checks: test_checks
    }
  ]
}
