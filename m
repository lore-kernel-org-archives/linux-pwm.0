From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v3 RESEND 07/11] pwm: imx: Provide atomic PWM support
 for i.MX PWMv2
Date: Wed, 4 Jan 2017 00:34:16 +0100
Message-ID: <20170104003416.286d99c6@bbrezillon>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
        <1482792961-12702-1-git-send-email-l.majewski@majess.pl>
        <1482792961-12702-8-git-send-email-l.majewski@majess.pl>
        <20161229172117.523a42a4@bbrezillon>
        <20161229174535.01b87fb7@jawa>
        <20161229180838.66ca218f@bbrezillon>
        <20170103124314.4c979807@jawa>
        <20170103134645.6496a193@bbrezillon>
        <7401088f38dc214449fe541e43185fda@agner.ch>
        <20170103203551.737e3a45@bbrezillon>
        <20170103230111.53154d49@jawa>
        <20170103231826.6d11e65e@bbrezillon>
        <20170103234658.2632350e@jawa>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170103234658.2632350e@jawa>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <lukma@denx.de>
Cc: Stefan Agner <stefan@agner.ch>, Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

On Tue, 3 Jan 2017 23:46:58 +0100
Lukasz Majewski <lukma@denx.de> wrote:

> > > > > >> > > > Same goes for the regression introduced in patch 2: I
> > > > > >> > > > think it's better to keep things bisectable on all
> > > > > >> > > > platforms (even if it appeared to work by chance on
> > > > > >> > > > imx7, it did work before this change).      
> > > > > >> > >
> > > > > >> > > Could you be more specific about your idea to solve this
> > > > > >> > > problem?      
> > > > > >> >
> > > > > >> > Stefan already provided a patch, I just think it should be
> > > > > >> > fixed before patch 2 to avoid breaking bisectibility.      
> > > > > >>
> > > > > >> My idea is as follows:
> > > > > >>
> > > > > >> I will drop patch v2 (prepared by Sasha) and then squash
> > > > > >> Stefan's patch [1] to patch 7/11. The "old" ipg enable code
> > > > > >> will be removed with other not needed code during
> > > > > >> conversion.      
> > > > > > 
> > > > > > How about keeping patch 2 but enabling/disabling the periph
> > > > > > clk in imx_pwm_config() instead of completely dropping the
> > > > > > enable/disable clk sequence.
> > > > > > 
> > > > > > In patch 7 you just add the logic we talked about earlier:
> > > > > > unconditionally enable the periph clk when entering the
> > > > > > imx_pwm_apply_v2() function and disable it before leaving the
> > > > > > function.
> > > > > > 
> > > > > > This way you can preserve bisectibility and still get rid of
> > > > > > the ipg clk.
> > > > > > 
> > > > > > Stefan, what's your opinion?      
> > > > > 
> > > > > We will get rid of the ipg clocks anyway in patch 8 (which
> > > > > removes those functions completely).
> > > > > 
> > > > > So I think Lukasz approach should be fine, just drop patch 2 and
> > > > > squash my patch into patch 7.    
> > > > 
> > > > Well, the end result will be same (ipg_clk will be gone after
> > > > patch 8), but then it's hard to track why this clock suddenly
> > > > disappeared. I still think it's worth adding an extra commit
> > > > explaining that enabling the per_clk before accessing IP
> > > > registers is needed on some platforms (imx7), and that IPG clk is
> > > > actually not required until we start using it as a source for the
> > > > PWM signal generation.
> > > > 
> > > > Maybe I'm the only one to think so. In this case, feel free to
> > > > drop patch 2.    
> > > 
> > > If you feel really bad about this issue, then we can drop patch 2
> > > and:
> > > 
> > > reorganize patch 7/11 to 
> > >  - keep code, which adds imx_pwm_apply_v2() function code (just
> > > moves it as is) 
> > >  - remove .apply = imx_pwm_apply_v2 entry from pwm_ops structure.
> > > 
> > > 
> > > On top of it add patch to enable/disable unconditionally the
> > > imx->clk_per clock to avoid problems on imx7 (and state them in
> > > commit message).
> > > 
> > > Then we add separate patch with 
> > > .apply = imx_pwm_apply_v2 to pwm_ops structure to enable "new"
> > > atomic approach.
> > > 
> > > And at last we apply patch 8/11, which removes the code for old (non
> > > atomic) behaviour.
> > > 
> > > All the issues are documented in this way on the cost of having
> > > "dead" (I mean not used) imx_pwm_apply_v2() for two commits.
> > >   
> > 
> > This looks even more complicated.
> > Sorry, but I don't see the problem with modifying patch 2 to enable
> > per_clk instead of ipg_clk. Can you explain what's bothering you?  
> 
> But in patch 2:
> "pwm: imx: remove ipg clock"
> 
>  we _remove_ the clk_ipg from imx_pwm_config() and imx_pwm_probe(), so
>  I'm quite puzzled with your above statement.

