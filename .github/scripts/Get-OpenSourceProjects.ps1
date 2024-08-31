<#
    .SYNOPSIS
        This script will get all of the public repositories for a given GitHub user and write out markdown files for each repository.

    .DESCRIPTION
        This script will get all of the public repositories for a given GitHub user and write out markdown files for each repository.
        The markdown files will be written to the _projects folder in the root of the project.

    .NOTES
        File Name      : Get-OpenSourceProjects.ps1
        Author         : thetestgame
        Prerequisite   : PowerShell 5.1
#>

# Define our constants
$username = "thetestgame"
$apiUrl = "https://api.github.com/users/$username/repos?per_page=100"
$githubFolder = $PSSCriptRoot + "/../../_foss_projects"

function Get-OpenGraphImageUrl {
    <#
        .SYNOPSIS
            This function will get the Open Graph image URL from a given URL.

        .DESCRIPTION
            This function will get the Open Graph image URL from a given URL.
            The Open Graph image tag is a meta tag that is used to specify the image that represents a page.
            This is useful for generating social media previews.

        .PARAMETER Url
            The URL to get the Open Graph image URL from.

        .EXAMPLE
            Get-OpenGraphImageUrl -Url "https://www.google.com"
            This will return the Open Graph image URL for the Google homepage.
        
        .OUTPUTS
            The Open Graph image URL if found, otherwise a message indicating that the Open Graph image was not found.  
    #>

    param (
        [Parameter(Mandatory = $true)]
        [string]$Url
    )

    # Send a web request to the specified URL and
    # parse the HTML content to find the Open Graph image tag
    $response = Invoke-WebRequest -Uri $Url
    $htmlContent = $response.Content

    # Use a regular expression to find the Open Graph image tag
    $ogImageTag = [regex]::Match($htmlContent, '<meta property="og:image" content="([^"]+)"')
    if ($ogImageTag.Success) {

        # Extract the URL from the content attribute and check if its a custom
        # image or the default GitHub repository image
        $ogImageUrl = $ogImageTag.Groups[1].Value
        if ($ogImageUrl.Contains("https://repository-images.githubusercontent.com/")) {
            return $ogImageUrl
        } else {
            return "/images/projects/project-github.jpg"
        }
    } else {
        return "/images/projects/project-github.jpg"
    }
}

function Main {
    <#
        .sYNOPSIS
            This is the main function that will get all of the public repositories for a given GitHub user and write out markdown files for each repository.

        .DESCRIPTION
            This is the main function that will get all of the public repositories for a given GitHub user and write out markdown files for each repository.
            The markdown files will be written to the _projects folder in the root of the project.
    #>

    # Remove all files in the folder except the gitignore file
    Get-ChildItem -Path $githubFolder -Exclude ".gitignore" | Remove-Item -Force

    # Make the API request and filter only public repositories and sort by stars
    $response = Invoke-RestMethod -Uri $apiUrl -Method Get
    $repos = $response | Where-Object { $_.private -eq $false -and $_.archived -eq $false } | Sort-Object -Property { $_.stargazers_count } -Descending

    # Write out our markdown files for each repository
    $repos | ForEach-Object {
        $repositoryImage = Get-OpenGraphImageUrl -Url $_.html_url

        $fileBuilder = [System.Text.StringBuilder]::new()
        $fileBuilder.AppendLine("---")
        $fileBuilder.AppendLine("title: $($_.name)")
        $fileBuilder.AppendLine("subtitle: $($_.description)")
        $fileBuilder.AppendLine("stars: $($_.stargazers_count)")
        $fileBuilder.AppendLine("image: $repositoryImage")
        $fileBuilder.AppendLine("link: $($_.html_url)")
        $fileBuilder.AppendLine("---")
        $fileBuilder.AppendLine([String]::EmptyLine)
        $fileBuilder.AppendLine($_.description)

        $filename = "$githubFolder/$($_.id)-$($_.name).md".ToLower()
        Write-Output "Writing '$filename'..."
        $utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
        [System.IO.File]::WriteAllLines($filename, $fileBuilder.ToString(), $utf8NoBomEncoding)
    }
}

Main