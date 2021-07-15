overlay_roc_curves <- function(x, highlight, alpha = 0.15) {
 require(ggplot2)
 curves <- 
  x %>% 
  dplyr::group_by(wflow_id, .config) %>% 
  yardstick::roc_curve(class, .pred_successful) %>% 
  dplyr::ungroup()
 
 models <- unique(x$wflow_id)
 others <- models[models != models]
 curve_cols <- purrr::map_chr(models, ~ rgb(0, 0, 0, alpha))
 names(curve_cols) <- models
 curve_cols[which(models == highlight)] <- "black"
 
 p <- 
  curves %>% 
  ggplot(aes(x = 1 - specificity, y = sensitivity, col = wflow_id)) + 
  geom_abline(col = "red", lty = 2, alpha = .3) +
  geom_step(direction = "vh", show.legend = FALSE) +
  tune::coord_obs_pred() + 
  scale_color_manual(values = curve_cols) + 
  theme_bw() + 
  theme() + 
  theme(
   panel.grid.major = element_blank(),
   panel.grid.minor = element_blank(),
  )
 p
}

