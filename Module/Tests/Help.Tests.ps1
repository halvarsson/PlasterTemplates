$moduleName = '<%= $PLASTER_PARAM_ModuleName %>'

Describe "Public commands have comment-based or external help" -Tags 'Build' {
    $functions = Get-Command -Module $ModuleName
    $help = foreach ($function in $functions) {
        Get-Help -Name $function.Name -Full
    }

    foreach ($node in $help)
    {
        Context $node.Name {
            It "Should have a Description or Synopsis" {
                ($node.Description + $node.Synopsis) | Should Not BeNullOrEmpty
            }

            It "Should have an Example"  {
                $node.Examples | Should Not BeNullOrEmpty
                $node.Examples | Out-String | Should -Match ($node.Name)
            }

            foreach ($parameter in $node.Parameters.Parameter)
            {
                if ($parameter -notmatch 'WhatIf|Confirm')
                {
                    It "Should have a Description for Parameter [$($parameter.Name)]" {
                        $parameter.Description.Text | Should Not BeNullOrEmpty
                    }
                }
            }
        }
    }
}