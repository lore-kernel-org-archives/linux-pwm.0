From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/7] ARM: stih407: Add DT nodes for for PWM
Date: Wed, 18 Jun 2014 16:16:52 +0100
Message-ID: <20140618151652.GC15956@lee--X1>
References: <1403103172-19856-1-git-send-email-lee.jones@linaro.org>
 <CAG374jCGhjACBr1a86_W6wQYWq8_CofwSFxZO+4j=3aHQC2nmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:37215 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbaFRPQ7 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Jun 2014 11:16:59 -0400
Received: by mail-ie0-f171.google.com with SMTP id x19so836351ier.16
        for <linux-pwm@vger.kernel.org>; Wed, 18 Jun 2014 08:16:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAG374jCGhjACBr1a86_W6wQYWq8_CofwSFxZO+4j=3aHQC2nmg@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Gabriel Fernandez <gabriel.fernandez@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pwm@vger.kernel.org, "kernel@stlinux.com" <kernel@stlinux.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Patrice Chotard <patrice.chotard@st.com>, ajitpal.singh@st.com, thierry.reding@gmail.com, Maxime Coquelin <maxime.coquelin@st.com>

On Wed, 18 Jun 2014, Gabriel Fernandez wrote:

> Hi Lee,
> minor remark below..
>=20
> On 18 June 2014 16:52, Lee Jones <lee.jones@linaro.org> wrote:
> > Supply top level nodes for the STiH407 based development boards.
> > The Pinctrl configuration has already been applied, so the only
> > missing piece of the DT puzzle is for a board's DTB to enable
> > the nodes.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  arch/arm/boot/dts/stih407.dtsi | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/sti=
h407.dtsi
> > index 4f9024f..6b43ba2 100644
> > --- a/arch/arm/boot/dts/stih407.dtsi
> > +++ b/arch/arm/boot/dts/stih407.dtsi
> > @@ -259,5 +259,32 @@
> >
> >                         status =3D "disabled";
> >                 };
> > +
> > +               /* COMMS PWM Module */
> > +               pwm0: pwm@9810000 {
> > +                       compatible      =3D "st,sti-pwm";
> > +                       status          =3D "disabled";
> > +                       #pwm-cells      =3D <2>;
> > +                       reg             =3D <0x9810000 0x68>;
> > +                       pinctrl-names   =3D "default";
> > +                        pinctrl-0      =3D <&pinctrl_pwm0_chan0_de=
fault>;
> del space

=46ixing, thanks.

> > +                       clock-names     =3D "pwm";
> > +                       clocks          =3D <&clk_sysin>;
> > +               };
> > +
> > +               /* SBC PWM Module */
> > +               pwm1: pwm@9510000 {
> > +                       compatible      =3D "st,sti-pwm";
> > +                       status          =3D "disabled";
> > +                       #pwm-cells      =3D <2>;
> > +                       reg             =3D <0x9510000 0x68>;
> > +                       pinctrl-names   =3D "default";
> > +                       pinctrl-0       =3D <&pinctrl_pwm1_chan0_de=
fault
> > +                                       &pinctrl_pwm1_chan1_default
> > +                                       &pinctrl_pwm1_chan2_default
> > +                                       &pinctrl_pwm1_chan3_default=
>;
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
