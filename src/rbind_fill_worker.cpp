
#include <Rcpp.h>
using namespace Rcpp;

template <int T, class U>
void fillNA(Vector<T> v, size_t from, size_t to) {
  std::fill(v.begin() + from, v.begin() + to, v.get_na());
}

void fillNA(SEXP v, size_t from, size_t to) {
  switch (TYPEOF(v)) {
  case REALSXP: fillNA(as<Vector<REALSXP> >(v), from, to); break;
  case LGLSXP:  fillNA(as<Vector<LGLSXP>  >(v), from, to); break;
  case INTSXP:  fillNA(as<Vector<INTSXP>  >(v), from, to); break;
  case STRSXP:  fillNA(as<Vector<STRSXP>  >(v), from, to); break;
  case CPLXSXP:
  default:
    throw exception("Not implemented");
  }
}

template <int T>
void copy(Vector<T> v, Vector<T> x, size_t from) {
  std::copy(x.begin(), x.end(), v.begin() + from);
}

void copy(SEXP v, SEXP x, size_t from) {
  switch (TYPEOF(v)) {
  case REALSXP: copy<REALSXP>(v, x, from); break;
  case LGLSXP:  copy<LGLSXP> (v, x, from); break;
  case INTSXP:  copy<INTSXP> (v, x, from); break;
  case STRSXP:  copy<STRSXP> (v, x, from); break;
  case CPLXSXP:
  default:
    throw exception("Not implemented");
  }
}

// [[Rcpp::export(rbind.fill.worker.rcpp)]]
List rbind_fill_worker(List dfs, IntegerVector rows, int nrows)
{
  std::vector<char*> aNames;
  
  {
    std::set<char*> sNames;
    for (List::iterator idf = dfs.begin(); idf != dfs.end(); ++idf) {
      DataFrame df = *idf;
      CharacterVector names = df.names();
      for (CharacterVector::iterator iname = names.begin(); iname != names.end(); ++iname) {
        if (sNames.insert(*iname).second)
          aNames.push_back(*iname);
      }
    }
  }
  
  List output(aNames.size());
  CharacterVector outNames = output.names() = CharacterVector(aNames.begin(), aNames.end());
  
  std::vector<size_t> validState(aNames.size());
  
  size_t nrow = 0;
  for (List::iterator idf = dfs.begin(); idf != dfs.end(); ++idf) {
    DataFrame df = *idf;
    int idf_pos = idf - dfs.begin();
    size_t df_rows = rows[idf_pos];
    
    CharacterVector names = df.names();
    IntegerVector nameMatches(Rf_match(names, outNames, NA_INTEGER));

    for (CharacterVector::iterator iOutName = outNames.begin(); iOutName != outNames.end(); ++iOutName) {
      const char* name = as<const char*>(*iOutName);
      int pos = iOutName - outNames.begin();
      
      int inPos = nameMatches[pos];
      if (inPos == NA_INTEGER)
        continue;
      inPos--;
      
      SEXP col = df[inPos];
      
      SEXP colOut = output[pos];
      if (Rf_isNull(colOut))
        output[pos] = colOut = Rf_allocVector(TYPEOF(col), nrows);
      
      fillNA(colOut, validState[pos], nrow);
      copy(colOut, col, nrow);
      validState[pos] = nrow + df_rows;
    }
    nrow += df_rows;
  }
  
  for (CharacterVector::iterator iOutName = outNames.begin(); iOutName != outNames.end(); ++iOutName) {
    int pos = iOutName - outNames.begin();
    fillNA(output[pos], validState[pos], nrow);
  }
  
  return output;
}
