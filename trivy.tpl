{{- $tableHeader := printf "| %-14s | %-20s | %-17s | %-15s | %-8s |\n" "Vulnerability ID" "Package" "Installed Version" "Fixed Version" "Severity" -}}
{{- $separator := printf "|-%-14s-|-%-20s-|-%-17s-|-%-15s-|-%-8s-|\n" "---------------" "--------------------" "-----------------" "---------------" "--------" -}}

{{- $vulnerabilitiesCount := 0 -}}
{{- range . -}}
  {{- $vulnerabilitiesCount = add $vulnerabilitiesCount (len .Vulnerabilities) -}}
{{- end -}}

{{ print "# Trivy Scan Results\n" }}

{{- if eq $vulnerabilitiesCount 0 -}}
No vulnerabilities found.
{{- else -}}
{{ print $tableHeader $separator }}
{{- range . -}}
  {{- range .Vulnerabilities -}}
    {{- printf "| %-14s | %-20s | %-17s | %-15s | %-8s |\n" .VulnerabilityID .PkgName .InstalledVersion .FixedVersion .Severity }}
  {{- end -}}
{{- end -}}
{{- end -}}
