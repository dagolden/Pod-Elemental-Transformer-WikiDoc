use strict;
use warnings;
use Pod::Elemental;
use Pod::Elemental::Transformer::Pod5;
use Pod::Elemental::Transformer::WikiDoc;

my $str = do { local $/; <DATA> };

my $doc = Pod::Elemental->read_string($str);

Pod::Elemental::Transformer::Pod5->new->transform_node($doc);
Pod::Elemental::Transformer::WikiDoc->new->transform_node($doc);

print $doc->as_pod_string;

__DATA__
=pod

=head1 Welcome to Pod!

=begin wikidoc

== Reasons to use WikiDoc:

* lists
* more lists
* seriously, they're easy

Also...

0 well, mostly lists
0 yeah, I know, it's silly
0 but they're great

=end wikidoc

The end!
