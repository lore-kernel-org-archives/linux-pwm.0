From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 20/20] dt-bindings: pwm: sti: Update DT bindings with
 recent changes
Date: Thu, 9 Jun 2016 12:41:07 +0100
Message-ID: <20160609114107.GB1388@dell>
References: <20160608092135.21184-1-lee.jones@linaro.org>
 <20160608092135.21184-21-lee.jones@linaro.org>
 <20160608205152.GA5511@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36340 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbcFILkd (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Jun 2016 07:40:33 -0400
Received: by mail-wm0-f48.google.com with SMTP id n184so221254701wmn.1
        for <linux-pwm@vger.kernel.org>; Thu, 09 Jun 2016 04:40:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160608205152.GA5511@rob-hp-laptop>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, patrice.chotard@st.com, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org

On Wed, 08 Jun 2016, Rob Herring wrote:

> On Wed, Jun 08, 2016 at 10:21:35AM +0100, Lee Jones wrote:
> > We're renaming the 'st,pwm-num-chan' binding to 'st,pwm-num-devs' t=
o
> > be more inline with the naming conventions of the subsystem.  Where
> > we used to treat each line as a channel, the PWM convention is to
> > describe them as devices.
>=20
> That's all linux implementation details and you are breaking=20
> compatibility.

Normally I'd agree with you, but I happen to know that a) this IP is
currently unused and b) up until this point (and probably beyond), ST
always ship the DTB with the kernel, so there will be no breakage.

> > The second documentation adaption entails adding support for PWM
> > capture devices.  A new clock is required as well as an IRQ line.
> > We're also adding a new property similar to the one described
> > above, but for capture channels.  Typically, there will be less
> > capture channels than PWM-out, since all channels have the latter
> > capability, but only some have capture support.
>=20
> Humm, sounds like all of this should be implied from compatible strin=
gs.

You mean have a bunch of of_machine_is_compatibles() scattered around?

> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm-st.txt | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-st.txt b/Doc=
umentation/devicetree/bindings/pwm/pwm-st.txt
> > index 84d2fb8..b09f3a4 100644
> > --- a/Documentation/devicetree/bindings/pwm/pwm-st.txt
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-st.txt
> > @@ -13,13 +13,14 @@ Required parameters:
> >  - pinctrl-0: 		List of phandles pointing to pin configuration node=
s
> >  			for PWM module.
> >  			For Pinctrl properties, please refer to [1].
> > -- clock-names: 		Set to "pwm".
> > +- clock-names: 		Valid entries are "pwm" and/or "capture".
> >  - clocks: 		phandle of the clock used by the PWM module.
> >  			For Clk properties, please refer to [2].
> > +- interrupts:		IRQ for the Capture device
> > =20
> >  Optional properties:
> > -- st,pwm-num-chan:	Number of available channels. If not passed, th=
e driver
> > -			will consider single channel by default.
> > +- st,pwm-num-devs:	Number of available PWM channels.  Default is 0=
=2E
> > +- st,capture-num-devs:	Number of available Capture channels.  Defa=
ult is 0.
> > =20
> >  [1] Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> >  [2] Documentation/devicetree/bindings/clock/clock-bindings.txt
> > @@ -37,5 +38,6 @@ pwm1: pwm@fe510000 {
> >  		     &pinctrl_pwm1_chan3_default>;
> >  	clocks =3D <&clk_sysin>;
> >  	clock-names =3D "pwm";
> > -	st,pwm-num-chan =3D <4>;
> > +	st,pwm-num-devs =3D <4>;
> > +	st,capture-num-devs =3D <2>;
> >  };

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
