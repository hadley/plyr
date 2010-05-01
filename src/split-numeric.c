#include <R.h>
#include <Rdefines.h>

SEXP split_indices(SEXP index, SEXP group, SEXP n) {
  SEXP counts, vec;
  int i, j, k, nobs, nlevs;

  PROTECT(index = AS_INTEGER(index));
  PROTECT(group = AS_INTEGER(group));

  nlevs = INTEGER(n)[0];
  nobs = LENGTH(index);

  // Count number of cases in each group
  PROTECT(counts = allocVector(INTSXP, nlevs));
  for (i = 0; i < nlevs; i++)
    INTEGER(counts)[i] = 0;
  for (i = 0; i < nobs; i++) {
    j = INTEGER(group)[i] - 1;
    INTEGER(counts)[j]++;
  }

  // Allocate storage for results
  PROTECT(vec = allocVector(VECSXP, nlevs));
  for (i = 0; i < nlevs; i++) {
    SET_VECTOR_ELT(vec, i, allocVector(INTSXP, INTEGER(counts)[i]));
  }

  // Put indices in groups
  for (i = 0; i < nlevs; i++) {
    INTEGER(counts)[i] = 0;
  }
  for (i = 0; i < nobs; i++) {
    j = INTEGER(group)[i] - 1;
    k = INTEGER(counts)[j];
    INTEGER(VECTOR_ELT(vec, j))[k] = INTEGER(index)[i];
    INTEGER(counts)[j] += 1;
  }
  UNPROTECT(4);
  return vec;
}
