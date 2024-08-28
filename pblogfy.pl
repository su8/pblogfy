# 08/28/2024 https://github.com/su8

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
# MA 02110-1301, USA.

# whereis cpan
# sudo cpan install Text::Markdown File::Find

use strict;
use warnings;

use File::Copy;
use List::Util qw(any);
use Text::Markdown 'markdown';
use File::Find;


sub re_read {
  my ($filename) = @_;
  my $fh;

  open($fh, '<:encoding(UTF-8)', $filename)
    or die "Could not open file '$filename' $!";
  local $/ = undef; # <--- slurp mode
  my $concatArr = <$fh>;
  close($fh);

  return $concatArr;
}

sub re_write {
  my ($filename,$concatArr) = @_;
  my $fh;

  open($fh, '>:encoding(UTF-8)', $filename) 
    or die "Could not open file '$filename' $!";

  print $fh $concatArr;
  close($fh);
  return;
}

sub getPosts {
    my ($dir) = @_;
    my @files;
    find(sub { push @files, $_ }, $dir);
    return @files
}



{
  mkdir ("generated", 0700) unless (-d "generated");
  for my $x (getPosts("markdown"))
  {
    my $post = "generated/$x";
    $post =~ s/.md//;
    mkdir ($post,0700) unless (-d $post);
    if ($x ne ".") {
      my $html = markdown(re_read("markdown/$x"));
      re_write("$post/index.html", $html);
    }
  }

  print "Done\n";
}
