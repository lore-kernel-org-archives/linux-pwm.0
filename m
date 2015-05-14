From: YH Huang <yh.huang@mediatek.com>
Subject: Re: [PATCH 2/2] pwm: add Mediatek display PWM driver support
Date: Thu, 14 May 2015 23:39:57 +0800
Message-ID: <1431617997.15140.57.camel@mtksdaap41>
References: <1431336382-13167-1-git-send-email-yh.huang@mediatek.com>
	 <1431336382-13167-3-git-send-email-yh.huang@mediatek.com>
	 <20150512133202.GA24684@ulmo.nvidia.com>
	 <CABuKBe+e2pjFmQ9Ne7XAeVwJzS8KOXa09CUUZPbYG=oVmP3ikA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABuKBe+e2pjFmQ9Ne7XAeVwJzS8KOXa09CUUZPbYG=oVmP3ikA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, srv_heupstream <srv_heupstream@mediatek.com>, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, yh.huang@mediatek.com
List-Id: linux-pwm@vger.kernel.org

On Tue, 2015-05-12 at 16:34 +0200, Matthias Brugger wrote:
> 2015-05-12 15:32 GMT+02:00 Thierry Reding <thierry.reding@gmail.com>:
> > On Mon, May 11, 2015 at 05:26:22PM +0800, YH Huang wrote:
> >> Add display PWM driver support to modify backlight for MT8173/MT6595.
> >>
> >> Signed-off-by: YH Huang <yh.huang@mediatek.com>
> >> ---
> >>  drivers/pwm/Kconfig             |   9 ++
> >>  drivers/pwm/Makefile            |   1 +
> >>  drivers/pwm/pwm-disp-mediatek.c | 225 ++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 235 insertions(+)
> >>  create mode 100644 drivers/pwm/pwm-disp-mediatek.c
> >>
> >> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> >> index b1541f4..9edbb5a 100644
> >> --- a/drivers/pwm/Kconfig
> >> +++ b/drivers/pwm/Kconfig
> >> @@ -111,6 +111,15 @@ config PWM_CLPS711X
> >>         To compile this driver as a module, choose M here: the module
> >>         will be called pwm-clps711x.
> >>
> >> +config PWM_DISP_MEDIATEK
> >
> > Please make this "PWM_MEDIATEK_DISP" so we can keep everything sorted by
> > vendor.
> >
> >> +     tristate "MEDIATEK display PWM driver"
> >
> > "MediaTek"?
> >
> >> +     depends on OF
> >
> > Technically I think you need depends on HAS_IOMEM here to avoid breakage
> > on randconfig builds.
> >
> >> +     help
> >> +       Generic PWM framework driver for mediatek disp-pwm device.
> >
> > "MediaTek"? Also perhaps this should describe what this PWM is instead
> > of just the "disp-pwm" which leaves everyone guessing what it is. From
> > the name I'd expect it to be the PWM that is used to control the
> > backlight brightness for display, but I think this description should
> > say that explicitly.
> >
> >> +
> >> +       To compile this driver as a module, choose M here: the module
> >> +       will be called pwm-disp-mediatek.
> >
> > pwm-mediatek-disp
> 
> I would prefert pwm-mtk-disp which is in line with the other drivers.
> Also I have to admit that unfortunately the naming is not uniformly
> throughout the kernel.
> 

OK. I will take it.

> Thanks,
> Matthias

Thank for your suggestion.

Regards,
YH Huang
