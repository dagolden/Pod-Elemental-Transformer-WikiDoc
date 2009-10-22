package Pod::Elemental::Transformer::WikiDoc;
use Moose;
with 'Pod::Elemental::Transformer';

use Moose::Autobox;

use Pod::Elemental::Types qw(FormatName);
use Pod::WikiDoc;

has format_name => (
  is  => 'ro',
  isa => FormatName,
  default => 'wikidoc',
);

sub transform_node {
  my ($self, $node) = @_;
  my $children = $node->children;

  PASS: for my $i (0 .. $children->length - 1) {
    my $para = $children->[$i];
    next unless $para->isa('Pod::Elemental::Element::Pod5::Region')
         and    $para->format_name eq $self->format_name;

    confess "wikidoc transformer expects wikidoc region to contain 1 Data para"
      unless $para->children->length == 1
      and    $para->children->[0]->isa('Pod::Elemental::Element::Pod5::Data');

    my $text    = $para->children->[0]->content;
    my $parser  = Pod::WikiDoc->new;
    my $new_pod = $parser->format($para->as_pod_string);

    my $new_doc = Pod::Elemental->read_string($new_pod);
    Pod::Elemental::Transformer::Pod5->transform_node($new_doc);
    $new_doc->children->shift
      while
      $new_doc->children->[0]->isa('Pod::Elemental::Element::Pod5::Nonpod');

    splice @$children, $i, 1, $new_doc->children->flatten;
  }

  return $node;
}

1;
