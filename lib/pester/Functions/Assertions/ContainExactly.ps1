function PesterContainExactly($file, $contentExpecation) {
    return ((Get-Content -Encoding UTF8 $file) -cmatch $contentExpecation)
}

function PesterContainExactlyFailureMessage($file, $contentExpecation) {
    return "Expected: file ${file} to contain exactly {$contentExpecation}"
}

function NotPesterContainExactlyFailureMessage($file, $contentExpecation) {
    return "Expected: file {$file} to not contain exactly ${contentExpecation} but it did"
}

