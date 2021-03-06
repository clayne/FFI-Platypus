#include "libtest.h"

typedef int (*closure1_t)(void);
typedef int (*closure2_t)(int);
static closure1_t my_closure1;
static closure2_t my_closure2;

EXTERN void
closure_set_closure1(closure1_t closure)
{
  my_closure1 = closure;
}

EXTERN void
closure_set_closure2(closure2_t closure)
{
  my_closure2 = closure;
}

EXTERN int
closure_call_closure1(void)
{
  return my_closure1();
}

EXTERN int
closure_call_closure2(int arg)
{
  return my_closure2(arg);
}

EXTERN int
closure_call_closure_immediate(closure2_t closure, int arg)
{
  return closure(arg);
}

typedef struct {
  const char *one;
  const char *two;
  int three;
  const char *four;
  int myarray1[2];
  void *opaque1;
  void *myarray2[2];
  char fixedfive[5];
} cx_struct_t;

typedef void (*cx_closure_t)(cx_struct_t *, int);
static cx_closure_t my_cx_closure;

EXTERN void
cx_closure_set(cx_closure_t closure)
{
  my_cx_closure = closure;
}

EXTERN void
cx_closure_call(cx_struct_t *s, int i)
{
  my_cx_closure(s, i);
}

typedef void (*cxv_closure_t)(cx_struct_t, int);
static cxv_closure_t my_cxv_closure;

EXTERN void
cxv_closure_set(cxv_closure_t closure)
{
  my_cxv_closure = closure;
}

EXTERN void
cxv_closure_call(cx_struct_t s, int i)
{
  my_cxv_closure(s, i);
}

typedef struct {
  char  foo;
  short bar;
  int   baz;
} cx_struct_simple_t;

typedef cx_struct_simple_t (*cxv_closure_simple_t)(void);

EXTERN cx_struct_simple_t*
cxv_closure_simple_call(cxv_closure_simple_t closure)
{
  static cx_struct_simple_t simple;
  simple = closure();
  return &simple;
}
