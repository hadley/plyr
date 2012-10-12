#include <R.h>
#include <Rdefines.h>

SEXP split_indices(SEXP group, SEXP n) {
  SEXP vec;
  int i, j, k, nobs, nlevs;

  nlevs = INTEGER(n)[0];
  nobs = LENGTH(group);  
  
  // Count number of cases in each group
  int counts[nlevs];
  for (i = 0; i < nlevs; i++)
    counts[i] = 0;
  for (i = 0; i < nobs; i++) {
    j = INTEGER(group)[i] - 1;
    counts[j]++;
  }

  // Allocate storage for results
  PROTECT(vec = allocVector(VECSXP, nlevs));
  for (i = 0; i < nlevs; i++) {
    SET_VECTOR_ELT(vec, i, allocVector(INTSXP, counts[i]));
  }

  // Put indices in groups
  for (i = 0; i < nlevs; i++) {
    counts[i] = 0;
  }
  for (i = 0; i < nobs; i++) {
    j = INTEGER(group)[i] - 1;
    k = counts[j];
    INTEGER(VECTOR_ELT(vec, j))[k] = i + 1;
    counts[j]++;
  }
  UNPROTECT(1);
  return vec;
}
