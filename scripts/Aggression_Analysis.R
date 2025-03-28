# for versions of emmeans newer than version 1.8.0 all ggplot lines calling:
#'geom_errorbar(aes(ymin=lower.CL, ymax=upper.CL), width=.1)'
# must be changed to: 
#'geom_errorbar(aes(ymin=asymp.LCL, ymax=asymp.UCL), width=.1)'
#'

angry_flies <- read.csv("../data/MM_aggression_FINAL.csv")

library(glmmTMB)
library(ggplot2)
library(ggridges)
library(emmeans)
library(cowplot)

angry_flies$Trt <- gsub("B", "NT", angry_flies$Trt)
angry_flies$Trt <- gsub("V", "UCT", angry_flies$Trt)
angry_flies$Trt <- gsub("F", "SCT", angry_flies$Trt)

angry_flies$SessionDate <- with(angry_flies, interaction(Day, Session, drop = TRUE))
angry_flies$Trt <- factor(angry_flies$Trt, levels = c("NT", "UCT", "SCT"))

str(angry_flies)

ggplot(angry_flies, aes(x = Trt, y = Threat_dur)) +
  geom_jitter(height = 0.1, width = 0.1, alpha = 0.5)



ggplot(angry_flies, aes(x = Trt, y = Lunges)) +
  geom_jitter(height = 0.1, width = 0.1, alpha = 0.5)


# threat duration seconds per minute
mod1_Duration <- glmmTMB(Threat_SM ~  Observer + Trt  +
                            (1 | Trt:Lineage) + (1| SessionDate) + (1| Cam), 
                    family = tweedie(link = "log"),
                    data = angry_flies)

summary(mod1_Duration)

family_params(mod1_Duration)
car::Anova(mod1_Duration)

emmeans_Duration <- emmeans(mod1_Duration, ~ Trt, type = "response")
emmeans_Duration_df <- as.data.frame(emmeans_Duration)



# Duration figure
ggplot(emmeans_Duration_df, aes(y = response, x = Trt)) +
  geom_errorbar(aes(ymin=lower.CL, ymax=upper.CL), width=.1) +
  ylab("Threat duration (s/m)") +
  xlab("Treatment") +
  ylim(c(-0.05, 9.5)) +
  theme_classic() +
  geom_jitter(data = angry_flies, aes(x = Trt, y = Threat_SM), 
              width = 0.1, height = 0.1, alpha = 0.5, size = 1, color = "grey") +
  geom_point()


# Please note in the manuscript that for this figure we cut it off at 4, which does not plot two of the observational values. Also there is slight jitter added to make the observations clearer against the fitted model estimates.
plot(emmeans_Duration) +
  ylab("Treatment group") +
  xlab("Threat duration (s/m)") +
  xlim(c(-0.05, 4)) +
  geom_jitter(data = angry_flies, aes(y = Trt, x = Threat_SM), 
              height = 0.25, width = 0.025, alpha = 0.15, size = 3, color = "red") +
  theme_bw()

# good plot
plot1 <- ggplot(as.data.frame(as.data.frame(emmeans_Duration)), aes(x=response, y = Trt)) +
  theme_classic() +
  geom_linerange(aes(xmin=lower.CL,xmax=upper.CL), position = position_dodge(width = 0.90)) +
  geom_point(position = position_dodge(width = 0.90)) +
  geom_jitter(data = angry_flies, aes(y = Trt, x = Threat_SM), 
              height = 0.1, width = 0.025, alpha = 0.15, size = 1, color = "red") +
  xlab("Threat duration (s/m)") +
  ylab("Treatment") +
  xlim(c(-0.05, 4)) +
  theme(legend.position = "none") +
  scale_colour_grey(start = 0,end = 0.75,aesthetics = "colour")


## Double checking the way we handle zeroes for threat duration does not alter results substantially.
mod1_Duration_ziGamma <- glmmTMB(Threat_SM ~  Observer + Trt  +
                                   (1 | Trt:Lineage) + (1| SessionDate) + (1| Cam),
                                 ziformula = ~1 + Trt,
                                 family = ziGamma(link = "log"),
                                 data = angry_flies)

summary(mod1_Duration_ziGamma)

plot(emmeans(mod1_Duration_ziGamma, ~ Trt, type = "response"))

## Qualitatively similar results to the Tweedie. As expected contrasts are smaller because of how it is handling zeroes, but the same general trend.



## lunges

# We initially fit this as a negative binomial with zi, but had convergence issues. We diagnosed this (diagnose(model) and the large-ish values of the dispersion parameter suggested we should use a poisson with zi instead.)


mod1_Lunges_simple <- glmmTMB(Lunges ~  Observer + Trt  +
                         (1 | Trt:Lineage) + (1| SessionDate) + (1| Cam),
                       family = poisson(link = "log"),
                       ziformula = ~1,
                       data = angry_flies)

diagnose(mod1_Lunges_simple)
summary(mod1_Lunges_simple)
car::Anova(mod1_Lunges_simple)



lunges_emmeans <- emmeans(mod1_Lunges_simple, ~ Trt, type = "response")
lunges_emmeans_df <- as.data.frame(lunges_emmeans)


ggplot(lunges_emmeans_df, aes(y = rate, x = Trt)) +
  geom_errorbar(aes(ymin=lower.CL, ymax=upper.CL), width=.1) +
  ylab("Count of lunges in 15 minutes") +
  xlab("Treatment") +
  theme_classic() +
  geom_jitter(data = angry_flies, aes(x = Trt, y = Lunges), 
              width = 0.1, height = 0.1, alpha = 0.5, size = 1, color = "grey") +
  geom_point()



plot(lunges_emmeans) +
  ylab("treatment group") +
  xlab("number of lunges (in 15 min)") +
  geom_jitter(data = angry_flies, aes(y = Trt, x = Lunges), 
              height = 0.25, width = 0.025, alpha = 0.15, size = 3, color = "red") +
  theme_bw()

# good plot

plot2 <- ggplot(as.data.frame(as.data.frame(lunges_emmeans)), aes(x=rate, y = Trt)) +
  theme_classic() +
  geom_linerange(aes(xmin=lower.CL,xmax=upper.CL), position = position_dodge(width = 0.90)) +
  geom_point(position = position_dodge(width = 0.90)) +
  geom_jitter(data = angry_flies, aes(y = Trt, x = Threat_SM), 
              height = 0.1, width = 0.025, alpha = 0.15, size = 1, color = "red") +
  xlab("Number of lunges (in 15 min)") +
  ylab("Treatment") +
  theme(legend.position = "none") +
  scale_colour_grey(start = 0,end = 0.75,aesthetics = "colour")

plot_grid(plot1,plot2,labels = c('A','B'), ncol = 1)


