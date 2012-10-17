#include <R.h>
#include <Rdefines.h>

SEXP split_indices(SEXP group, SEXP n) {
  SEXP vec;
  int i, j, k;

  int nlevs = INTEGER(n)[0];
  int nobs = LENGTH(group);  
  int *pgroup = INTEGER(group);
  
  // Count number of cases in each group
  int counts[nlevs];
  for (i = 0; i < nlevs; i++)
    counts[i] = 0;
  for (i = 0; i < nobs; i++) {
    j = pgroup[i];
    if (j > nlevs) error("n smaller than largest index");
    counts[j - 1]++;
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
    j = pgroup[i] - 1;
    k = counts[j];
    INTEGER(VECTOR_ELT(vec, j))[k] = i + 1;
    counts[j]++;
  }
  UNPROTECT(1);
  return vec;
}
