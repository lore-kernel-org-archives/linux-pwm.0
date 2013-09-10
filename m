Return-Path: <B47053@freescale.com>
From: Xiubo Li-B47053 <B47053@freescale.com>
Subject: RE: [PATCHv3 2/4] ARM: dts: Add Freescale FTM PWM node for VF610.
Date: Tue, 10 Sep 2013 08:10:09 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828136F5@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1378454907-22728-1-git-send-email-Li.Xiubo@freescale.com>
 <1378454907-22728-3-git-send-email-Li.Xiubo@freescale.com>
 <20130910064044.GZ30088@pengutronix.de>
In-Reply-To: <20130910064044.GZ30088@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Return-Path: B47053@freescale.com
List-ID: <linux-pwm.vger.kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Guo Shawn-R65073 <r65073@freescale.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "rob@landley.net" <rob@landley.net>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

> > diff --git a/arch/arm/boot/dts/vf610.dtsi
> > b/arch/arm/boot/dts/vf610.dtsi index 67d929c..44787b5 100644
> > --- a/arch/arm/boot/dts/vf610.dtsi
> > +++ b/arch/arm/boot/dts/vf610.dtsi
> > @@ -140,6 +140,37 @@
> >  				clock-names =3D "pit";
> >  			};
> >
> > +			pwm0: pwm@40038000 {
> > +				compatible =3D "fsl,vf610-ftm-pwm";
> > +				#pwm-cells =3D <3>;
> > +				reg =3D <0x40038000 0x1000>;
> > +				clock-names =3D "ftm0", "ftm0_fix_sel",
> "ftm0_ext_sel";
> > +				clocks =3D <&clks VF610_CLK_FTM0>,
> > +					<&clks VF610_CLK_FTM0_FIX_SEL>,
> > +					<&clks VF610_CLK_FTM0_EXT_SEL>;
> > +				pinctrl-names =3D "ch0-active", "ch0-idle", "ch1-
> active", "ch1-idle",
> > +						"ch2-active", "ch2-idle", "ch3-
> active", "ch3-idle",
> > +						"ch4-active", "ch4-idle", "ch5-
> active", "ch5-idle",
> > +						"ch6-active", "ch6-idle", "ch7-
> active", "ch7-idle";
> > +				pinctrl-0 =3D <&pinctrl_pwm0_ch0_active>;
> > +				pinctrl-1 =3D <&pinctrl_pwm0_ch0_idle>;
> > +				pinctrl-2 =3D <&pinctrl_pwm0_ch1_active>;
> > +				pinctrl-3 =3D <&pinctrl_pwm0_ch1_idle>;
> > +				pinctrl-4 =3D <&pinctrl_pwm0_ch2_active>;
> > +				pinctrl-5 =3D <&pinctrl_pwm0_ch2_idle>;
> > +				pinctrl-6 =3D <&pinctrl_pwm0_ch3_active>;
> > +				pinctrl-7 =3D <&pinctrl_pwm0_ch3_idle>;
> > +				pinctrl-8 =3D <&pinctrl_pwm0_ch4_active>;
> > +				pinctrl-9 =3D <&pinctrl_pwm0_ch4_idle>;
> > +				pinctrl-10 =3D <&pinctrl_pwm0_ch5_active>;
> > +				pinctrl-11 =3D <&pinctrl_pwm0_ch5_idle>;
> > +				pinctrl-12 =3D <&pinctrl_pwm0_ch6_active>;
> > +				pinctrl-13 =3D <&pinctrl_pwm0_ch6_idle>;
> > +				pinctrl-14 =3D <&pinctrl_pwm0_ch7_active>;
> > +				pinctrl-15 =3D <&pinctrl_pwm0_ch7_idle>;
> > +				status =3D "disabled";
> > +			};
>=20
> This is a SoC file, but the pinmux is board specific. The pinmux settings
> probably shouldn't be here.
>=20
Yes, agreed.

I will revise it soon.

--
Xiubo
