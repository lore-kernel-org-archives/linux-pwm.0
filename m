From: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] pwm: mediatek: fix up PWM4 and PWM5 malfunction on MT7623
Date: Wed, 10 Jan 2018 00:10:04 +0800
Message-ID: <1515514204.31546.34.camel@mtkswgap22>
References: <7ddf36f5b9400b29578d4897ddea72c57c1c8d11.1514213639.git.sean.wang@mediatek.com>
 <0ebe339a-f40e-8567-e475-a0e671409777@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <0ebe339a-f40e-8567-e475-a0e671409777-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Zhi Mao <zhi.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, John Crispin <john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Tue, 2018-01-09 at 16:32 +0100, Matthias Brugger wrote:
> 
> On 12/25/2017 03:59 PM, sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org wrote:
> > From: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > 
> > Since the offset for both registers, PWMDWIDTH and PWMTHRES, used to
> > control PWM4 or PWM5 are distinct from the other PWMs, whose wrong
> > programming on PWM hardware causes waveform cannot be output as expected.
> > Thus, the patch adds the extra condition for fixing up the weird case to
> > let PWM4 or PWM5 able to work on MT7623.
> > 
> > Signed-off-by: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > Cc: Zhi Mao <zhi.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > Cc: John Crispin <john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org>
> > ---
> >  drivers/pwm/pwm-mediatek.c | 24 +++++++++++++++++++++---
> >  1 file changed, 21 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> > index f5d97e0..9311574 100644
> > --- a/drivers/pwm/pwm-mediatek.c
> > +++ b/drivers/pwm/pwm-mediatek.c
> > @@ -29,7 +29,9 @@
> >  #define PWMGDUR			0x0c
> >  #define PWMWAVENUM		0x28
> >  #define PWMDWIDTH		0x2c
> > +#define PWM45DWIDTH_QUIRK	0x30
> >  #define PWMTHRES		0x30
> > +#define PWM45THRES_QUIRK	0x34
> >  
> >  #define PWM_CLK_DIV_MAX		7
> >  
> > @@ -54,6 +56,7 @@ static const char * const mtk_pwm_clk_name[MTK_CLK_MAX] = {
> >  
> >  struct mtk_pwm_platform_data {
> >  	unsigned int num_pwms;
> > +	bool pwm45_quirk;
> >  };
> >  
> >  /**
> > @@ -66,6 +69,7 @@ struct mtk_pwm_chip {
> >  	struct pwm_chip chip;
> >  	void __iomem *regs;
> >  	struct clk *clks[MTK_CLK_MAX];
> > +	const struct mtk_pwm_platform_data *soc;
> >  };
> >  
> >  static const unsigned int mtk_pwm_reg_offset[] = {
> > @@ -131,7 +135,8 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> >  {
> >  	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
> >  	struct clk *clk = pc->clks[MTK_CLK_PWM1 + pwm->hwpwm];
> > -	u32 resolution, clkdiv = 0;
> > +	u32 resolution, clkdiv = 0, reg_width = PWMDWIDTH,
> > +	    reg_thres = PWMTHRES;
> >  	int ret;
> >  
> >  	ret = mtk_pwm_clk_enable(chip, pwm);
> > @@ -151,9 +156,18 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> >  		return -EINVAL;
> >  	}
> >  
> > +	if (pc->soc->pwm45_quirk && pwm->hwpwm > 2) {
> > +		/*
> > +		 * PWM[4,5] has distinct offset for PWMDWIDTH and PWMTHRES
> > +		 * from the other PWMs on MT7623.
> > +		 */
> > +		reg_width = PWM45DWIDTH_QUIRK;
> > +		reg_thres = PWM45THRES_QUIRK;
> > +	}
> > +
> >  	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
> > -	mtk_pwm_writel(pc, pwm->hwpwm, PWMDWIDTH, period_ns / resolution);
> > -	mtk_pwm_writel(pc, pwm->hwpwm, PWMTHRES, duty_ns / resolution);
> > +	mtk_pwm_writel(pc, pwm->hwpwm, reg_width, period_ns / resolution);
> > +	mtk_pwm_writel(pc, pwm->hwpwm, reg_thres, duty_ns / resolution);
> >  
> >  	mtk_pwm_clk_disable(chip, pwm);
> >  
> > @@ -211,6 +225,7 @@ static int mtk_pwm_probe(struct platform_device *pdev)
> >  	data = of_device_get_match_data(&pdev->dev);
> >  	if (data == NULL)
> >  		return -EINVAL;
> > +	pc->soc = data;
> >  
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	pc->regs = devm_ioremap_resource(&pdev->dev, res);
> > @@ -251,14 +266,17 @@ static int mtk_pwm_remove(struct platform_device *pdev)
> >  
> >  static const struct mtk_pwm_platform_data mt2712_pwm_data = {
> >  	.num_pwms = 8,
> > +	.pwm45_quirk = false,
> 
> Hm for me it doesn't look like a quirk but just the values a different. I wonder
> why you decided to add a quirk flag. 

actually, I also felt using quirk is not proper naming here. It should
be worth of better naming than the one to describe the hardware weird
case that only happens on PWM4 and PWM5. do you have idea what naming is
better?

> I'd added the access values to the
> mtk_pwm_platform_data struct directly.

do you mean should I add extra fields in struct mtk_pwm_platform to hold
its WIDTH and THRES for PWM4, and PWM5 value for each platform?

But these data aren't useful for the other platform, it would take one
more byte, and the extra conditional checked also cannot be saved. So,
I think to add one flag seems to produce the lesser penalty.

Regards,
> Matthias
> 
