From: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: add MediaTek display PWM
 bindings
Date: Thu, 18 Jun 2015 17:00:26 +0800
Message-ID: <1434618026.18278.5.camel@mtksdaap41>
References: <1432214964-40644-1-git-send-email-yh.huang@mediatek.com>
	 <1432214964-40644-2-git-send-email-yh.huang@mediatek.com>
	 <20150612102344.GG19400@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150612102344.GG19400-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Fri, 2015-06-12 at 12:23 +0200, Thierry Reding wrote:
> On Thu, May 21, 2015 at 09:29:23PM +0800, YH Huang wrote:
> > Document the device-tree binding of MediatTek display PWM.
> 
> s/MediatTek/MediaTek/
> 
> > 
> > Signed-off-by: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> 
> This could use a more verbose commit message. You could mention what the
> PWM is typically used for (display I presume). Perhaps mention how many
> channels it exposes and so on.

I will add more information in the commit message.

> 
> > ---
> >  .../devicetree/bindings/pwm/pwm-mtk-disp.txt       | 25 ++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> > new file mode 100644
> > index 0000000..f55bf92
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> > @@ -0,0 +1,25 @@
> > +MediaTek display PWM controller
> > +
> > +Required properties:
> > + - compatible: should be "mediatek,<name>-disp-pwm"
> > +   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC
> > +   - "mediatek,mt6595-disp-pwm": found on mt6595 SoC
> > + - reg: physical base address and length of the controller's registers
> > + - #pwm-cells: must be 2. See pwm.txt in this directory
> > +   for a description of the cell format
> 
> You can use the full line width of 78/80 characters, no need to wrap
> this prematurely.

OK.

> 
> > + - clocks: phandle and clock specifier of the PWM reference clock
> > + - clock-names: must contain the following
> > +   - "main": clock used to generate PWM signals
> > +   - "mm": sync signals from the modules of mmsys
> > +
> > +Example:
> > +	pwm0: pwm@1401e000 {
> > +		compatible = "mediatek,mt8173-disp-pwm",
> > +			     "mediatek,mt6595-disp-pwm";
> > +		reg = <0 0x1401e000 0 0x1000>;
> > +		#pwm-cells = <2>;
> > +		clocks = <&mmsys MM_DISP_PWM026M>,
> > +			 <&mmsys MM_DISP_PWM0MM>;
> > +		clock-names = "main",
> > +			      "mm";
> 
> No need to waste a line,
> 
> 		clock-names = "main", "mm";
> 
> fits on a single line just fine.

OK.

> 
> Thierry

Thank for your suggestion.

Regards,
YH Huang

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
