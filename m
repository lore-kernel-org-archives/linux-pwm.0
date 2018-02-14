From: Emil Lenngren <emil.lenngren@gmail.com>
Subject: About disabling sun4i-pwm
Date: Wed, 14 Feb 2018 18:17:45 +0100
Message-ID: <CAO1O6sebSwTR7ONQxq2WwPzMve5yq1z+EctrYgZ9Ynve-CU4AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pl0-f47.google.com ([209.85.160.47]:45928 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033317AbeBNRRq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Feb 2018 12:17:46 -0500
Received: by mail-pl0-f47.google.com with SMTP id p5so8872182plo.12
        for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2018 09:17:46 -0800 (PST)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org

Hi. I saw some discussions on disabling the PWM for sun4i and some
troubles about if it was being disabled during an active pulse, it
doesn't turn off the output but it stays active.

The original code is something like the following:
val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
val &= ~BIT_CH(PWM_EN, pwm->hwpwm);
val &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);

A suggested fix was to add a delay so it gets disabled during a low pulse.

But instead of the delay, I found it seems to be enough first writing
the ctrl reg with the PWM_EN bit disabled and then again writing the
ctrl reg with the PWM_CLK_GATING bit disabled, like this:

val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
val &= ~BIT_CH(PWM_EN, pwm->hwpwm);
sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
val &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);

I have an Allwinner R8 chip, so not sure if that applies for the other
chips though. Anyone who has tested this more simpler fix?

/Emil