See my reworked version below.

> 
> > 
> > If you really want to do the change after patch 7, fine, but in this
> > case, keep the existing logic: enable/disable ipg_clk in
> > imx_pwm_apply_v2() until you drop the ipg_clk and replace the ipg_clk
> > enable/disable sequence by the equivalent enable/disable per_clk one.
> >   
> 
> Frankly, I do agree with Stefan here - we should drop patch 2, squash
> all changes (including imx7 clock issues) to patch 7 (including verbose
> commit message) and remove the non-atomic code in patch 8.

Hm, this is not like I'm asking something impossible here (see the
following patch).

--->8---
From c79bb872a40b8e322fd13f33f374fb1ba085e7a9 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 26 Dec 2016 23:55:52 +0100
Subject: [PATCH v4] pwm: imx: remove ipg clock and enable per clock when required

The use of the ipg clock was introduced with commit 7b27c160c681
("pwm: i.MX: fix clock lookup").
In the commit message it was claimed that the ipg clock is enabled for
register accesses. This is true for the ->config() callback, but not
for the ->set_enable() callback. Given that the ipg clock is not
consistently enabled for all register accesses we can assume that either
it is not required at all or that the current code does not work.
Remove the ipg clock code for now so that it's no longer in the way of
refactoring the driver.

In the other hand, the imx7 IP requires the peripheral clock to be
enabled before accessing its registers. Since ->config() can be called
when the PWM is disabled (in which case, the peripheral clock is also
disabled), we need to surround the imx->config() with
clk_prepare_enable(per_clk)/clk_disable_unprepare(per_clk) calls.

Note that the imx7 IP was working fine so far because the ipg clock was
actually pointing to the peripheral clock, which guaranteed peripheral
clock activation even when ->config() was called when the PWM was
disabled.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes in v4:
- Enable per clk before calling imx->config()

Changes in v3:
- New patch

 drivers/pwm/pwm-imx.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index d600fd5cd4ba..b1d1e50d3956 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -49,7 +49,6 @@
 
 struct imx_chip {
 	struct clk	*clk_per;
-	struct clk	*clk_ipg;
 
 	void __iomem	*mmio_base;
 
@@ -206,13 +205,13 @@ static int imx_pwm_config(struct pwm_chip *chip,
 	struct imx_chip *imx = to_imx_chip(chip);
 	int ret;
 
-	ret = clk_prepare_enable(imx->clk_ipg);
+	ret = clk_prepare_enable(imx->clk_per);
 	if (ret)
 		return ret;
 
 	ret = imx->config(chip, pwm, duty_ns, period_ns);
 
-	clk_disable_unprepare(imx->clk_ipg);
+	clk_disable_unprepare(imx->clk_per);
 
 	return ret;
 }
@@ -293,13 +292,6 @@ static int imx_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(imx->clk_per);
 	}
 
-	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
-	if (IS_ERR(imx->clk_ipg)) {
-		dev_err(&pdev->dev, "getting ipg clock failed with %ld\n",
-				PTR_ERR(imx->clk_ipg));
-		return PTR_ERR(imx->clk_ipg);
-	}
-
 	imx->chip.ops = &imx_pwm_ops;
 	imx->chip.dev = &pdev->dev;
 	imx->chip.base = -1;
-- 
2.7.4
