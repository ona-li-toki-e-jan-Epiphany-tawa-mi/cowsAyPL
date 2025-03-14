# Changelog

## Upcoming

- Added error for specifying '+' without an option (like '+h'.)
- Added note of '++' in help information.
- Fixed introduced bug with +T not working with a single character argument.
- Fixed error on insufficient arguments.
- Removed extra newline on output.

## 2.0.0

- Updated to fio.apl library.
- Vastly improved and simplified argument parsing. Arguments to options can now be specified without spaces, i.e.: '+W25'.
- Added '+l' option.
- Made cow stay in place.

## RELEASE-V1.2.3

- Updated fio.apl library.
- Relicensed as GPLv3+.
- Removed buggy lambdas.

## RELEASE-V1.2.2

- Fixed bug with reading from stdin resuting in numbers being printed.
- Updated fio.apl library.

## RELEASE-V1.2.1

- Improved error handling.
- Added integration testing.

## RELEASE-V1.2.0

- Improved argument parsing. It can now handle mutiple options in a single row (i.e.: +bW 40).
- Added UTF-8 support.
- Removed dependency on GNU APL compiled with libpcre2

## RELEASE-V1.1.0

- Ported to GNU APL (was Dyalog APL.)

## RELEASE-V0.1.0

- Initial release.
