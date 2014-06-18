From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/7] ARM: stih416: Add DT nodes for PWM
Date: Wed, 18 Jun 2014 16:17:17 +0100
Message-ID: <20140618151717.GD15956@lee--X1>
References: <1403103172-19856-1-git-send-email-lee.jones@linaro.org>
 <1403103172-19856-3-git-send-email-lee.jones@linaro.org>
 <CAG374jChjAZksvYv0eQN+L1a2Zc4D2w+nU+OTuX_cCHP-aaPHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:53716 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbaFRPRY (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Jun 2014 11:17:24 -0400
Received: by mail-ig0-f180.google.com with SMTP id h18so903228igc.7
        for <linux-pwm@vger.kernel.org>; Wed, 18 Jun 2014 08:17:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAG374jChjAZksvYv0eQN+L1a2Zc4D2w+nU+OTuX_cCHP-aaPHA@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Gabriel Fernandez <gabriel.fernandez@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pwm@vger.kernel.org, "kernel@stlinux.com" <kernel@stlinux.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Patrice Chotard <patrice.chotard@st.com>, ajitpal.singh@st.com, thierry.reding@gmail.com, Maxime Coquelin <maxime.coquelin@st.com>

On Wed, 18 Jun 2014, Gabriel Fernandez wrote:

> Hi Lee,
> minor remark below..
>=20
> On 18 June 2014 16:52, Lee Jones <lee.jones@linaro.org> wrote:
> > Supply top level nodes for the STiH416 based development boards.
> > The Pinctrl configuration has already been applied, so the only
> > missing piece of the DT puzzle is for a board's DTB to enable
> > the nodes.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  arch/arm/boot/dts/stih416.dtsi | 40 ++++++++++++++++++++++++++++++=
++++++++++
> >  1 file changed, 40 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/sti=
h416.dtsi
> > index 06473c5..8af159e 100644
> > --- a/arch/arm/boot/dts/stih416.dtsi
> > +++ b/arch/arm/boot/dts/stih416.dtsi
> > @@ -236,5 +236,45 @@
> >                         resets  =3D <&powerdown STIH416_KEYSCAN_POW=
ERDOWN>,
> >                                   <&softreset STIH416_KEYSCAN_SOFTR=
ESET>;
> >                 };
> > +
> > +               /* SAS PWM Module */
> > +               pwm0: pwm@fed10000 {
> > +                       compatible      =3D "st,sti-pwm";
> > +                       status          =3D "disabled";
> > +                       #pwm-cells      =3D <2>;
> > +                       reg             =3D <0xfed10000 0x68>;
> > +
> > +                       pinctrl-names   =3D "default";
> > +                        pinctrl-0 =3D    <&pinctrl_pwm0_chan0_defa=
ult
> del space

Thanks.

> > +                                       &pinctrl_pwm0_chan1_default
> > +                                       &pinctrl_pwm0_chan2_default
> > +                                       &pinctrl_pwm0_chan3_default=
>;
> > +
> > +                       clock-names     =3D "pwm";
> > +                       clocks          =3D <&clk_sysin>;
> > +               };
> > +
> > +               /* SBC PWM Module */
> > +               pwm1: pwm@fe510000 {
> > +                       compatible      =3D "st,sti-pwm";
> > +                       status          =3D "disabled";
> > +                       #pwm-cells      =3D <2>;
> > +                       reg             =3D <0xfe510000 0x68>;
> > +
> > +                       pinctrl-names   =3D "default";
> > +                       pinctrl-0 =3D     <&pinctrl_pwm1_chan0_defa=
ult
> > +                                       /*
> > +                                        * Shared with SBC_OBS_NOTR=
ST.  Don't
> > +                                        * enable unless you really=
 know what
> > +                                        * you're doing.
> > +                                        *
> > +                                        * &pinctrl_pwm1_chan1_defa=
ult
> > +                                        */
> > +                                       &pinctrl_pwm1_chan2_default
> > +                                       &pinctrl_pwm1_chan3_default=
>;
> > +
> > +                       clock-names     =3D "pwm";
> > +                       clocks          =3D <&clk_sysin>;
> > +               };
> >         };
> >  };
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
