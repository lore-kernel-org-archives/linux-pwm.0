Return-path: <petervasil@gmail.com>
MIME-Version: 1.0
References: <20200426101122.98318-1-peter.vasil@gmail.com> <20200428075346.xjzmmvios64emg5z@gilmour.lan>
In-Reply-To: <20200428075346.xjzmmvios64emg5z@gilmour.lan>
From: Peter Vasil <petervasil@gmail.com>
Date: Tue, 28 Apr 2020 18:31:02 +0200
Message-ID: <CAFwpezVgOkSu9Smt=cbLNGndQCcY3qWYsNT3GjpZMSBfSMyiPg@mail.gmail.com>
Content-Type: multipart/alternative; boundary="0000000000002ecf0605a45c5c72"
Subject: Re: [PATCH] pwm: sun4i: direct clock output support for Allwinner A64
To: Maxime Ripard <maxime@cerno.tech>
Cc: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>

--0000000000002ecf0605a45c5c72
Content-Type: text/plain; charset="UTF-8"

Hello Maxime,

On Tue, Apr 28, 2020 at 9:53 AM Maxime Ripard <maxime@cerno.tech> wrote:

> Hi,
>
> On Sun, Apr 26, 2020 at 12:11:22PM +0200, Peter Vasil wrote:
> > Allwinner A64 is capable of a direct clock output on PWM (see A64
> > User Manual chapter 3.10). Add support for this in the sun4i PWM
> > driver and adjust compatibility in sun50i-a64 base device tree.
> >
> > Signed-off-by: Peter Vasil <peter.vasil@gmail.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 6 ++----
> >  drivers/pwm/pwm-sun4i.c                       | 9 +++++++++
> >  2 files changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > index 31143fe64d91..c334fd106854 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > @@ -1069,8 +1069,7 @@ gic: interrupt-controller@1c81000 {
> >               };
> >
> >               pwm: pwm@1c21400 {
> > -                     compatible = "allwinner,sun50i-a64-pwm",
> > -                                  "allwinner,sun5i-a13-pwm";
> > +                     compatible = "allwinner,sun50i-a64-pwm";
> >                       reg = <0x01c21400 0x400>;
> >                       clocks = <&osc24M>;
> >                       pinctrl-names = "default";
> > @@ -1252,8 +1251,7 @@ r_ir: ir@1f02000 {
> >               };
> >
> >               r_pwm: pwm@1f03800 {
> > -                     compatible = "allwinner,sun50i-a64-pwm",
> > -                                  "allwinner,sun5i-a13-pwm";
> > +                     compatible = "allwinner,sun50i-a64-pwm";
>
> There's no need to remove that compatible, it's actually working as
> intended..
>
> >                       reg = <0x01f03800 0x400>;
> >                       clocks = <&osc24M>;
> >                       pinctrl-names = "default";
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 5c677c563349..18fbbe3277d0 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -352,6 +352,12 @@ static const struct sun4i_pwm_data
> sun4i_pwm_single_bypass = {
> >       .npwm = 1,
> >  };
> >
> > +static const struct sun4i_pwm_data sun50i_a64_pwm_data = {
> > +     .has_prescaler_bypass = true,
> > +     .has_direct_mod_clk_output = true,
> > +     .npwm = 1,
> > +};
> > +
> >  static const struct sun4i_pwm_data sun50i_h6_pwm_data = {
> >       .has_prescaler_bypass = true,
> >       .has_direct_mod_clk_output = true,
> > @@ -374,6 +380,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[]
> = {
> >       }, {
> >               .compatible = "allwinner,sun8i-h3-pwm",
> >               .data = &sun4i_pwm_single_bypass,
> > +     }, {
> > +             .compatible = "allwinner,sun50i-a64-pwm",
> > +             .data = &sun50i_a64_pwm_data,
>
> Ie, if the OS only has support for the A13, then it will use it as an A13,
> and
> if it has support for the A64 variant, then it can use some more advanced
> features.
>
> True, I didn't realize that when I was replicating H6 config. I just
tested the original compatibility on Remix Mini and it works fine, I'll
send an amended patch shortly.

Maxime
>

Thanks!
Peter

--0000000000002ecf0605a45c5c72
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hello Maxime,<br></div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 28, 2020 at =
9:53 AM Maxime Ripard &lt;maxime@cerno.tech&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Sun, Apr 26, 2020 at 12:11:22PM +0200, Peter Vasil wrote:<br>
&gt; Allwinner A64 is capable of a direct clock output on PWM (see A64<br>
&gt; User Manual chapter 3.10). Add support for this in the sun4i PWM<br>
&gt; driver and adjust compatibility in sun50i-a64 base device tree.<br>
&gt; <br>
&gt; Signed-off-by: Peter Vasil &lt;<a href=3D"mailto:peter.vasil@gmail.com=
" target=3D"_blank">peter.vasil@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 6 ++----<br>
&gt;=C2=A0 drivers/pwm/pwm-sun4i.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 9 +++++++++<br>
&gt;=C2=A0 2 files changed, 11 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm6=
4/boot/dts/allwinner/sun50i-a64.dtsi<br>
&gt; index 31143fe64d91..c334fd106854 100644<br>
&gt; --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi<br>
&gt; +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi<br>
&gt; @@ -1069,8 +1069,7 @@ gic: interrupt-controller@1c81000 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pwm: pwm@1c21400=
 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0compatible =3D &quot;allwinner,sun50i-a64-pwm&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;allwinner,sun5i-a13=
-pwm&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0compatible =3D &quot;allwinner,sun50i-a64-pwm&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0reg =3D &lt;0x01c21400 0x400&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0clocks =3D &lt;&amp;osc24M&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0pinctrl-names =3D &quot;default&quot;;<br>
&gt; @@ -1252,8 +1251,7 @@ r_ir: ir@1f02000 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r_pwm: pwm@1f038=
00 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0compatible =3D &quot;allwinner,sun50i-a64-pwm&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;allwinner,sun5i-a13=
-pwm&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0compatible =3D &quot;allwinner,sun50i-a64-pwm&quot;;<br>
<br>
There&#39;s no need to remove that compatible, it&#39;s actually working as=
 intended..<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0reg =3D &lt;0x01f03800 0x400&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0clocks =3D &lt;&amp;osc24M&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0pinctrl-names =3D &quot;default&quot;;<br>
&gt; diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c<br>
&gt; index 5c677c563349..18fbbe3277d0 100644<br>
&gt; --- a/drivers/pwm/pwm-sun4i.c<br>
&gt; +++ b/drivers/pwm/pwm-sun4i.c<br>
&gt; @@ -352,6 +352,12 @@ static const struct sun4i_pwm_data sun4i_pwm_sing=
le_bypass =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.npwm =3D 1,<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt; +static const struct sun4i_pwm_data sun50i_a64_pwm_data =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.has_prescaler_bypass =3D true,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.has_direct_mod_clk_output =3D true,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.npwm =3D 1,<br>
&gt; +};<br>
&gt; +<br>
&gt;=C2=A0 static const struct sun4i_pwm_data sun50i_h6_pwm_data =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.has_prescaler_bypass =3D true,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.has_direct_mod_clk_output =3D true,<br>
&gt; @@ -374,6 +380,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[=
] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}, {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.compatible =3D =
&quot;allwinner,sun8i-h3-pwm&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.data =3D &amp;s=
un4i_pwm_single_bypass,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}, {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.compatible =3D &quot=
;allwinner,sun50i-a64-pwm&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.data =3D &amp;sun50i=
_a64_pwm_data,<br>
<br>
Ie, if the OS only has support for the A13, then it will use it as an A13, =
and<br>
if it has support for the A64 variant, then it can use some more advanced<b=
r>
features.<br>
<br></blockquote><div>True, I didn&#39;t realize that when I was replicatin=
g H6 config. I just tested the original compatibility on Remix Mini and it =
works fine, I&#39;ll send an amended patch shortly.</div><div><br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
Maxime<br></blockquote><div><br></div><div>Thanks!</div><div>Peter</div><di=
v><br></div></div></div>

--0000000000002ecf0605a45c5c72--
