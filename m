From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: pwm: add MediaTek display PWM bindings
Date: Thu, 9 Jul 2015 12:47:46 +0800
Message-ID: <CAGS+omAZismuEYXsUkHEAec4xF+KRWm62AuCUmrmso6p+DKQ4Q@mail.gmail.com>
References: <1436189368-1826-1-git-send-email-yh.huang@mediatek.com>
 <1436189368-1826-2-git-send-email-yh.huang@mediatek.com> <CAGS+omAWNwk_PRy-eeC4bgHQ-ZC2Kvh0sqpF47VD1sfJOhHWUw@mail.gmail.com>
 <1436409944.4915.6.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:34418 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbbGIEsG (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Jul 2015 00:48:06 -0400
Received: by ykcp133 with SMTP id p133so39942178ykc.1
        for <linux-pwm@vger.kernel.org>; Wed, 08 Jul 2015 21:48:05 -0700 (PDT)
In-Reply-To: <1436409944.4915.6.camel@mtksdaap41>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: YH Huang <yh.huang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, srv_heupstream <srv_heupstream@mediatek.com>, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Yingjoe Chen <yingjoe.chen@mediatek.com>

On Thu, Jul 9, 2015 at 10:45 AM, YH Huang <yh.huang@mediatek.com> wrote:
>
> On Wed, 2015-07-08 at 20:11 +0800, Daniel Kurtz wrote:
> > On Mon, Jul 6, 2015 at 9:29 PM, YH Huang <yh.huang@mediatek.com> wrote:
> > > Document the device-tree binding of MediatTek display PWM.
> > > The PWM has one channel to control the backlight brightness for display.
> > > It supports MT8173 and MT6595.
> > >
> > > Signed-off-by: YH Huang <yh.huang@mediatek.com>
> > > ---
> > >  .../devicetree/bindings/pwm/pwm-mtk-disp.txt       | 24 ++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> > > new file mode 100644
> > > index 0000000..757b974
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> > > @@ -0,0 +1,24 @@
> > > +MediaTek display PWM controller
> > > +
> > > +Required properties:
> > > + - compatible: should be "mediatek,<name>-disp-pwm"
> > > +   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC
> > > +   - "mediatek,mt6595-disp-pwm": found on mt6595 SoC
> > > + - reg: physical base address and length of the controller's registers
> > > + - #pwm-cells: must be 2. See pwm.txt in this directory for a description of
> > > +   the cell format
> > > + - clocks: phandle and clock specifier of the PWM reference clock
> > > + - clock-names: must contain the following
> > > +   - "main": clock used to generate PWM signals
> > > +   - "mm": sync signals from the modules of mmsys
> > > +
> > > +Example:
> > > +       pwm0: pwm@1401e000 {
> > > +               compatible = "mediatek,mt8173-disp-pwm",
> > > +                            "mediatek,mt6595-disp-pwm";
> > > +               reg = <0 0x1401e000 0 0x1000>;
> > > +               #pwm-cells = <2>;
> > > +               clocks = <&mmsys CLK_MM_DISP_PWM026M>,
> > > +                        <&mmsys CLK_MM_DISP_PWM0MM>;
> > > +               clock-names = "main", "mm";
> >
> > Should we include the pinctrl settings here to enable the PWM output?
> >
>
> Since we use pwm-backlight driver to control backlight, we should enable
> PWM output in the backlight node.
>
> Ref:
> https://www.kernel.org/doc/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
>

The pwm-backlight binding specifies which pwm the backlight driver
should use, and how to use it.

I believe actually configuring the output pin for the pwm via pinctl
belongs to the pwm binding.

Regards,
0Dan

>
> Regards,
> YH Huang
>
