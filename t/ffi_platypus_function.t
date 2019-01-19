use strict;
use warnings;
use Test::More;
use FFI::Platypus::Function;
use FFI::Platypus;
use FFI::CheckLib;

my $libtest = find_lib lib => 'test', symbol => 'f0', libpath => 't/ffi';

subtest 'built in type' => sub {
  my $ffi = FFI::Platypus->new;
  $ffi->lib($libtest);
  my $function = eval { $ffi->function('f0', [ 'uint8' ] => 'uint8') };
  is $@, '', 'ffi.function(f0, [uint8] => uint8)';
  isa_ok $function, 'FFI::Platypus::Function';
  isa_ok $function, 'FFI::Platypus::Function::Function';
  is $function->call(22), 22, 'function.call(22) = 22';
  is $function->(22), 22, 'function.(22) = 22';
};

subtest 'custom type' => sub {
  my $ffi = FFI::Platypus->new;
  $ffi->lib($libtest);
  $ffi->type('uint8' => 'my_int_8');
  my $function = eval { $ffi->function('f0', [ 'my_int_8' ] => 'my_int_8') };
  is $@, '', 'ffi.function(f0, [my_int_8] => my_int_8)';
  isa_ok $function, 'FFI::Platypus::Function';
  isa_ok $function, 'FFI::Platypus::Function::Function';
  is $function->call(22), 22, 'function.call(22) = 22';
  is $function->(22), 22, 'function.(22) = 22';
};

subtest 'private' => sub {
  my $ffi = FFI::Platypus->new;
  $ffi->lib($libtest);

  my $address = $ffi->find_symbol('f0');
  my $uint8   = FFI::Platypus::Type->new('uint8');

  my $function = eval { FFI::Platypus::Function::Function->new($ffi, $address, -1, $uint8, $uint8) };
  is $@, '', 'FFI::Platypus::Function->new';
  isa_ok $function, 'FFI::Platypus::Function';
  isa_ok $function, 'FFI::Platypus::Function::Function';

  is $function->call(22), 22, 'function.call(22) = 22';

  $function->attach('main::fooble', 'whatever.c', undef);

  is fooble(22), 22, 'fooble(22) = 22';

};

done_testing;
