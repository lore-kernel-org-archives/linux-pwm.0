From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v3 3/6] pwm: imx: support output polarity inversion
Date: Sat, 22 Oct 2016 14:01:18 +0200
Message-ID: <20161022140118.7a6cb583@bbrezillon>
References: <20161007151129.6043-1-bhuvanchandra.dv@toradex.com>
        <20161007151129.6043-4-bhuvanchandra.dv@toradex.com>
        <5325a332099473a2d8382530f79c5a8e@agner.ch>
        <20161013001540.7f759158@jawa>
        <ff9ba34df2729204c617685dd26ea625@agner.ch>
        <20161013065812.0da91859@jawa>
        <20161020103018.44fb94ea@jawa>
        <1b72dcbc9a021e6fa3aef62f63bbf93f@agner.ch>
        <20161021234939.1a4f51f4@jawa>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from up.free-electrons.com ([163.172.77.33]:45850 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932718AbcJVMBY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 22 Oct 2016 08:01:24 -0400
In-Reply-To: <20161021234939.1a4f51f4@jawa>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lukasz Majewski <l.majewski@majess.pl>
Cc: Stefan Agner <stefan@agner.ch>, thierry.reding@gmail.com, mark.rutland@arm.com, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, robh+dt@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, Lothar Wassmann <LW@karo-electronics.de>

On Fri, 21 Oct 2016 23:49:39 +0200
Lukasz Majewski <l.majewski@majess.pl> wrote:

> Hi Stefan,
> 
> > On 2016-10-20 01:30, Lukasz Majewski wrote:  
> > > Hi Stefan,
> > >   
> > >> Hi Stefan,
> > >>  
> > >> > On 2016-10-12 15:15, Lukasz Majewski wrote:  
> > >> > > Hi Stefan,
> > >> > >  
> > >> > >> On 2016-10-07 08:11, Bhuvanchandra DV wrote:  
> > >> > >> > From: Lothar Wassmann <LW@KARO-electronics.de>
> > >> > >> >
> > >> > >> > The i.MX pwm unit on i.MX27 and newer SoCs provides a
> > >> > >> > configurable output polarity. This patch adds support to
> > >> > >> > utilize this feature where available.
> > >> > >> >
> > >> > >> > Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>
> > >> > >> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > >> > >> > Signed-off-by: Bhuvanchandra DV
> > >> > >> > <bhuvanchandra.dv@toradex.com> Acked-by: Shawn Guo
> > >> > >> > <shawn.guo@linaro.org> Reviewed-by: Sascha Hauer
> > >> > >> > <s.hauer@pengutronix.de> ---
> > >> > >> >  Documentation/devicetree/bindings/pwm/imx-pwm.txt |  6 +--
> > >> > >> >  drivers/pwm/pwm-imx.c                             | 51
> > >> > >> > +++++++++++++++++++++-- 2 files changed, 51 insertions(+), 6
> > >> > >> > deletions(-)
> > >> > >> >
> > >> > >> > diff --git
> > >> > >> > a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> > >> > >> > b/Documentation/devicetree/bindings/pwm/imx-pwm.txt index
> > >> > >> > e00c2e9..c61bdf8 100644 ---
> > >> > >> > a/Documentation/devicetree/bindings/pwm/imx-pwm.txt +++
> > >> > >> > b/Documentation/devicetree/bindings/pwm/imx-pwm.txt @@ -6,8
> > >> > >> > +6,8 @@ Required properties:
> > >> > >> >    - "fsl,imx1-pwm" for PWM compatible with the one
> > >> > >> > integrated on i.MX1
> > >> > >> >    - "fsl,imx27-pwm" for PWM compatible with the one
> > >> > >> > integrated on i.MX27
> > >> > >> >  - reg: physical base address and length of the controller's
> > >> > >> > registers -- #pwm-cells: should be 2. See pwm.txt in this
> > >> > >> > directory for a description of
> > >> > >> > -  the cells format.
> > >> > >> > +- #pwm-cells: 2 for i.MX1 and 3 for i.MX27 and newer SoCs.
> > >> > >> > See pwm.txt
> > >> > >> > +  in this directory for a description of the cells format.
> > >> > >> >  - clocks : Clock specifiers for both ipg and per clocks.
> > >> > >> >  - clock-names : Clock names should include both "ipg" and
> > >> > >> > "per" See the clock consumer binding,
> > >> > >> > @@ -17,7 +17,7 @@ See the clock consumer binding,
> > >> > >> >  Example:
> > >> > >> >
> > >> > >> >  pwm1: pwm@53fb4000 {
> > >> > >> > -	#pwm-cells = <2>;
> > >> > >> > +	#pwm-cells = <3>;
> > >> > >> >  	compatible = "fsl,imx53-pwm", "fsl,imx27-pwm";
> > >> > >> >  	reg = <0x53fb4000 0x4000>;
> > >> > >> >  	clocks = <&clks IMX5_CLK_PWM1_IPG_GATE>,
> > >> > >> > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > >> > >> > index d600fd5..c37d223 100644
> > >> > >> > --- a/drivers/pwm/pwm-imx.c
> > >> > >> > +++ b/drivers/pwm/pwm-imx.c
> > >> > >> > @@ -38,6 +38,7 @@
> > >> > >> >  #define MX3_PWMCR_DOZEEN		(1 << 24)
> > >> > >> >  #define MX3_PWMCR_WAITEN		(1 << 23)
> > >> > >> >  #define MX3_PWMCR_DBGEN			(1 << 22)
> > >> > >> > +#define MX3_PWMCR_POUTC			(1 << 18)
> > >> > >> >  #define MX3_PWMCR_CLKSRC_IPG_HIGH	(2 << 16)
> > >> > >> >  #define MX3_PWMCR_CLKSRC_IPG		(1 << 16)
> > >> > >> >  #define MX3_PWMCR_SWR			(1 << 3)
> > >> > >> > @@ -180,6 +181,9 @@ static int imx_pwm_config_v2(struct
> > >> > >> > pwm_chip *chip, if (enable)
> > >> > >> >  		cr |= MX3_PWMCR_EN;
> > >> > >> >
> > >> > >> > +	if (pwm->args.polarity == PWM_POLARITY_INVERSED)
> > >> > >> > +		cr |= MX3_PWMCR_POUTC;
> > >> > >> > +  
> > >> > >>
> > >> > >> This seems wrong to me, the config callback is meant for
> > >> > >> period/duty cycle only.  
> > > 
> > > Unfortunately, it also resets the PWM IP block and setups it again
> > > (by writing to PWMCR register). In that function we setup for
> > > example MX3_PWMCR_DOZEEN
> > > and MX3_PWMCR_DBGEN. Why cannot we setup polarity as well?
> > > 
> > > 
> > > I've double checked the backlight and pwm code flow.
> > > 
> > > Please find following snippet:
> > > 
> > > [    0.135545] ######### imx_pwm_probe
> > > [    0.135581] PWM supports output inversion
> > > [    0.136864] ######### pwm_backlight_probe
> > > [    0.136913] backlight supply power not found, using dummy
> > > regulator [    0.136984] ######### imx_pwm_set_polarity 1
> > > [    0.136995] imx_pwm_set_polarity: polarity set to inverted cr:
> > > 0x40000 0xf08f8000
> > > [    0.137005] #########0 imx_pwm_config_v2 cr: 0x40000 
> > > [    0.137683] #########1 imx_pwm_config_v2 cr: 0x0 0xf08f8000
> > > [    0.137693] #########2 imx_pwm_config_v2 cr: 0x1c20050
> > > [    0.137702] #########3 imx_pwm_config_v2 cr: 0x1c20050 0xf08f8000
> > > [    0.137711] @@@@@@@@@@ pwm_apply_state  
> 
> Maybe a bit more logs:
> 
> [    0.135451] ######### imx_pwm_probe
> [    0.135488] PWM supports output inversion
> [    0.136777] ######### pwm_backlight_probe
> [    0.136826] backlight supply power not found, using dummy regulator
> [    0.136893] ********* pwm_apply_state state->enabled: 0
> [    0.136902] ######### imx_pwm_set_polarity 1
> [    0.136913] imx_pwm_set_polarity: polarity set to inverted cr: 0x40000 0xf08f8000
> [    0.136923] #########0 imx_pwm_config_v2 cr: 0x40000
> [    0.137692] #########1 imx_pwm_config_v2 cr: 0x0 0xf08f8000
> [    0.137701] #########2 imx_pwm_config_v2 cr: 0x1c20050
> [    0.137710] #########3 imx_pwm_config_v2 cr: 0x1c20050 0xf08f8000
> [    0.137720] @@@@@@@@@@ pwm_apply_state
> [    0.137856] ********* pwm_apply_state state->enabled: 0
> [    0.137869] #########0 imx_pwm_config_v2 cr: 0x1c20050
> [    0.138904] #########1 imx_pwm_config_v2 cr: 0x0 0xf08f8000
> [    0.138913] #########2 imx_pwm_config_v2 cr: 0x1c20050
> [    0.138921] #########3 imx_pwm_config_v2 cr: 0x1c20050 0xf08f8000
> [    0.138928] @@@@@@@@@@ pwm_apply_state
> [    0.138940] ********* pwm_apply_state state->enabled: 1
> 					 ^^^^^^^^^^^^^^^^^^ this is called from
> 			pwm_backlight_power_on() from pwm_bl probe function
> 
> The problem here is not the lack of ->apply() callback, but the requirement to
> perform software reset on the pwm_v2 fifo when the pwm_v2 is NOT enabled (state->enabled: 0).
> 
> As fair as I can see the pwm_state has following members: period, duty cycle, polarity and enabled.
> I'm fine to implement ->apply() callback, which would change above values.
> 
> However, there is a problem with ->config() (imx_pwm_config_v2 @ pwm-imx.c) and imx pwm_v2 software
> FIFO reset.
> We can set polarity in any other kernel subsystem, which uses PWM (backlight in this example) and 
> then this setting would disappear when we call pwm_apply_state with state->enabled = 0 (as presented
> in the log). This imposes setting polarity at ->config when we enable the PWM (as this patch does).
> 
> 
> 
> > > 
> > > Here the pwm_backlight_probe calls set_polarity callback available
> > > in pwm - the polarity is set (the 0x40000 value).
> > > 
> > > The above operation is performed in pwm_apply_state (@
> > > drivers/pwm/core.c). In the same function, latter we call the
> > > pwm->chip->ops->config(), which is the pointer to config_v2.
> > > Since the PWM is not yet enabled, this function performs SW reset
> > > and PWM inversion setting is cleared.  
> > 
> > That function should not do that.   
> 
> I do agree that it shouldn't. Correct me if I'm wrong, but it seems like an 
> PWM HW requirement to perform the reset.
> 
> >It was probably already problematic
> > in the old times, it is definitely now with the atomic PWM stuff.  
> 
> The "atomic"[*] code (with ->apply() provided) will not solve this issue.
> 
> >   
> > > 
> > > Possible solutions:
> > > 
> > > 1. Leave the original patch from Bhuvanchandra as it was (I'm for
> > > this option)  
> > 
> > That really seems like a hack to me, and makes transition to the
> > atomic PWM API more complex.  
> 
> Could you be more specific here? 
> 
> As I mentioned before, the problem is not with the lack of
> "atomic" API.

Below is a quick and dirty I made on top of this patch to show you how
atomic update can be implemented in this driver. It's not tested, and
probably not working, but it should give you a better idea of what is
expected.

--->8---
From f4dc9a368a951b619a9c67791cb9515ca70da0ee Mon Sep 17 00:00:00 2001
From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Sat, 22 Oct 2016 13:55:19 +0200
Subject: [PATCH] pwm: imx: switch to the atomic interface and related cleanup

This is just a crappy commit to show you how atomic update can be
implemented. Please do not submit the changes as is.

This commit is based on https://lkml.org/lkml/2016/10/7/454.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/pwm-imx.c | 262 +++++++++++++++++++++++---------------------------
 1 file changed, 119 insertions(+), 143 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index c37d22371848..c6d55f92dc40 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -66,8 +66,6 @@ struct imx_chip {
 static int imx_pwm_config_v1(struct pwm_chip *chip,
 		struct pwm_device *pwm, int duty_ns, int period_ns)
 {
-	struct imx_chip *imx = to_imx_chip(chip);
-
 	/*
 	 * The PWM subsystem allows for exact frequencies. However,
 	 * I cannot connect a scope on my device to the PWM line and
@@ -85,81 +83,118 @@ static int imx_pwm_config_v1(struct pwm_chip *chip,
 	 * both the prescaler (/1 .. /128) and then by CLKSEL
 	 * (/2 .. /16).
 	 */
+	struct imx_chip *imx = to_imx_chip(chip);
 	u32 max = readl(imx->mmio_base + MX1_PWMP);
 	u32 p = max * duty_ns / period_ns;
+	int ret;
+
+	ret = clk_prepare_enable(imx->clk_ipg);
+	if (ret)
+		return ret;
+
 	writel(max - p, imx->mmio_base + MX1_PWMS);
 
+	clk_disable_unprepare(imx->clk_ipg);
+
 	return 0;
 }
 
-static void imx_pwm_set_enable_v1(struct pwm_chip *chip, bool enable)
+static int imx_pwm_enable_v1(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct imx_chip *imx = to_imx_chip(chip);
+	int ret;
 	u32 val;
 
+	ret = clk_prepare_enable(imx->clk_ipg);
+	if (ret)
+		return ret;
+
 	val = readl(imx->mmio_base + MX1_PWMC);
 
-	if (enable)
-		val |= MX1_PWMC_EN;
-	else
-		val &= ~MX1_PWMC_EN;
+	val |= MX1_PWMC_EN;
 
 	writel(val, imx->mmio_base + MX1_PWMC);
+
+	clk_disable_unprepare(imx->clk_per);
+
+	return 0;
 }
 
-static int imx_pwm_config_v2(struct pwm_chip *chip,
-		struct pwm_device *pwm, int duty_ns, int period_ns)
+static void imx_pwm_disable_v1(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct imx_chip *imx = to_imx_chip(chip);
+	u32 val;
+
+	val = readl(imx->mmio_base + MX1_PWMC);
+
+	val &= ~MX1_PWMC_EN;
+
+	writel(val, imx->mmio_base + MX1_PWMC);
+
+	clk_disable_unprepare(imx->clk_per);
+}
+
+static void imx_pwm_wait_fifo_slot(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct imx_chip *imx = to_imx_chip(chip);
 	struct device *dev = chip->dev;
-	unsigned long long c;
-	unsigned long period_cycles, duty_cycles, prescale;
 	unsigned int period_ms;
-	bool enable = pwm_is_enabled(pwm);
-	int wait_count = 0, fifoav;
-	u32 cr, sr;
+	int fifoav;
+	u32 sr;
+
+	sr = readl(imx->mmio_base + MX3_PWMSR);
+	fifoav = sr & MX3_PWMSR_FIFOAV_MASK;
+	if (fifoav == MX3_PWMSR_FIFOAV_4WORDS) {
+		period_ms = DIV_ROUND_UP(pwm_get_period(pwm),
+					 NSEC_PER_MSEC);
+		msleep(period_ms);
 
-	/*
-	 * i.MX PWMv2 has a 4-word sample FIFO.
-	 * In order to avoid FIFO overflow issue, we do software reset
-	 * to clear all sample FIFO if the controller is disabled or
-	 * wait for a full PWM cycle to get a relinquished FIFO slot
-	 * when the controller is enabled and the FIFO is fully loaded.
-	 */
-	if (enable) {
 		sr = readl(imx->mmio_base + MX3_PWMSR);
-		fifoav = sr & MX3_PWMSR_FIFOAV_MASK;
-		if (fifoav == MX3_PWMSR_FIFOAV_4WORDS) {
-			period_ms = DIV_ROUND_UP(pwm_get_period(pwm),
-						 NSEC_PER_MSEC);
-			msleep(period_ms);
-
-			sr = readl(imx->mmio_base + MX3_PWMSR);
-			if (fifoav == (sr & MX3_PWMSR_FIFOAV_MASK))
-				dev_warn(dev, "there is no free FIFO slot\n");
-		}
-	} else {
-		writel(MX3_PWMCR_SWR, imx->mmio_base + MX3_PWMCR);
-		do {
-			usleep_range(200, 1000);
-			cr = readl(imx->mmio_base + MX3_PWMCR);
-		} while ((cr & MX3_PWMCR_SWR) &&
-			 (wait_count++ < MX3_PWM_SWR_LOOP));
-
-		if (cr & MX3_PWMCR_SWR)
-			dev_warn(dev, "software reset timeout\n");
+		if (fifoav == (sr & MX3_PWMSR_FIFOAV_MASK))
+			dev_warn(dev, "there is no free FIFO slot\n");
 	}
+}
+
+static void imx_pwm_empty_fifo(struct pwm_chip *chip)
+{
+	struct imx_chip *imx = to_imx_chip(chip);
+	struct device *dev = chip->dev;
+	int wait_count = 0;
+	u32 cr;
+
+	writel(MX3_PWMCR_SWR, imx->mmio_base + MX3_PWMCR);
+	do {
+		usleep_range(200, 1000);
+		cr = readl(imx->mmio_base + MX3_PWMCR);
+	} while ((cr & MX3_PWMCR_SWR) &&
+		 (wait_count++ < MX3_PWM_SWR_LOOP));
+
+	if (cr & MX3_PWMCR_SWR)
+		dev_warn(dev, "software reset timeout\n");
+}
+
+static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
+			    struct pwm_state *state)
+{
+	struct imx_chip *imx = to_imx_chip(chip);
+	unsigned long long c;
+	unsigned long period_cycles, duty_cycles, prescale;
+	struct pwm_state cstate;
+	int ret;
+	u32 cr = 0;
+
+	pwm_get_state(pwm, &cstate);
 
 	c = clk_get_rate(imx->clk_per);
-	c = c * period_ns;
+	c = c * state->period;
 	do_div(c, 1000000000);
 	period_cycles = c;
 
 	prescale = period_cycles / 0x10000 + 1;
 
 	period_cycles /= prescale;
-	c = (unsigned long long)period_cycles * duty_ns;
-	do_div(c, period_ns);
+	c = (unsigned long long)period_cycles * state->duty_cycle;
+	do_div(c, state->period);
 	duty_cycles = c;
 
 	/*
@@ -171,134 +206,72 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
 	else
 		period_cycles = 0;
 
-	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
-	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
-
-	cr = MX3_PWMCR_PRESCALER(prescale) |
-		MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
-		MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC_IPG_HIGH;
-
-	if (enable)
-		cr |= MX3_PWMCR_EN;
-
-	if (pwm->args.polarity == PWM_POLARITY_INVERSED)
-		cr |= MX3_PWMCR_POUTC;
-
-	writel(cr, imx->mmio_base + MX3_PWMCR);
-
-	return 0;
-}
-
-static void imx_pwm_set_enable_v2(struct pwm_chip *chip, bool enable)
-{
-	struct imx_chip *imx = to_imx_chip(chip);
-	u32 val;
-
-	val = readl(imx->mmio_base + MX3_PWMCR);
-
-	if (enable)
-		val |= MX3_PWMCR_EN;
-	else
-		val &= ~MX3_PWMCR_EN;
-
-	writel(val, imx->mmio_base + MX3_PWMCR);
-}
-
-static int imx_pwm_config(struct pwm_chip *chip,
-		struct pwm_device *pwm, int duty_ns, int period_ns)
-{
-	struct imx_chip *imx = to_imx_chip(chip);
-	int ret;
-
-	ret = clk_prepare_enable(imx->clk_ipg);
-	if (ret)
-		return ret;
-
-	ret = imx->config(chip, pwm, duty_ns, period_ns);
-
-	clk_disable_unprepare(imx->clk_ipg);
-
-	return ret;
-}
-
-static int imx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct imx_chip *imx = to_imx_chip(chip);
-	int ret;
-
 	ret = clk_prepare_enable(imx->clk_per);
 	if (ret)
 		return ret;
 
-	imx->set_enable(chip, true);
-
-	return 0;
-}
+	/* Enable the clock if the PWM is being enabled. */
+	if (state->enabled && !cstate.enabled) {
+		ret = clk_prepare_enable(imx->clk_per);
+		if (ret)
+			return ret;
+	}
 
-static void imx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct imx_chip *imx = to_imx_chip(chip);
+	/*
+	 * Wait for a free FIFO slot if the PWM is already enabled, and flush
+	 * the FIFO if the PWM was disabled and is about to be enabled.
+	 */
+	if (cstate.enabled)
+		imx_pwm_wait_fifo_slot(chip, pwm);
+	else if (state->enabled)
+		imx_pwm_empty_fifo(chip);
 
-	imx->set_enable(chip, false);
+	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
+	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
 
-	clk_disable_unprepare(imx->clk_per);
-}
+	cr |= MX3_PWMCR_PRESCALER(prescale) |
+	      MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
+	      MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC_IPG_HIGH;
 
-static int imx_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
-				enum pwm_polarity polarity)
-{
-	struct imx_chip *imx = to_imx_chip(chip);
-	u32 val;
+	if (state->enabled)
+		cr |= MX3_PWMCR_EN;
 
-	if (polarity == pwm->args.polarity)
-		return 0;
+	if (state->polarity == PWM_POLARITY_INVERSED)
+		cr |= MX3_PWMCR_POUTC;
 
-	val = readl(imx->mmio_base + MX3_PWMCR);
 
-	if (polarity == PWM_POLARITY_INVERSED)
-		val |= MX3_PWMCR_POUTC;
-	else
-		val &= ~MX3_PWMCR_POUTC;
+	writel(cr, imx->mmio_base + MX3_PWMCR);
 
-	writel(val, imx->mmio_base + MX3_PWMCR);
+	/* Disable the clock if the PWM is being disabled. */
+	if (!state->enabled && cstate.enabled)
+		clk_disable_unprepare(imx->clk_per);
 
-	dev_dbg(imx->chip.dev, "%s: polarity set to %s\n", __func__,
-		polarity == PWM_POLARITY_INVERSED ? "inverted" : "normal");
+	clk_disable_unprepare(imx->clk_per);
 
 	return 0;
 }
 
 static struct pwm_ops imx_pwm_ops_v1 = {
-	.enable = imx_pwm_enable,
-	.disable = imx_pwm_disable,
-	.config = imx_pwm_config,
+	.enable = imx_pwm_enable_v1,
+	.disable = imx_pwm_disable_v1,
+	.config = imx_pwm_config_v1,
 	.owner = THIS_MODULE,
 };
 
 static struct pwm_ops imx_pwm_ops_v2 = {
-	.enable = imx_pwm_enable,
-	.disable = imx_pwm_disable,
-	.set_polarity = imx_pwm_set_polarity,
-	.config = imx_pwm_config,
+	.apply = imx_pwm_apply_v2,
 	.owner = THIS_MODULE,
 };
 
 struct imx_pwm_data {
-	int (*config)(struct pwm_chip *chip,
-		struct pwm_device *pwm, int duty_ns, int period_ns);
-	void (*set_enable)(struct pwm_chip *chip, bool enable);
 	struct pwm_ops *pwm_ops;
 };
 
 static struct imx_pwm_data imx_pwm_data_v1 = {
-	.config = imx_pwm_config_v1,
-	.set_enable = imx_pwm_set_enable_v1,
 	.pwm_ops = &imx_pwm_ops_v1,
 };
 
 static struct imx_pwm_data imx_pwm_data_v2 = {
-	.config = imx_pwm_config_v2,
-	.set_enable = imx_pwm_set_enable_v2,
 	.pwm_ops = &imx_pwm_ops_v2,
 };
 
@@ -317,6 +290,7 @@ static int imx_pwm_probe(struct platform_device *pdev)
 	struct imx_chip *imx;
 	struct resource *r;
 	int ret = 0;
+	u32 cells;
 
 	if (!of_id)
 		return -ENODEV;
@@ -346,7 +320,12 @@ static int imx_pwm_probe(struct platform_device *pdev)
 	imx->chip.base = -1;
 	imx->chip.npwm = 1;
 	imx->chip.can_sleep = true;
-	if (data->pwm_ops->set_polarity) {
+
+	ret = of_property_read_u32(pdev->dev.of_node, "#pwm-cells", &cells);
+	if (ret)
+		return ret;
+
+	if (cells == 3) {
 		dev_dbg(&pdev->dev, "PWM supports output inversion\n");
 		imx->chip.of_xlate = of_pwm_xlate_with_flags;
 		imx->chip.of_pwm_n_cells = 3;
@@ -357,9 +336,6 @@ static int imx_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(imx->mmio_base))
 		return PTR_ERR(imx->mmio_base);
 
-	imx->config = data->config;
-	imx->set_enable = data->set_enable;
-
 	ret = pwmchip_add(&imx->chip);
 	if (ret < 0)
 		return ret;
-- 
2.7.4
