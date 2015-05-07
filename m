From: Tim Kryger <tim.kryger@gmail.com>
Subject: Re: [PATCH v6 3/4] pwm: kona: Fix incorrect config, disable, and
 polarity procedures
Date: Wed, 6 May 2015 21:26:00 -0700
Message-ID: <CAD7vxxKB25h03Z+oM9EKNUv4mkTRW=necT32i3LW1Chf4dMaJQ@mail.gmail.com>
References: <1428692333-14400-1-git-send-email-jonathar@broadcom.com>
	<1428692333-14400-4-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:36398 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbbEGE0D (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 7 May 2015 00:26:03 -0400
In-Reply-To: <1428692333-14400-4-git-send-email-jonathar@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jonathan Richardson <jonathar@broadcom.com>
Cc: Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PWM <linux-pwm@vger.kernel.org>

On Fri, Apr 10, 2015 at 11:58 AM, Jonathan Richardson
<jonathar@broadcom.com> wrote:

> The polarity procedure no longer applies the settings to change the
> output signal because it can't be called when the pwm is enabled anyway.
> The polarity is only updated in the control register. The correct
> polarity will be applied on enable. The old method of applying changes
> would result in no signal when the polarity was changed. The new
> apply_settings function would fix this problem but it isn't required
> anyway.

Why does this bug fix need to alter when polarity changes take effect?

That is an an unrelated change and I don't really agree with it.

>                 /* If duty_ns or period_ns are not achievable then return */
> -               if (pc < PERIOD_COUNT_MIN || dc < DUTY_CYCLE_HIGH_MIN)
> +               if (pc < PERIOD_COUNT_MIN) {
> +                       dev_warn(chip->dev,
> +                               "%s: pwm[%d]: period=%d is not achievable, pc=%lu, prescale=%lu\n",
> +                               __func__, chan, period_ns, pc, prescale);
> +                       return -EINVAL;
> +               }
> +
> +               /* If duty_ns is not achievable then return */
> +               if (dc < DUTY_CYCLE_HIGH_MIN) {
> +                       if (0 != duty_ns) {
> +                               dev_warn(chip->dev,
> +                                       "%s: pwm[%d]: duty cycle=%d is not achievable, dc=%lu, prescale=%lu\n",
> +                                       __func__, chan, duty_ns, dc, prescale);
> +                       }
>                         return -EINVAL;
> +               }
>
>                 /* If pc and dc are in bounds, the calculation is done */
>                 if (pc <= PERIOD_COUNT_MAX && dc <= DUTY_CYCLE_HIGH_MAX)
>                         break;
>
>                 /* Otherwise, increase prescale and recalculate pc and dc */
> -               if (++prescale > PRESCALE_MAX)
> +               if (++prescale > PRESCALE_MAX) {
> +                       dev_warn(chip->dev,
> +                               "%s: pwm[%d]: Prescale (=%lu) within max (=%d) for period=%d and duty cycle=%d is not achievable\n",
> +                               __func__, chan, prescale, PRESCALE_MAX,
> +                               period_ns, duty_ns);
>                         return -EINVAL;
> +               }
>         }

This extra debug output seems helpful but could you put it in its own
commit and keep this focused on fixing the instability you observed?

> +               /*
> +                * Clear trigger bit but set smooth bit to maintain old
> +                * output.
> +                */
> +               value |= 1 << PWM_CONTROL_SMOOTH_SHIFT(chan);
> +               value &= ~(1 << PWM_CONTROL_TRIGGER_SHIFT(chan));
> +               writel(value, kp->base + PWM_CONTROL_OFFSET);
> +

The above lines are duplicated below.  Perhaps a function is in order?

> +       /* Set smooth type to 1 and disable */
> +       value |= 1 << PWM_CONTROL_SMOOTH_SHIFT(chan);
> +       value &= ~(1 << PWM_CONTROL_TRIGGER_SHIFT(chan));
> +       writel(value, kp->base + PWM_CONTROL_OFFSET);

It seems like the important parts of the fix could be distilled down
to something like this:

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 02bc048..4ff500c 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -76,7 +76,8 @@ static inline struct kona_pwmc *to_kona_pwmc(struct
pwm_chip *_chip)
       return container_of(_chip, struct kona_pwmc, chip);
 }

-static void kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
+static void kona_pwmc_prepare_for_settings(struct kona_pwmc *kp,
+                                 unsigned int chan)
 {
       unsigned int value = readl(kp->base + PWM_CONTROL_OFFSET);

@@ -85,10 +86,19 @@ static void kona_pwmc_apply_settings(struct
kona_pwmc *kp, unsigned int chan)
       value &= ~(1 << PWM_CONTROL_TRIGGER_SHIFT(chan));
       writel(value, kp->base + PWM_CONTROL_OFFSET);

+      ndelay(400);
+}
+
+static void kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
+{
+      unsigned int value = readl(kp->base + PWM_CONTROL_OFFSET);
+
       /* Set trigger bit and clear smooth bit to apply new settings */
       value &= ~(1 << PWM_CONTROL_SMOOTH_SHIFT(chan));
       value |= 1 << PWM_CONTROL_TRIGGER_SHIFT(chan);
       writel(value, kp->base + PWM_CONTROL_OFFSET);
+
+      ndelay(400);
 }

 static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -135,6 +145,8 @@ static int kona_pwmc_config(struct pwm_chip *chip,
struct pwm_device *pwm,

       /* If the PWM channel is enabled, write the settings to the HW */
       if (test_bit(PWMF_ENABLED, &pwm->flags)) {
+            kona_pwmc_prepare_for_settings(kp, chan);
+
             value = readl(kp->base + PRESCALE_OFFSET);
             value &= ~PRESCALE_MASK(chan);
             value |= prescale << PRESCALE_SHIFT(chan);
@@ -164,6 +176,8 @@ static int kona_pwmc_set_polarity(struct pwm_chip
*chip, struct pwm_device *pwm,
             return ret;
       }

+      kona_pwmc_prepare_for_settings(kp, chan);
+
       value = readl(kp->base + PWM_CONTROL_OFFSET);

       if (polarity == PWM_POLARITY_NORMAL)
@@ -175,9 +189,6 @@ static int kona_pwmc_set_polarity(struct pwm_chip
*chip, struct pwm_device *pwm,

       kona_pwmc_apply_settings(kp, chan);

-      /* Wait for waveform to settle before gating off the clock */
-      ndelay(400);
-
       clk_disable_unprepare(kp->clk);

       return 0;
@@ -209,12 +220,10 @@ static void kona_pwmc_disable(struct pwm_chip
*chip, struct pwm_device *pwm)
       unsigned int chan = pwm->hwpwm;

       /* Simulate a disable by configuring for zero duty */
+      kona_pwmc_prepare_for_settings(kp, chan);
       writel(0, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
       kona_pwmc_apply_settings(kp, chan);

-      /* Wait for waveform to settle before gating off the clock */
-      ndelay(400);
-
       clk_disable_unprepare(kp->clk);
 }
