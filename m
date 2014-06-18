From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 7/7] pwm: st: Supply Device Tree binding documentation
 for ST's PWM IP
Date: Wed, 18 Jun 2014 16:16:21 +0100
Message-ID: <20140618151621.GB15956@lee--X1>
References: <1403103172-19856-1-git-send-email-lee.jones@linaro.org>
 <1403103172-19856-7-git-send-email-lee.jones@linaro.org>
 <CAG374jBJpmgv+X_ZT-Q6kj89p8BvVLb3sUsBHmD7GHF=jLQ=Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:52442 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbaFRPQ2 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Jun 2014 11:16:28 -0400
Received: by mail-ie0-f171.google.com with SMTP id x19so834055ier.2
        for <linux-pwm@vger.kernel.org>; Wed, 18 Jun 2014 08:16:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAG374jBJpmgv+X_ZT-Q6kj89p8BvVLb3sUsBHmD7GHF=jLQ=Ew@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Gabriel Fernandez <gabriel.fernandez@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pwm@vger.kernel.org, "kernel@stlinux.com" <kernel@stlinux.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Patrice Chotard <patrice.chotard@st.com>, ajitpal.singh@st.com, thierry.reding@gmail.com, Maxime Coquelin <maxime.coquelin@st.com>

On Wed, 18 Jun 2014, Gabriel Fernandez wrote:

> Hi Lee,
> minor remark below..
>=20
> On 18 June 2014 16:52, Lee Jones <lee.jones@linaro.org> wrote:
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm-st.txt | 41 ++++++++++++=
++++++++++++
> >  1 file changed, 41 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-st.tx=
t
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-st.txt b/Doc=
umentation/devicetree/bindings/pwm/pwm-st.txt
> > new file mode 100644
> > index 0000000..ea88c5c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-st.txt
> > @@ -0,0 +1,41 @@
> > +STMicroelectronics PWM driver bindings
> > +--------------------------------------
>=20
> > +Example:
> > +
> > +pwm1: pwm@fe510000 {
> > +       compatible =3D "st,pwm";
> > +       reg =3D <0xfe510000 0x68>;
> > +       #pwm-cells =3D <2>;
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pinctrl_pwm1_chan0_default
> > +                    &pinctrl_pwm1_chan1_default
> > +                    &pinctrl_pwm1_chan2_default
> > +                    &pinctrl_pwm1_chan3_default>;
> > +       clocks =3D <&CLK_SYSIN>;
> clock name in lower case

Good catch.  Will fix.

> > +       clock-names =3D "pwm";
> > +       st,pwm-num-chan =3D <4>;
> > +};
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
