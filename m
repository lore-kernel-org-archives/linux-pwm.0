From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] pwm: imx: Support very long period lengths
Date: Mon, 28 Apr 2014 14:43:01 +0200
Message-ID: <20140428124301.GS5858@pengutronix.de>
References: <1398675331-10980-1-git-send-email-xobs@kosagi.com>
 <1398675331-10980-2-git-send-email-xobs@kosagi.com>
 <20140428092255.GO5858@pengutronix.de>
 <535E4521.6070102@kosagi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57187 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755757AbaD1MnG (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Apr 2014 08:43:06 -0400
Content-Disposition: inline
In-Reply-To: <535E4521.6070102@kosagi.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sean Cross <xobs@kosagi.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org

On Mon, Apr 28, 2014 at 08:10:09PM +0800, Sean Cross wrote:
> On 04/28/14 17:22, Sascha Hauer wrote:
> >On Mon, Apr 28, 2014 at 04:55:31PM +0800, Sean Cross wrote:
> >>The IMX PWM block supports using both the system clock and a 32 kHz
> >>clock for driving PWM events.  For very long period lengths, use the
> >>32 kHz clock instead of the high-speed clock.
> >>
> >>Signed-off-by: Sean Cross <xobs@kosagi.com>
> >>---
> >>  drivers/pwm/pwm-imx.c | 14 +++++++++++---
> >>  1 file changed, 11 insertions(+), 3 deletions(-)
> >>
> >>diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> >>index cc47733..8410455 100644
> >>--- a/drivers/pwm/pwm-imx.c
> >>+++ b/drivers/pwm/pwm-imx.c
> >>@@ -36,9 +36,11 @@
> >>  #define MX3_PWMCR_DOZEEN                (1 << 24)
> >>  #define MX3_PWMCR_WAITEN                (1 << 23)
> >>  #define MX3_PWMCR_DBGEN			(1 << 22)
> >>+#define MX3_PWMCR_CLKSRC_IPG_32K  (3 << 16)
> >>  #define MX3_PWMCR_CLKSRC_IPG_HIGH (2 << 16)
> >>  #define MX3_PWMCR_CLKSRC_IPG      (1 << 16)
> >>  #define MX3_PWMCR_EN              (1 << 0)
> >>+#define MX3_SLOW_THRESHOLD_NS	100000
> >>  struct imx_chip {
> >>  	struct clk	*clk_per;
> >>@@ -107,7 +109,13 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
> >>  	unsigned long period_cycles, duty_cycles, prescale;
> >>  	u32 cr;
> >>-	c = clk_get_rate(imx->clk_per);
> >>+	if (duty_ns > MX3_SLOW_THRESHOLD_NS) {
> >If anything you have to check the period_cycles, not the duty_cycles.
> >
> >100000 seems to be some arbitrary value suitable for some unspecified
> >ipg clock rate. I think you should use it when the period_cycles
> >register overflows.
> In this case, it's for a backlight controller that requires a 100 Hz
> clock.  But you're right, hard-coding the values is a bad idea.
> 
> With the prescaler and the period_cycles register, it might not
> actually overflow, but instead the resolution might become too poor
> to be useful.  The prescaler supports dividing by up to 4096, but it
> gets difficult to hit a particular value.

Hm, this seems to be a common problem. grep for prescale in the pwm
drivers. It seems several drivers iterate over the possible prescalers
to find the best values. Maybe it's time to add some helper function
for this task?

> 
> So with my target of a 100 Hz clock, it appears as though no values
> overflow yet I can't use IPG_HIGH.
> 
> What is the best way to handle this?
> >>+		cr = MX3_PWMCR_CLKSRC_IPG_32K;
> >>+		c = 32768;
> >How about providing a proper clock instead of hardcoding this?
> >
> That seems like a lot of work, and I don't see any other PWM devices
> that do this.  If I understand the clock system, I'd have to add the
> following to pwm-imx.c:
> 
>     - Each PWM would get three new clocks added to its struct
> imx_chip -- a clk_ipg_mux, a clk_ipg_32k, and a clk_ipg_high
>     - The struct imx_chip would also gain a clk_ckil entry for the
> 32768 Hz clock
>     - These three clocks would need to be created on _probe() and
> destroyed on _remove()
>     - clk_ipg_32k would get reparented to ckil (or whatever the
> 32768 Hz clock is on that platform)
>     - clk_ipg_high would get reparented to imx->clk_per
>     - The recalc_rate(), round_rate(), and set_rate() would need to
> be implemented (and calculated) for clk_ipg_32k and clk_ipg_high

I didn't mean you should implement the PWM internal mux as clocks. This
is completely driver internal and it's not necessary to make them real
clocks.

> 
> Additionally, "ckil" would need to be added to the pwm entry for
> every dts file.

Yes, indeed. This way we do not rely on hardcoded values for ckil. ckil
is 32000Hz on some (admittedly older) SoCs.

So my suggestion is: Add ckil lookup to the pwm nodes of imx6qdl.dtsi,
do a clk_get(dev, "ckil") in the driver and use it when available.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
