From: Zhi Mao <zhi.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 5/6] pwm: mediatek: add PWM_CLK_DIV_MAX
Date: Tue, 27 Jun 2017 10:50:15 +0800
Message-ID: <1498531815.22478.3.camel@mhfsdcap03>
References: <1498194505-30930-1-git-send-email-zhi.mao@mediatek.com>
         <1498194505-30930-6-git-send-email-zhi.mao@mediatek.com>
         <8eaabcb6-c7b1-efcc-7dae-967a38feb8f1@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8eaabcb6-c7b1-efcc-7dae-967a38feb8f1-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: m18063 <Claudiu.Beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Cc: john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zhenbao.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Mon, 2017-06-26 at 11:43 +0300, m18063 wrote:
> 
> On 23.06.2017 08:08, Zhi Mao wrote:
> > Replace "7" with "PWM_CLK_DIV_MAX" in function:mtk_pwm_config()
> > to improve the code readablity.
> > 
> > Signed-off-by: Zhi Mao <zhi.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  drivers/pwm/pwm-mediatek.c |    6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> > index 554a042..e5f6425 100644
> > --- a/drivers/pwm/pwm-mediatek.c
> > +++ b/drivers/pwm/pwm-mediatek.c
> > @@ -30,6 +30,8 @@
> >  #define PWMDWIDTH		0x2c
> >  #define PWMTHRES		0x30
> >  
> > +#define PWM_CLK_DIV_MAX		7
> > +
> >  enum {
> >  	MTK_CLK_MAIN = 0,
> >  	MTK_CLK_TOP,
> > @@ -130,8 +132,10 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> >  		clkdiv++;
> >  	}
> >  
> > -	if (clkdiv > 7)
> > +	if (clkdiv > PWM_CLK_DIV_MAX) {
> You forgot to:
> 		mtk_pwm_clk_disable(chip, pwm);
Hi Claudiu,

Thanks for your suggestion.
It's a problem, I will modify this in the next release.

Regards,
Zhi
> > +		dev_err(chip->dev, "period %d not supported\n", period_ns);
> >  		return -EINVAL;
> > +	}
> >  
> >  	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
> >  	mtk_pwm_writel(pc, pwm->hwpwm, PWMDWIDTH, period_ns / resolution);
> > 


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
