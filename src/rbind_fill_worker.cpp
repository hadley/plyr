
#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export(rbind.fill.worker.rcpp)]]
List rbind_fill_worker(List output, DataFrame dfs,
                       IntegerVector rows, DataFrame pos)
{
  return output;
}
