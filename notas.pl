#!/usr/bin/env perl

use strict;
use warnings;
use v5.14;
use utf8;
use open IO => ':locale';

# use HTML::TableExtract;
use Mojo::DOM qw(tree);
use File::Slurp::Tiny qw(read_file);

my $html_file = shift || "notas.html";

my $html = read_file( $html_file);

die "Problemas con $html_file" if !$html;
my $dom = Mojo::DOM->new( $html);

my $tables = $dom->find( 'table.tablavacia table' );


my $filas = $tables->[0]->find('tr[onmouseover="javascript:Ilumina(this)"]');

my @notas = @$filas;

my @notas_corte;
for my $f (@notas ) {
  next if ( $f->all_text() !~ /^(\d+)/); 
  my $columnas = $f->find('td');
  my @estas_notas =  map $_->all_text(), @$columnas;
  for my $n ( @estas_notas ) {
    if ( $n =~ /\d/ ) {
      $n =~ s/,/./;
    }
  }
  
  push @notas_corte, \@estas_notas;
}

say join("\n", map( join(",",@$_), @notas_corte ));
