#include <Rcpp.h>
using namespace Rcpp;

//' Loop apply
//'
//' An optimised version of lapply for the special case of operating on
//' \code{seq_len(n)}
//'
//' @param n length of sequence
//' @param f function to apply to each integer
//' @param env environment in which to evaluate function
//' @useDynLib plyr
//' @keywords internal manip
// [[Rcpp::export]]
List loop_apply(int n, Function f) {
  List out(n);
  
  for(int i = 0; i < n; ++i) {
    out[i] = f(i + 1);
  }
  
  return out;
}
