# Prompt
Import-Module posh-git
oh-my-posh init pwsh --config "$HOME\.config\omp\.mytheme.omp.json" | Invoke-Expression

# Terminal-Icons
Import-Module -Name Terminal-Icons

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Chord 'Ctrl+k' -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord 'Ctrl+j' -Function HistorySearchForward
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function RevertLine

# Fzf
Import-Module PSFzf
Set-PSFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadLineChordReverseHistory 'Ctrl+r'

# Alias
Set-Alias vim nvim
Set-Alias grep findstr
Set-Alias ll ls
Set-Alias g git
Set-Alias mkdir New-Dir
Set-Alias tig 'C:Program Files\Git\usr\bin\tig.exe'

# Functions
function Get-RPT {
    cls
    cd "C:\Users\seneca\AppData\Local\Arma 3"
    $a=gci -Path "$(Get-Location)\*" -Include *.rpt|sort LastAccessTime -Desc|select -f 1;$host.UI.RawUI.WindowTitle=$a.FullName
    gc $a.FullName -Tail 10 -Wait
}

function Get-Log {
    cls
    $a=gci -Path "$(Get-Location)\*" -Include *.txt ,*.log |sort LastAccessTime -Desc|select -f 1;$host.UI.RawUI.WindowTitle=$a.FullName
    gc $a.FullName -Tail 10 -Wait
}

function New-Dir {
    Param(
        [Parameter(Mandatory=$true)]
        [string[]]
        $dirs
    )
    process {
        forEach ( $dir in $dirs )
        {
            New-Item -Name $dir -ItemType directory
        }
    }
}

# rg.exe
function grep {
    $count = @($input).Count
    $input.Reset()

    if ($count) {
        $input | rg.exe --hidden $args
    }
    else {
        rg.exe --hidden $args
    }
}

# Dotfiles
$DOTFILES = "$HOME\.dotfiles"

function dotfiles {
  git --git-dir="$DOTFILES" --work-tree="$HOME" @Args
}

function dotfiles-restore {
  Param ([string]$repo)
  git clone -b base --bare $repo $DOTFILES
  dotfiles config --local status.showUntrackedFiles no
  dotfiles checkout
  if ($LASTEXITCODE) {
    echo "Deal with conflicting files, then run (possibly with -f flag if you are OK with overwriting)"
    echo "dotiles checkout"
  }
}

# rg.exe
function grep {
    $count = @($input).Count
    $input.Reset()

    if ($count) {
        $input | rg.exe --hidden $args
    }
    else {
        rg.exe --hidden $args
    }
}
