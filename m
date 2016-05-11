From: Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Subject: pwm: atmel: PWM may not properly disable
Date: Wed, 11 May 2016 10:48:38 +0200
Message-ID: <CABDcavZXCGWGajRucaFztg98KCoUi-bLxV1fj+j8mW+WdSuLBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: linux-pwm@vger.kernel.org

Hello all,

I am seeing a problem with the atmel-pwm driver where disabling a PWM
channel sometimes leaves the output at the wrong level ("wrong" == not
idle, as per the configured polarity). This causes problems when the
PWM is used to drive a LED or certain types of buzzers.

The issue seems to be in the atmel_pwm_disable function [1], which
disables the clock immediately after writing to the PWM_DIS register.
As a result, the write does not seem to take effect.

I have verified that this is the cause of the problem this by waiting
until the channel is effectively disabled (by checking the PWM_SR
register) before disabling the clock. This fixes the issue and the PWM
output now stays at the idle level after the channel is disabled.

For the above I used a modified version of a patch that was posted to
the list some time ago [2]. Note that only atmel_pwm_disable needs to
be patched, there seems to be no need to patch atmel_pwm_enable. The
code is as follows:

     atmel_pwm_writel(atmel_pwm, PWM_DIS, 1 << pwm->hwpwm);
+    while (atmel_pwm_readl(atmel_pwm, PWM_SR) & (1 << pwm->hwpwm)) {
+        cpu_relax();
+    }

     clk_disable(atmel_pwm->clk);

Is this acceptable? Should I submit an updated patch?

 [1]: http://lxr.free-electrons.com/source/drivers/pwm/pwm-atmel.c#L253
 [2]: https://lkml.org/lkml/2014/10/1/605

(If possible, please CC me in any replies)
-- 
Guillermo Rodriguez Garcia
guille.rodriguez@gmail.com
