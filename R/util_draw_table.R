#' Helper function to draw table grobs. 
#' 
#' \code{draw_table()} Pre and post version: 2.0.0 gridExtra packages
#' handle drawing tables differently. \code{draw_table()} determines
#' the installed version of gridExtra and applies the appropriate
#' syntax. If gridExtra version < 2.0.0 then it uses old gridExtra 
#' syntax to build table Grob(graphical object) else uses new syntax. 
#' \code{draw_table()}
#' 
#' prints tables without rownames.
#'
#' @section Acknowledgements: Thanks to Ryan Welch, 
#' https://github.com/welchr/LocusZoom/issues/16
#'
#'
#' @param body A dataframe. Table body.
#' @param heading A string. Table title.
#' @param ... Further arguments to control the gtable.
#'
#' @examples
#' # note: not exported hence examples are not run
#' library(gridExtra)
#'
#' \donttest{
#'
#' # Table of iris values
#' iris_dframe <- head(iris)
#' title_iris_dframe <- paste("Table: Length and width measurements (cm) of sepals ",
#'                        "and petals, for 50 flowers from 3 species of iris ", 
#'                        "(setosa, versicolor, and virginica). ", sep="")
#' table_influential_studies <-  draw_table(body = iris_dframe, heading = title_iris_dframe)
#' 
#' # Table of mtcars values 
#' mtcars_dframe <- head(mtcars)
#' title_mtcars_dframe <- paste("Table: Motor Trend US magazine (1974) automobile ",
#'                         "statistics for fuel consumption, automobile ", 
#'                         "design and performance. ", sep="")
#' table_influential_studies <-  draw_table(body = mtcars_dframe, 
#'                                           heading = title_mtcars_dframe)
#'}

#' # @export
draw_table <- function(body, heading, ...) {

  ge_version <- as.character(utils::packageVersion("gridExtra"))
  vcomp = utils::compareVersion(ge_version,"2.0.0")
  
  if (vcomp == -1) {
    table_old <- gridExtra::tableGrob(
      
      body,
      show.rownames = FALSE,
      gpar.corefill = grid::gpar(fill = "white", col = "black"),
      gpar.colfill = grid::gpar(fill = "white", col = "black"),
      ...
    )
    
    # Assigning the var h the height of our table
	height_table_old <- grid::grobHeight(table_old)

	title_old <- grid::textGrob(heading, y=grid::unit(0.5, "npc") + 0.7*height_table_old,vjust=0,gp=grid::gpar(fontsize=12.0))
	gt_table_old <- grid::gTree(children=grid::gList(table_old, title_old))
	
	print(grid::grid.newpage())
	print(grid::grid.draw(gt_table_old))


  } else {
  
    tt <- gridExtra::ttheme_default(
        core=list(bg_params = list(fill = "white", col="black")),
        colhead=list(bg_params = list(fill = "white", col="black")))
  
    table <- gridExtra::tableGrob(
      
      body,
      theme = tt,
      rows = NULL,
      ...
    )
    
    title <- grid::textGrob(heading, gp=grid::gpar(fontsize=12), vjust=0)
    
    padding <- grid::unit(0.2,"npc")
    
    table <- gtable::gtable_add_rows(table, heights = grid::grobHeight(title) + padding, pos = 0)
    
    table <- gtable::gtable_add_grob(table, title, t=1, b=nrow(table), l=1, r=ncol(table))
   
   #rectangle grob dimensions: height:row3 --> nrows, width:col1 --> ncols
    table <- gtable::gtable_add_grob(table, grobs = grid::rectGrob(gp = grid::gpar(fill = NA, lwd = 2)), t = 3, b = nrow(table), l = 1, r = ncol(table))

   #rectangle grob dimensions: height:row2 --> row2, width:col1 --> ncols
    table <- gtable::gtable_add_grob(table, grobs = grid::rectGrob(gp = grid::gpar(fill = NA, lwd = 2)), t = 2, b = 2, l = 1, r = ncol(table))
 
    print(grid::grid.newpage())
    print(grid::grid.draw(table))


  }
}

