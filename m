From: "Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCHv8 RFC] pwm: Add Freescale FTM PWM driver support
Date: Fri, 3 Jan 2014 09:16:06 +0000
Message-ID: <f9527d65aa234f40af2830d9fb139bbb@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1388726661-3391-1-git-send-email-Li.Xiubo@freescale.com>
 <20140103074511.GA10680@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140103074511.GA10680-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "bpringlemeir-ygJ1pmMJ17cAvxtiuMwx3w@public.gmane.org" <bpringlemeir-ygJ1pmMJ17cAvxtiuMwx3w@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Huan Wang <Huan.Wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Jingchang Lu <jingchang.lu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hi Dmitry,

> Subject: Re: [PATCHv8 RFC] pwm: Add Freescale FTM PWM driver support
> 
> Hi Xiubo,
> 
> On Fri, Jan 03, 2014 at 01:24:21PM +0800, Xiubo Li wrote:
> > +
> > +static inline int fsl_pwm_calculate_default_ps(struct fsl_pwm_chip *fpc,
> > +					       enum fsl_pwm_clk index)
> > +{
> 
> Why do you declare this (and other module-local) function as inline?
> It is usually better let compiler decide if given function should be
> inlined or not.
> 

Could the compiler know when the given function should be inlined by not declare it?
And when will be inlined ?

> [...]
> 
> > +
> > +static int fsl_pwm_remove(struct platform_device *pdev)
> > +{
> > +	struct fsl_pwm_chip *fpc = platform_get_drvdata(pdev);
> > +
> > +	mutex_destroy(&fpc->lock);
> > +
> > +	return pwmchip_remove(&fpc->chip);
> 
> fpc->lock will be used while pwmchip_remove() is running so you should
> not be destroying it before calling pwmchip_remove(). It should probbaly
> go into free() method or just drop it altogether.
> 

Yes, I think I should drop it here as Thierry has already pointed out.


Thanks very much.

--
Best Regards,
Xiubo

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
