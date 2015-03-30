#include <Rcpp.h>
using namespace Rcpp;

//' Split indices.
//'
//' An optimised version of split for the special case of splitting row
//' indices into groups, as used by \code{\link{splitter_d}}.
//'
//' @param index integer indices
//' @param n largest integer (may not appear in index). This is hint: if
//'   the largest value of \code{group} is bigger than \code{n}, the output
//'   will silently expand.
//' @useDynLib plyr
//' @keywords internal manip
//' @export
//' @examples
//' split_indices(sample(10, 100, rep = TRUE))
//' split_indices(sample(10, 100, rep = TRUE), 10)
// [[Rcpp::export]]
std::vector<std::vector<int> > split_indices(IntegerVector group, int n = 0) {
  if (n < 0) stop("n must be a positive integer");

  std::vector<std::vector<int> > ids(n);

  int nx = group.size();
  for (int i = 0; i < nx; ++i) {
    // group is 1-indexed
    if (group[i] > (int) ids.size()) {
      ids.resize(group[i]);
    }

    ids[group[i] - 1].push_back(i + 1);
  }

  return ids;
}
