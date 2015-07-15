From: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: pwm: add MediaTek display PWM
 bindings
Date: Wed, 15 Jul 2015 23:37:14 +0800
Message-ID: <1436974634.15774.8.camel@mtksdaap41>
References: <1436778294-47635-1-git-send-email-yh.huang@mediatek.com>
	 <1436778294-47635-2-git-send-email-yh.huang@mediatek.com>
	 <CAGS+omCdLbNu03c2DdiLEqNmGVkEoGu3972-YDp8ne5G9WZJ0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGS+omCdLbNu03c2DdiLEqNmGVkEoGu3972-YDp8ne5G9WZJ0g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND..." <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Mon, 2015-07-13 at 18:20 +0800, Daniel Kurtz wrote:
> On Mon, Jul 13, 2015 at 5:04 PM, YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> > Document the device-tree binding of MediatTek display PWM.
> > The PWM has one channel to control the backlight brightness for display.
> > It supports MT8173 and MT6595.
> >
> > Signed-off-by: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  .../devicetree/bindings/pwm/pwm-mtk-disp.txt       | 29 ++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> > new file mode 100644
> > index 0000000..aac29dc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> > @@ -0,0 +1,29 @@
> > +MediaTek display PWM controller
> > +
> > +Required properties:
> > + - compatible: should be "mediatek,<name>-disp-pwm":
> > +   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC.
> > +   - "mediatek,mt6595-disp-pwm": found on mt6595 SoC.
> > + - reg: physical base address and length of the controller's registers.
> > + - #pwm-cells: must be 2. See pwm.txt in this directory for a description of
> > +   the cell format.
> > + - clocks: phandle and clock specifier of the PWM reference clock.
> > + - clock-names: must contain the following:
> > +   - "main": clock used to generate PWM signals.
> > +   - "mm": sync signals from the modules of mmsys.
> > + - pinctrl-names: Must contain a "default" entry.
> > + - pinctrl-0: One property must exist for each entry in pinctrl-names.
> > +   See pinctrl/pinctrl-bindings.txt for details of the property values.
> > +
> > +Example:
> > +       pwm0: pwm@1401e000 {
> > +               compatible = "mediatek,mt8173-disp-pwm",
> > +                            "mediatek,mt6595-disp-pwm";
> > +               reg = <0 0x1401e000 0 0x1000>;
> > +               #pwm-cells = <2>;
> > +               clocks = <&mmsys CLK_MM_DISP_PWM026M>,
> > +                        <&mmsys CLK_MM_DISP_PWM0MM>;
> > +               clock-names = "main", "mm";
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&disp_pwm0_pins>;
> > +       };
> 
> Please show an example consumer of the pwm phandle to show how to set
> the two properties required by the #pwm-cells.
> Although the pwm-specifier typically encodes the chip-relative PWM
> number and the PWM period in nanoseconds, it is technically controller
> specific.
> 
> In fact, since the mtk-disp-pwm does not have a chip-relative PWM
> number, could we in fact set #pwm-cells = <1>, and only specify the
> requested PWM period?
OK. I will add the example like the following.

backlight_lcd: backlight_lcd {
	compatible = "pwm-backlight";
	pwms = <&pwm0 0 1000000>;
	brightness-levels = <
		  0  16  32  48  64  80  96 112
		128 144 160 176 192 208 224 240
		255
	>;
	default-brightness-level = <9>;
	power-supply = <&mt6397_vio18_reg>;
	enable-gpios = <&pio 95 GPIO_ACTIVE_HIGH>;
};

The core in PWM driver can only take two or three cells.
In our case, we don't need to set polarity of PWM.
So it should be 2.

Regards,
YH Huang

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
