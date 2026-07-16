# =============================================================================
# RBMRB -- colour palettes and residue metadata
# =============================================================================

.AA_COLORS <- c(
  ALA="#1F77B4", ARG="#FF7F0E", ASN="#2CA02C", ASP="#D62728",
  CYS="#9467BD", GLN="#8C564B", GLU="#E377C2", GLY="#7F7F7F",
  HIS="#BCBD22", ILE="#17BECF", LEU="#AEC7E8", LYS="#FFBB78",
  MET="#98DF8A", PHE="#FF9896", PRO="#C5B0D5", SER="#C49C94",
  THR="#F7B6D2", TRP="#DBDB8D", TYR="#9EDAE5", VAL="#393B79",
  A="#E6550D",  C="#31A354",  G="#756BB1",  U="#636363",
  DA="#FD8D3C", DC="#74C476", DG="#9E9AC8", DT="#969696",
  UNK="#AAAAAA"
)

.res_color <- function(residue) {
  col <- .AA_COLORS[toupper(residue)]
  ifelse(is.na(col), .AA_COLORS[["UNK"]], col)
}

.MARKER_SYMBOLS <- c("circle","square","diamond","cross","x",
                      "triangle-up","triangle-down","pentagon","star")

.AXIS_LABELS <- list(
  N  = "\u00b9\u2075N Chemical Shift (ppm)",
  H  = "\u00b9H Chemical Shift (ppm)",
  C  = "\u00b9\u00b3C Chemical Shift (ppm)",
  CA = "\u00b9\u00b3C\u03b1 Chemical Shift (ppm)",
  CB = "\u00b9\u00b3C\u03b2 Chemical Shift (ppm)"
)

.axis_label <- function(atom) {
  lbl <- .AXIS_LABELS[[toupper(atom)]]
  if (is.null(lbl)) paste(atom, "Chemical Shift (ppm)") else lbl
}

# Sidechain N-H pairs per residue
.SIDECHAIN_NH <- list(
  ASN = list(list(H="HD21",N="ND2"), list(H="HD22",N="ND2")),
  GLN = list(list(H="HE21",N="NE2"), list(H="HE22",N="NE2")),
  ARG = list(list(H="HE",  N="NE"),
             list(H="HH11",N="NH1"), list(H="HH12",N="NH1"),
             list(H="HH21",N="NH2"), list(H="HH22",N="NH2")),
  TRP = list(list(H="HE1", N="NE1")),
  LYS = list(list(H="HZ1", N="NZ"), list(H="HZ2",N="NZ"), list(H="HZ3",N="NZ")),
  HIS = list(list(H="HD1", N="ND1"), list(H="HE2",N="NE2"))
)

# Map a proton atom name to its directly bonded carbon (for C13-HSQC)
.h_to_c <- function(atom_h) {
  if (!startsWith(atom_h, "H")) return(NA_character_)
  rest <- substring(atom_h, 2L)
  # Methyl: HXY{1|2|3} --> CXY  e.g. HG11 --> CG1
  if (nchar(rest) == 3L && grepl("^[A-Z][0-9][123]$", rest))
    return(paste0("C", substring(rest, 1L, 2L)))
  # Methylene: HX{2|3} --> CX  e.g. HB2 --> CB
  if (nchar(rest) == 2L && grepl("^[A-Z][23]$", rest))
    return(paste0("C", substring(rest, 1L, 1L)))
  # Simple / aromatic: HA --> CA, HD1 --> CD1, HE2 --> CE2
  paste0("C", rest)
}
