{{- $tableHeader := printf "| %-14s | %-20s | %-17s | %-15s | %-8s |\n" "Vulnerability ID" "Package" "Installed Version" "Fixed Version" "Severity" -}}
{{- $separator := printf "|-%-14s-|-%-20s-|-%-17s-|-%-15s-|-%-8s-|\n" "---------------" "--------------------" "-----------------" "---------------" "--------" -}}

{{- $vulnerabilities := slice -}}
{{- range . -}}
  {{- range .Vulnerabilities -}}
    {{- $vulnerabilities = $vulnerabilities | append (dict "VulnerabilityID" .VulnerabilityID "PkgName" .PkgName "InstalledVersion" .InstalledVersion "FixedVersion" .FixedVersion "Severity" .Severity) -}}
  {{- end -}}
{{- end -}}

{{- $sortedVulnerabilities := $vulnerabilities | sortAlphaDesc "Severity" -}}

{{- if eq (len $vulnerabilities) 0 -}}
No vulnerabilities found.
{{- else -}}
Trivy Scan Results
{{ $tableHeader }}
{{ $separator }}
{{- range $sortedVulnerabilities -}}
  {{- printf "| %-14s | %-20s | %-17s | %-15s | %-8s |\n" .VulnerabilityID .PkgName .InstalledVersion .FixedVersion .Severity }}
{{- end -}}
{{- end -}}
