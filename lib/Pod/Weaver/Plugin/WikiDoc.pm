package Pod::Weaver::Plugin::WikiDoc;
use Moose;
with 'Pod::Weaver::Role::Dialect';

use namespace::autoclean;

use Pod::Elemental::Transformer::WikiDoc;

sub translate_dialect {
  my ($self, $pod_document) = @_;

  Pod::Elemental::Transformer::WikiDoc->new->transform_node($pod_document);
}

1;
