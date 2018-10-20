# Import Framework assemblies
try{
    Add-Type -AssemblyName PresentationCore,PresentationFramework,WindowsBase,system.windows.forms 
} catch {
    Throw "Failed to load Windows Presentation Framework assemblies."
}

# Import xaml file
[xml]$Global:xmlWPF = Get-Content -Path "D:\Mathis\Travail\1-GFI\1-Script_NIM\ScriptUI.xaml"

# Create UI object
$Global:xamGUI = [Windows.Markup.XamlReader]::Load((new-object System.Xml.XmlNodeReader $xmlWPF)) 

# Create a variable for each control
$xmlWPF.SelectNodes("//*[@Name]") | %{
    Set-Variable -Name ($_.Name) -Value $xamGUI.FindName($_.Name) -Scope Global 
}


############ EVENT HANDLER ####################



<#$buttonConnect.add_Click({    
    $labelError.Content = ""
    $username = $textBoxUsername.Text
    $password = $textBoxPassword.Text

    if ($username -eq "Admin" -And $password -eq "Admin") {
        $CanvasLogin.Visibility = "Hidden"
        $CanvasUser.Visibility = "Visible"
    } else {
        $labelError.Content = "No user found"
    }
})  #>

<#$buttonServer.add_Click({
    $labelRestart.Content = ""
    $ProgressBar1.Value = 0
    if ($radioButtonServer1.IsChecked) {
        $labelRestart.Content = "Server 1 restarted"
    } else {
        $labelRestart.Content = "Server 2 restarted"
    }
    $ProgressBar1.Value = 100
})#>


$Button_Valider.add_Click({

if ($Radio_adminas.IsChecked) {

$Canvas_Choix.Visibility ="Hidden"
$Canvas_Change_AdminAS.Visibility="Visible"

} 



        

})

$Button_ValiderAdminas.add_Click({


if ([string]::IsNullOrEmpty($passwordbox1.Password)){$Message="Error. Password is empty."}
                        
                        
                        
                        else {
                                if (![string]::IsNullOrEmpty($passwordbox1.Password)){
                                    
                                    
                                    Try {

                                    $AccountPassword = (ConvertTo-SecureString $passwordbox1.Password -AsPlainText -Force)
                                    New-LocalUser -Name test -Password $AccountPassword -ErrorAction Stop
                                    $message="Compte test créé"
                                    
                                        }
                                  
                                  #Connaitre le nom de l'erreur avec la commande suivante :
                                  #--> $error[0].Exception.GetType().FullName
                                  Catch [Microsoft.PowerShell.Commands.AccessDeniedException] {
                                    $Message="Accès refusé"
                                  
                                  }
                                  
                                  
                                  Catch {
                                       
                                        $Message=$_.Exception.message

                                        }
                                    #Set-ADAccountPassword $WPFTextBoxUser.Text -NewPassword $AccountPassword -Reset -PassThru | Set-ADuser -ChangePasswordAtLogon $True
                                                                                       }
                             }
# Affiche le contenu de la variable $message en interface graphique 
[System.Windows.Forms.MessageBox]::Show("$Message")

})


# Display UI object
$xamGUI.ShowDialog() | out-null
