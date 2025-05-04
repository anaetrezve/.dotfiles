# Ripgrep Flags Reference

## Search Behavior

| Flag                   | Description                                |
| ---------------------- | ------------------------------------------ |
| `-i, --ignore-case`    | Case insensitive search                    |
| `-s, --case-sensitive` | Force case sensitive search                |
| `-w, --word-regexp`    | Match whole words only                     |
| `-e, --regexp`         | Use pattern as a regular expression        |
| `-F, --fixed-strings`  | Treat pattern as literal string, not regex |
| `-U, --multiline`      | Allow matching across multiple lines       |

## File Selection

| Flag                 | Description                                                     |
| -------------------- | --------------------------------------------------------------- |
| `-g, --glob`         | Include/exclude files matching glob pattern (e.g., `-g '*.js'`) |
| `--type`             | Only search specific file types (e.g., `--type js`)             |
| `--type-not`         | Exclude specific file types                                     |
| `-t`                 | Shorthand for `--type`                                          |
| `-T`                 | Shorthand for `--type-not`                                      |
| `--hidden`           | Search hidden files and directories                             |
| `--no-ignore`        | Don't respect `.gitignore`, etc.                                |
| `-u, --unrestricted` | Search all files (combine levels of `-u` for more unrestricted) |

## Context Control

| Flag                   | Description                           |
| ---------------------- | ------------------------------------- |
| `-A, --after-context`  | Show N lines after matches            |
| `-B, --before-context` | Show N lines before matches           |
| `-C, --context`        | Show N lines before and after matches |

## Output Options

| Flag                          | Description                         |
| ----------------------------- | ----------------------------------- |
| `-l, --files-with-matches`    | Only show filenames with matches    |
| `-L, --files-without-matches` | Only show filenames without matches |
| `--no-filename`               | Don't show filenames                |
| `-n, --line-number`           | Show line numbers                   |
| `-N, --no-line-number`        | Don't show line numbers             |
| `--replace`                   | Replace matches with given text     |
| `-o, --only-matching`         | Show only the matched parts         |
| `-c, --count`                 | Only show count of matches per file |
| `--json`                      | Output results in JSON format       |
| `--colors`                    | Configure color settings            |

## Performance

| Flag             | Description                           |
| ---------------- | ------------------------------------- |
| `-j, --threads`  | Set number of threads to use          |
| `--max-depth`    | Limit search depth for directories    |
| `--max-filesize` | Skip files larger than specified size |

## Special Switches

| Flag                 | Description                                    |
| -------------------- | ---------------------------------------------- |
| `-z, --search-zip`   | Search in compressed files                     |
| `-v, --invert-match` | Invert matches (show non-matching lines)       |
| `-P, --pcre2`        | Use PCRE2 for regex (more powerful but slower) |
| `--debug`            | Output debug information                       |
