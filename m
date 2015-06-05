From: YH Huang <yh.huang@mediatek.com>
Subject: Re: [PATCH v2 0/2] Add MediaTek display PWM driver
Date: Fri, 5 Jun 2015 18:45:34 +0800
Message-ID: <1433501134.17376.23.camel@mtksdaap41>
References: <1432214964-40644-1-git-send-email-yh.huang@mediatek.com>
	 <1432520091.23308.5.camel@mtksdaap41>
	 <1433484929.17376.17.camel@mtksdaap41>
	 <CABuKBeLaVXxqBgy7AMoZ73+GoUknC6Zq=fJdcyZZjP5VYRZSkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABuKBeLaVXxqBgy7AMoZ73+GoUknC6Zq=fJdcyZZjP5VYRZSkg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>, Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>, Pawel Moll <pawel.moll@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

On Fri, 2015-06-05 at 10:39 +0200, Matthias Brugger wrote:
> Hi YH,
> 
> 2015-06-05 8:15 GMT+02:00 YH Huang <yh.huang@mediatek.com>:
> > On Mon, 2015-05-25 at 10:14 +0800, Yingjoe Chen wrote:
> >> On Thu, 2015-05-21 at 21:29 +0800, YH Huang wrote:
> >
> > This patch series add the use of display PWM driver and documentation
> > for Mediatek SoCs. The driver is used to support the backlight of
> > the panel. This is based on v4.1-rc1.

Change in v2:
1. Rewrite descriptions for driver in kconfig to make it much clear.
2. Rename the driver from "pwm-mediatek-disp" to "pwm-mtk-disp".
3. Disable clocks in the error path.
4. Change the shift values in decimal instead of hex.
5. Rename and add some variables or function name for consistency and
readability.
6. Drop unnecessary parentheses, spaces, variables and add newlines to
make the code easiler to read.

> >
> >> > YH Huang (2):
> >> >   dt-bindings: pwm: add MediaTek display PWM bindings
> >> >   pwm: add MediaTek display PWM driver support
> >> >
> >> >  .../devicetree/bindings/pwm/pwm-mtk-disp.txt       |  25 +++
> >> >  drivers/pwm/Kconfig                                |  10 +
> >> >  drivers/pwm/Makefile                               |   1 +
> >> >  drivers/pwm/pwm-mtk-disp.c                         | 228 +++++++++++++++++++++
> >> >  4 files changed, 264 insertions(+)
> >> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> >> >  create mode 100644 drivers/pwm/pwm-mtk-disp.c
> >>
> >> Hi YH,
> >>
> >> It would be easier for reviewer if you have a summary here on what you
> >> have changed compare to last version.
> >> Also, please add patch series summary even for v2, it remind reviewer
> >> what this series is about.
> >>
> >> Joe.C
> >>
> >
> > The patch v2 is refined with everybody's suggestions.
> > It is much readable and consistent.
> 
> I suppose that Yingjoe wanted to emphasis that for the reviewer it is
> much easier if you describe the changes you made from v1 to v2.
> You can find an example (random pick from the mailing list) here:
> http://lists.infradead.org/pipermail/linux-mediatek/2015-May/000572.html
> 
> Thanks,
> Matthias
> 

I have added the change lists.
Thank you.

Regards,
YH Huang
