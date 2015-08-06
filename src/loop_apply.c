#include <R.h>
#include <Rdefines.h>

SEXP loop_apply_(SEXP n, SEXP f, SEXP rho) {
  if(!isFunction(f)) error("'f' must be a function");
  if(!isEnvironment(rho)) error("'rho' should be an environment");

  int n1 = INTEGER(n)[0];

  SEXP results, R_fcall;
  PROTECT(results = allocVector(VECSXP, n1));
  PROTECT(R_fcall = lang2(f, R_NilValue));

  SEXP ii;
  for(int i = 0; i < n1; i++) {
    PROTECT(ii = ScalarInteger(i + 1));
    SETCADR(R_fcall, ii);
    SET_VECTOR_ELT(results, i, eval(R_fcall, rho));

    UNPROTECT(1);
  }

  UNPROTECT(2);
  return results;
}
