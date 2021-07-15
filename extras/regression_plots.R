regression_plots <- function(x, ...) {
 require(patchwork)
 y_name <- tune::.get_tune_outcome_names(x)
 y_sym <- rlang::sym(y_name)
 hold_out_pred <-
  tune::collect_predictions(x, summarize = TRUE, ...) %>%
  dplyr::mutate(
   outcome = !!y_sym,
   residual = outcome - .pred
  )
 
 obs_vs_pred_plot <-
  hold_out_pred %>%
  ggplot(aes(x = .pred, y = outcome)) +
  geom_abline(lty = 2, col = "green") +
  geom_point(alpha = .4) +
  labs(x = "Predicted", y = "Observed") +
  coord_obs_pred()
 
 resid_plot <-
  hold_out_pred %>%
  ggplot(aes(x = .pred, y = residual)) +
  geom_hline(yintercept = 0, lty = 2, col = "green") +
  geom_point(alpha = .4) +
  labs(x = "Predicted", y = "Residual") 
 
 obs_vs_pred_plot  + resid_plot
}
