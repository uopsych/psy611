gd = read.table("gulldata.txt", header = T)
library(lmerTest)

# OGP = other gulls present

# log transform latency data
LT = log(gd$TimeRec)

# Full model
fmodel = lmer(LT ~ Treatment+Distance+People+OGP+TrialOrder+ExpDist+(1|GullID), data = gd)
summary(fmodel)
plot(fmodel)

#Without gaze (treatment)
wmodel = lmer(LT ~ Distance+People+OGP+TrialOrder+ExpDist+(1|GullID), data = gd)
summary(wmodel)

# Minimal model
mmodel = lmer(LT ~ Treatment+Distance+People+OGP+(1|GullID), data = gd)
summary(mmodel)

# Model with no. of head movements
hmodel = lmer(LT ~ HeadMoves+Distance+People+OGP+(1|GullID), data = gd)
summary(hmodel)

# Model comparison a (gaze vs. without gaze)
anova(wmodel,fmodel)

# Model comparison b (gaze vs. head movements)
anova(hmodel,mmodel)


# Paired data
gull = read.table("pairs.txt", header = T)

# Time difference between trials = Away - At

# The reduction in time taken in "Away" trial
cor.test(gull$At,gull$TimeDiff, method = "spearman")

# Correlation between individual approach times in "At" and "Away"
cor.test(gull$At,gull$Away, method = "spearman")