From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFCv2 endianess 1/4] pwm: Add Freescale FTM PWM driver support
Date: Tue, 10 Dec 2013 10:19:59 +0000
Message-ID: <20131210101959.GE1809@e106331-lin.cambridge.arm.com>
References: <1386309134-1822-1-git-send-email-Li.Xiubo@freescale.com>
 <1386309134-1822-2-git-send-email-Li.Xiubo@freescale.com>
 <04e52411558f44d99a603c288e2dcc50@BY2PR03MB505.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <04e52411558f44d99a603c288e2dcc50@BY2PR03MB505.namprd03.prod.outlook.com>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "galak@codeaurora.org" <galak@codeaurora.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "matt.porter@linaro.org" <matt.porter@linaro.org>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "rob@landley.net" <rob@landley.net>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, Pawel Moll <Pawel.Moll@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "Huan.Wang@freescale.com" <Huan.Wang@freescale.com>, "jingchang.lu@freescale.com" <jingchang.lu@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infrade>
List-Id: linux-pwm@vger.kernel.org

On Tue, Dec 10, 2013 at 05:10:01AM +0000, Li.Xiubo@freescale.com wrote:
> Hi Mark, Therry,
>
> Is this series of patches ok about endianess fix?
>
> Here I add one boolen big-endian property.

[...]

> > +static inline u32 fsl_pwm_readl(struct fsl_pwm_chip *fpc,
> > +             const void __iomem *addr)
> > +{
> > +     if (likely(fpc->big_endian))
> > +             return ioread32be(addr);
> > +     else
> > +             return readl(addr);
> > +}

It looks a little odd to to have two different accessors here.

Could these not be unified somehow?

> > +static inline void fsl_pwm_writel(struct fsl_pwm_chip *fpc,
> > +             u32 val, void __iomem *addr)
> > +{
> > +     if (likely(fpc->big_endian))
> > +             iowrite32be(val, addr);
> > +     else
> > +             writel(val, addr);
> > +}

Likewise.

[...]

> > +static int fsl_pwm_probe(struct platform_device *pdev) {
> > +     int ret;
> > +     struct fsl_pwm_chip *fpc;
> > +     struct resource *res;
> > +     struct device_node *np = pdev->dev.of_node;
> > +
> > +     fpc = devm_kzalloc(&pdev->dev, sizeof(*fpc), GFP_KERNEL);
> > +     if (!fpc)
> > +             return -ENOMEM;
> > +
> > +     mutex_init(&fpc->lock);
> > +
> > +     fpc->chip.dev = &pdev->dev;
> > +
> > +     if (of_get_property(np, "big-endian", NULL))
> > +             fpc->big_endian = 1;

You can use of_property_read_bool:

fpc->big_endian = of_property_read_bool(np, "big-endian");

Otherwise, the DT stuff looks fine.

Mark.
