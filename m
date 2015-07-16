From: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v5 2/3] pwm: add MediaTek display PWM driver support
Date: Fri, 17 Jul 2015 00:44:10 +0800
Message-ID: <1437065050.11063.26.camel@mtksdaap41>
References: <1436778294-47635-1-git-send-email-yh.huang@mediatek.com>
	 <1436778294-47635-3-git-send-email-yh.huang@mediatek.com>
	 <CAGS+omCx4mDAN+F315x+8FeCABcKDoMn1gm_nHzF6VXnF_xm8Q@mail.gmail.com>
	 <1436975995.15774.27.camel@mtksdaap41>
	 <1437025108.18175.13.camel@mtksdaap41>
	 <CAGS+omB1FCX12-KvU7ODywseFKgsAbzNtqNyYZ+PqvO5ZeEn-A@mail.gmail.com>
	 <1437031079.8107.13.camel@mtksdaap41>
	 <CAGS+omAzPqDFzsJCiBV3=Zite2FS2no-P1F8EOSHu7w9LrN3cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGS+omAzPqDFzsJCiBV3=Zite2FS2no-P1F8EOSHu7w9LrN3cg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "open list:OPEN FIRMWARE AND..." <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Thu, 2015-07-16 at 23:21 +0800, Daniel Kurtz wrote:
> On Thu, Jul 16, 2015 at 3:17 PM, YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> > On Thu, 2015-07-16 at 14:54 +0800, Daniel Kurtz wrote:
> >> On Thu, Jul 16, 2015 at 1:38 PM, YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> >> > On Wed, 2015-07-15 at 23:59 +0800, YH Huang wrote:
> >> >> On Mon, 2015-07-13 at 18:19 +0800, Daniel Kurtz wrote:
> >> >> > On Mon, Jul 13, 2015 at 5:04 PM, YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> >> >> > > +#ifdef CONFIG_PM_SLEEP
> >> >> > > +static int mtk_disp_pwm_suspend(struct device *dev)
> >> >> > > +{
> >> >> > > +       struct mtk_disp_pwm *mdp = dev_get_drvdata(dev);
> >> >> > > +
> >> >> > > +       clk_disable_unprepare(mdp->clk_main);
> >> >> > > +       clk_disable_unprepare(mdp->clk_mm);
> >> >> > > +
> >> >> > > +       return 0;
> >> >> > > +}
> >> >> > > +
> >> >> > > +static int mtk_disp_pwm_resume(struct device *dev)
> >> >> > > +{
> >> >> > > +       struct mtk_disp_pwm *mdp = dev_get_drvdata(dev);
> >> >> > > +       int ret;
> >> >> > > +
> >> >> > > +       ret = clk_prepare_enable(mdp->clk_main);
> >> >> > > +       if (ret < 0)
> >> >> > > +               return ret;
> >> >> > > +
> >> >> > > +       ret = clk_prepare_enable(mdp->clk_mm);
> >> >> > > +       if (ret < 0) {
> >> >> > > +               clk_disable_unprepare(mdp->clk_main);
> >> >> > > +               return ret;
> >> >> > > +       }
> >> >> > > +
> >> >> >
> >> >> > Don't you also have to restore the PWM rate and frequency?
> >> >> >
> >> >> > Is it possible to save power at runtime by leaving mdp->clk_mm enabled
> >> >> > (to generate the PWM signal), but disable mdp->clk_main (clock
> >> >> > required to access PWM registers)?
> >> >>
> >> >> The pwm-backlight driver will restore the data.
> >> >>
> >> >> After I try to disable anyone of the two clocks at runtime, the
> >> >> backlight doesn't work well(no immediate update or losing backlight).
> >> >> So we need to keep both clock enabled.
> 
> Do you mean you see backlight glitch because the clocks / backlight
> were *already on* during the first config (Perhaps left on by the
> bootloader)?
> I don't know how to solve that problem.
> Maybe Thierry does.
> 
> In any case, this is a minor issue; we really shouldn't hold up
> landing the driver to optimize when the clocks are enabled/disabled
> :-). I'm happy enough with what you have in this patch.

Sorry for my terrible expression. Let me try again.
1. We want to disable unnecessary clock at runtime. 
But, I get backlight glitch when I disable clk_main or clk_mm in
mtk_disp_pwm_config(). So both clocks are necessary and we don't disable
them at runtime. 

2. Because pwm-backlight driver calls mtk_disp_pwm_config() before
mtk_disp_pwm_enable(), we will lose the first config if clocks are
enabled in mtk_disp_pwm_enable(). I prefer to enable clocks in probe
function. Samsung did the same way in their pwm driver.

Thanks for your kindly suggestions. I will update the patch soon.

Regards,
YH Huang


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
