From: Zhi Mao <zhi.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3 2/6] pwm: mediatek: fix pwm source clock selection
Date: Thu, 6 Jul 2017 14:16:41 +0800
Message-ID: <1499321801.22478.12.camel@mhfsdcap03>
References: <1498802721-32455-1-git-send-email-zhi.mao@mediatek.com>
         <1498802721-32455-3-git-send-email-zhi.mao@mediatek.com>
         <d009712e-f0a2-2dc7-2f64-ad8cfa21f98d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d009712e-f0a2-2dc7-2f64-ad8cfa21f98d-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, zhenbao.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Wed, 2017-07-05 at 13:09 +0200, Matthias Brugger wrote:
> 
> On 06/30/2017 08:05 AM, Zhi Mao wrote:
> > In original code, the pwm output frequency is not correct
> > when set bit<3>=1 to PWMCON register.
> > 
> > Signed-off-by: Zhi Mao <zhi.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >   drivers/pwm/pwm-mediatek.c |    2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> > index 5c11bc7..d08b5b3 100644
> > --- a/drivers/pwm/pwm-mediatek.c
> > +++ b/drivers/pwm/pwm-mediatek.c
> > @@ -91,7 +91,7 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> >   	if (clkdiv > 7)
> >   		return -EINVAL;
> >   
> > -	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | BIT(3) | clkdiv);
> > +	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
> 
> Just for clarification, BIT(15) enables old PWM mode, which ignores 
> CLKSEL (BIT(3)). Therefore setting BIT(3) does not have any effect and 
> can be discarded.
> 
> Am I correct? I took mt7623n datasheet for reference.
> 
> Regards,
> Matthias
> 
Yes, remove setting bit<3> will not take any effect. 
PWMCON bit<3> is pwm source clock selecting register.
You can check the datasheet of MT7623 for details.

Regards
Zhi

> >   	mtk_pwm_writel(pc, pwm->hwpwm, PWMDWIDTH, period_ns / resolution);
> >   	mtk_pwm_writel(pc, pwm->hwpwm, PWMTHRES, duty_ns / resolution);
> >   
> > 


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
