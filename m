From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCHv8 1/4] pwm: Add Freescale FTM PWM driver support
Date: Fri, 3 Jan 2014 09:19:22 +0000
Message-ID: <bb5e14370ddb4ce2921140d147244097@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1388656624-26570-1-git-send-email-Li.Xiubo@freescale.com>
 <1388656624-26570-2-git-send-email-Li.Xiubo@freescale.com>
 <3716216.GQHQhxMFvx@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3716216.GQHQhxMFvx@wuerfel>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Huan Wang <Huan.Wang@freescale.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jingchang Lu <jingchang.lu@freescale.com>
List-Id: linux-pwm@vger.kernel.org

Hi Arnd,


> Subject: Re: [PATCHv8 1/4] pwm: Add Freescale FTM PWM driver support
> 
> On Thursday 02 January 2014 17:57:01 Xiubo Li wrote:
> > +static inline u32 ftm_readl(bool big_endian, const void __iomem *addr)
> > +{
> > +       u32 val;
> > +
> > +       val = __raw_readl(addr);
> > +
> > +       if (likely(big_endian))
> > +               val = be32_to_cpu((__force __be32)val);
> > +       else
> > +               val = le32_to_cpu((__force __le32)val);
> > +       rmb();
> > +
> > +       return val;
> > +}
> > +
> > +static inline void ftm_writel(bool big_endian, u32 val, void __iomem *addr)
> > +{
> > +       wmb();
> > +       if (likely(big_endian))
> > +               val = (__force u32)cpu_to_be32(val);
> > +       else
> > +               val = (__force u32)cpu_to_le32(val);
> > +
> > +       __raw_writel(val, addr);
> 
> These functions definitely need some comments regarding why this is necessary.
> I assume that after 8 rounds of review (that I did not read) this has been
> discussed already, so please explain above the functions why you don't just
> use ioread32be/ioread32 and iowrite32be/iowrite32 here.
>

As Thierry has commonts in some days before:
----
A few years ago GregKH commented in response to a patch that ioread*()
weren't supposed to be used for memory-mapped only devices. The original
purpose apparently was to allow drivers to work with both I/O and
memory-mapped devices.
----
I'm not very sure.

The big-endian supports is added at v7~v8 patch series.


> Also all callers seem to be of the style
> 
>        val = ftm_readl(fpc->big_endian, fpc->base + FTM_SC);
> 
> so I wonder why you don't just pass the fpc pointer to the function
> and make it
> 
> static inline void ftm_readl(struct fsl_pwm_chip *fpc, unsigned long reg, u32
> val)
> {
> 	if (fpc->big_endian)
> 		iowrite32be(val, fpc->base + reg);
> 	else
> 		iowrite32(val, fpc->base + reg);
> }
> 

Yes, it was.

I thought this will make the ftm_readl/ftm_writel look more brief like other drivers.

 
Thanks very much.

--
Best Regards,
Xiubo
