From: Jerome Brunet <jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 3/3] ARM64: dts: meson-axg: add PWM DT info for
 Meson-Axg SoC
Date: Mon, 04 Dec 2017 10:29:30 +0100
Message-ID: <1512379770.2574.34.camel@baylibre.com>
References: <20171204060018.8856-1-yixun.lan@amlogic.com>
         <20171204060018.8856-4-yixun.lan@amlogic.com>
         <1512379059.2574.17.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1512379059.2574.17.camel-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yixun Lan <yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, Jian Hu <jian.hu-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Mon, 2017-12-04 at 10:17 +0100, Jerome Brunet wrote:
> On Mon, 2017-12-04 at 14:00 +0800, Yixun Lan wrote:
> > From: Jian Hu <jian.hu-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
> > 
> > Add PWM DT info for the Amlogic's Meson-Axg SoC.
> > 
> > Signed-off-by: Jian Hu <jian.hu-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
> > Signed-off-by: Yixun Lan <yixun.lan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 120
> > +++++++++++++++++++++++++++++
> >  1 file changed, 120 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> > b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> > index 92f65eec3e18..f7f228701df1 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> > +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> > @@ -177,6 +177,24 @@
> > 
> 
> [...]
> 
> > 
> > @@ -435,6 +537,24 @@
> >  				clock-names = "clk_i2c";
> >  			};
> >  
> > +			pwm_AO_ab: pwm@7000 {
> > +				compatible = "amlogic,meson-axg-ao-pwm";
> > +				reg = <0x0 0x07000 0x0 0x20>;
> > +				#pwm-cells = <3>;
> > +				clocks = <&xtal>, <&xtal>;
> > +				clock-names = "clkin0", "clkin1";
> 
> like gxbb, "amlogic,meson-axg-ao-pwm" does not have such clock bindings,
> Later on, if we want to "correctly" get the clock from DT, it will have to
> gothrough a new compatible, I guess. 

Please ignore this comment (monday morning...)
However clock bindings for this should be defined in the board dts, not the soc
one 

> 
> > +				status = "disabled";
> > +			};
> > +
> > +			pwm_AO_cd: pwm@2000 {
> > +				compatible = "amlogic,axg-ao-pwm";
> > +				reg = <0x0 0x02000  0x0 0x20>;
> > +				#pwm-cells = <3>;
> > +				clocks = <&xtal>, <&xtal>;
> > +				clock-names = "clkin0", "clkin1";
> > +				status = "disabled";
> > +			};
> > +
> >  			uart_AO: serial@3000 {
> >  				compatible = "amlogic,meson-gx-uart",
> > "amlogic,meson-ao-uart";
> >  				reg = <0x0 0x3000 0x0 0x18>;
> 
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
