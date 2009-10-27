package Pod::Weaver::Plugin::WikiDoc;
use Moose;
with 'Pod::Weaver::Role::Dialect';
# ABSTRACT: allow wikidoc-format regions to be translated during dialect phase

=head1 OVERVIEW

This plugin is an exceedingly thin wrapper around
L<Pod::Elemental::Transformer::WikiDoc>.  When you load this plugin, then
C<=begin> and C<=for> regions with the C<wikidoc> format will be translated to
standard Pod5 before further weaving continues.

=cut

use namespace::autoclean;

use Pod::Elemental::Transformer::WikiDoc;

sub translate_dialect {
  my ($self, $pod_document) = @_;

  Pod::Elemental::Transformer::WikiDoc->new->transform_node($pod_document);
}

1;
