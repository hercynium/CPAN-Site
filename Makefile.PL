use ExtUtils::MakeMaker;

# Avoid the loading of a huge number of modules on clients.  When
# someone runs the script as client, it will get a problem with
# missing "CPAN::Checksums", which is not a problem.

eval "require CPAN::Site";
if(!$@ && $CPAN::Site::VERSION <= 1.01 && !$ENV{MARKOV_DEVEL})
{   warn <<__WARN;

*** the interface of CPAN::Site has changed a lot with release 1.01
*** please re-read the documentation.

__WARN
    sleep 5
}

my @prereq =
 ( Test::More         => 0.82
 , Test::Pod          => 1.00
 , CPAN::Checksums    => 0
 , Getopt::Long       => 0
 , LWP                => 0
 , Log::Report        => 0.25
 , Archive::Tar       => 1.00
 , IO::Zlib           => 0
 , HTTP::Date         => 0
 , version            => 0.76
 );

WriteMakefile
 ( NAME       => 'CPAN::Site'
 , ABSTRACT   => 'adding site local modules'
 , VERSION    => '1.04'

 , EXE_FILES  => [ 'bin/cpansite' ]

 , AUTHOR     => 'Mark Overmeer'
 , PREREQ_PM  => { @prereq }
 , LICENSE    => 'perl'

 );

#### the next lines are added for OODoc, which generates the
#### distribution.
sub MY::postamble { <<__POSTAMBLE }

# for DIST
RAWDIR          = ../public_html/cpan-site/raw
DISTDIR         = ../public_html/cpan-site/source
LICENSE         = artistic

# for POD
FIRST_YEAR      = 1998,2005
EMAIL           = perl\@overmeer.net
WEBSITE         = http://perl.overmeer.net/cpan-site/

# for HTML
#HTML_OUTPUT	= ../public_html/cpan-site/html
#HTML_DOCROOT	= /cpan-site/html
__POSTAMBLE
