From: Zhi Mao <zhi.mao@mediatek.com>
Subject: Re: [PATCH RESEND 2/4] pwm: mediatek: fix clk issue
Date: Thu, 22 Jun 2017 20:48:07 +0800
Message-ID: <1498135687.18841.29.camel@mhfsdcap03>
References: <1498032672-7172-1-git-send-email-zhi.mao@mediatek.com>
         <1498032672-7172-3-git-send-email-zhi.mao@mediatek.com>
         <046facdc-b558-146a-dcfd-0ed98bfeb517@phrozen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <046facdc-b558-146a-dcfd-0ed98bfeb517@phrozen.org>
Sender: linux-kernel-owner@vger.kernel.org
To: John Crispin <john@phrozen.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Zhenbao Liu =?UTF-8?Q?=28=E5=88=98=E6=8C=AF=E5=AE=9D=29?= <Zhenbao.Liu@mediatek.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>, Sean Wang =?UTF-8?Q?=28=E7=8E=8B=E5=BF=97=E4=BA=98=29?= <sean.wang@mediatek.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, YT Shen =?UTF-8?Q?=28=E6=B2=88=E5=B2=B3=E9=9C=86=29?= <Yt.Shen@mediatek.com>, Yingjoe
List-Id: linux-pwm@vger.kernel.org

On Wed, 2017-06-21 at 20:07 +0800, John Crispin wrote:
> Hi
> 
> comments inline
> 
> 
> > +static int mtk_pwm_clk_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> > +{

> > +	ret = clk_prepare_enable(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
> > +	if (ret < 0) {
> > +		clk_disable_unprepare(pc->clks[MTK_CLK_MAIN]);
> > +		clk_disable_unprepare(pc->clks[MTK_CLK_TOP]);
> > +		return ret;
> > +	}
> > +
> Rather than disabling the already prepared clks in each error path and 
> then returning, you should use goto err_clk_{top,main,pwm1} in the same 
> style as what this patch removes from mtk_pwm_probe()
> 
> > +	return ret;
> > +}

> >   static inline u32 mtk_pwm_readl(struct mtk_pwm_chip *chip, unsigned int num,
> >   				unsigned int offset)
> >   {

> > @@ -91,10 +128,12 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> >   	if (clkdiv > 7)
> >   		return -EINVAL;
> >   
> > -	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | BIT(3) | clkdiv);
> > +	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
> 
> this chunk needs to go into its own patch
> 

> >   
> > @@ -102,11 +141,8 @@ static int mtk_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> >   {
> >   
> > -	ret = clk_prepare(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
> > -	if (ret < 0)
> > -		return ret;
> > +	mtk_pwm_clk_enable(chip, pwm);
> You need to check the error code here and return if clk enabling failed
> 

<....>
Hi John,
For these above comments, I will modified as your suggestions in the
next release.

> > 
> >   
> >   static int mtk_pwm_remove(struct platform_device *pdev)
> >   {
> >   	struct mtk_pwm_chip *pc = platform_get_drvdata(pdev);
> > -	unsigned int i;
> > -
> > -	for (i = 0; i < pc->chip.npwm; i++)
> > -		pwm_disable(&pc->chip.pwms[i]);
> why are you removing this chunk ?
> 
>      John
> 

After refering to some other vendor's pwm driver, we think the
"pwm_disable" is no need, and framework control flow should disable all
the pwms before removing them,
so we remove it.

Regards,
Zhi

> >   
> >   	return pwmchip_remove(&pc->chip);
> >   }
> 
