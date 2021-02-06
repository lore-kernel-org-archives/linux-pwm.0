Return-path: <fengzheng923@gmail.com>
MIME-Version: 1.0
References: <20210203125317.1975-1-fengzheng923@gmail.com> <20210203154628.infi5jnlofdrysvs@gilmour>
 <CAE=m61-oXn8CkzUpSxkuS-gLkxjwd8wSeL42Q5T+27_V89xgNw@mail.gmail.com> <20210205161158.gqinjayxcihtiofe@gilmour>
In-Reply-To: <20210205161158.gqinjayxcihtiofe@gilmour>
From: =?UTF-8?B?54+t5rab?= <fengzheng923@gmail.com>
Date: Sat, 6 Feb 2021 21:27:30 +0800
Message-ID: <CAE=m6190zD55EL_VOmq=yKw471bxiRwZdjpVTyvNAAvofn9UPQ@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000bd21eb05baaae677"
Subject: Re: [PATCH v2] pwm: sunxi: Add Allwinner SoC PWM controller driver
To: Maxime Ripard <maxime@cerno.tech>
Cc: thierry.reding@gmail.com, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, wens@csie.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>

--000000000000bd21eb05baaae677
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Maxime Ripard <maxime@cerno.tech> =E4=BA=8E2021=E5=B9=B42=E6=9C=886=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=8812:12=E5=86=99=E9=81=93=EF=BC=9A

> Hi,
>
> On Thu, Feb 04, 2021 at 11:47:34AM +0800, =E7=8F=AD=E6=B6=9B wrote:
> > Maxime Ripard <maxime@cerno.tech> =E4=BA=8E2021=E5=B9=B42=E6=9C=883=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:46=E5=86=99=E9=81=93=EF=BC=9A
> >
> > > Hi,
> > >
> > > On Wed, Feb 03, 2021 at 08:53:17PM +0800, Ban Tao wrote:
> > > > From: Ban Tao <fengzheng923@gmail.com>
> > > >
> > > > The Allwinner R818, A133, R329, V536 and V833 has a new PWM
> controller
> > > > IP compared to the older Allwinner SoCs.
> > > >
> > > > Signed-off-by: Ban Tao <fengzheng923@gmail.com>
> > >
> > > Thanks for your patch. There's a bunch of warnings reported by
> > > checkpatch --strict, they should be addressed.
> > >
> > > > ---
> > > > v1->v2:
> > > > 1.delete unnecessary code.
> > > > 2.using a named define for some constants.
> > > > 3.Add comment in sun50i_pwm_config function.
> > > > 4.using dev_err_probe() for error handling.
> > > > 5.disable the clock after pwmchip_remove().
> > > > ---
> > > >  MAINTAINERS              |   6 +
> > > >  drivers/pwm/Kconfig      |  11 ++
> > > >  drivers/pwm/Makefile     |   1 +
> > > >  drivers/pwm/pwm-sun50i.c | 348
> +++++++++++++++++++++++++++++++++++++++
> > > >  4 files changed, 366 insertions(+)
> > > >  create mode 100644 drivers/pwm/pwm-sun50i.c
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index e73636b75f29..d33cf1b69b43 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -737,6 +737,12 @@ L:       linux-media@vger.kernel.org
> > > >  S:   Maintained
> > > >  F:   drivers/staging/media/sunxi/cedrus/
> > > >
> > > > +ALLWINNER PWM DRIVER
> > > > +M:   Ban Tao <fengzheng923@gmail.com>
> > > > +L:   linux-pwm@vger.kernel.org
> > > > +S:   Maintained
> > > > +F:   drivers/pwm/pwm-sun50i.c
> > > > +
> > > >  ALPHA PORT
> > > >  M:   Richard Henderson <rth@twiddle.net>
> > > >  M:   Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> > > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > > index 9a4f66ae8070..17635a8f2ed3 100644
> > > > --- a/drivers/pwm/Kconfig
> > > > +++ b/drivers/pwm/Kconfig
> > > > @@ -552,6 +552,17 @@ config PWM_SUN4I
> > > >         To compile this driver as a module, choose M here: the modu=
le
> > > >         will be called pwm-sun4i.
> > > >
> > > > +config PWM_SUN50I
> > > > +     tristate "Allwinner enhanced PWM support"
> > > > +     depends on ARCH_SUNXI || COMPILE_TEST
> > > > +     depends on HAS_IOMEM && COMMON_CLK
> > > > +     help
> > > > +       Enhanced PWM framework driver for Allwinner R818, A133, R32=
9,
> > > > +       V536 and V833 SoCs.
> > > > +
> > > > +       To compile this driver as a module, choose M here: the modu=
le
> > > > +       will be called pwm-sun50i.
> > > > +
> > >
> > > Even though it's unfortunate, there's a bunch of other SoCs part of t=
he
> > > sun50i family that are supported by the sun4i driver.
> > >
> > > Which SoC introduced that new design? It's usually the name we pick u=
p
> > > then.
> > >
> >
> > In fact, some SoCs has not been supported by the sun4i driver, such as
> v833,
> > v536, r818, a133 and r329.
> > v833 and v536 are part of the sun8i family, but r818, a133 and r329 are
> > part of the sun50i family.
>
> Indeed, I missed that sorry.
>
> > So,I'm confused, how do choose the name of this driver?
>
> Just go for the earliest SoC that introduced that design. What was the
> first SoC to use it?
>
> The V536 SOC first used this design, so, we should use the name
"sun8i-pwm.c"?


> > > > +static const struct sun50i_pwm_data sun8i_pwm_data_c9 =3D {
> > > > +     .npwm =3D 9,
> > > > +};
> > > > +
> > > > +static const struct sun50i_pwm_data sun50i_pwm_data_c16 =3D {
> > > > +     .npwm =3D 16,
> > > > +};
> > > > +
> > > > +static const struct of_device_id sun50i_pwm_dt_ids[] =3D {
> > > > +     {
> > > > +             .compatible =3D "allwinner,sun8i-v833-pwm",
> > > > +             .data =3D &sun8i_pwm_data_c9,
> > > > +     }, {
> > > > +             .compatible =3D "allwinner,sun8i-v536-pwm",
> > > > +             .data =3D &sun8i_pwm_data_c9,
> > > > +     }, {
> > > > +             .compatible =3D "allwinner,sun50i-r818-pwm",
> > > > +             .data =3D &sun50i_pwm_data_c16,
> > > > +     }, {
> > > > +             .compatible =3D "allwinner,sun50i-a133-pwm",
> > > > +             .data =3D &sun50i_pwm_data_c16,
> > > > +     }, {
> > > > +             .compatible =3D "allwinner,sun50i-r329-pwm",
> > > > +             .data =3D &sun8i_pwm_data_c9,
> > > > +     }, {
> > > > +             /* sentinel */
> > > > +     },
> > > > +};
> > > > +MODULE_DEVICE_TABLE(of, sun50i_pwm_dt_ids);
> > >
> > > What are the differences between all these SoCs? If there's none
> between
> > > the v833, v536 and R329, and between the r818 and the A133, you shoul=
d
> > > use the same compatible.
> >
> > Compared with the sun4i driver, this patch is a completely different PW=
M
> IP
> > controller.
>
> Sure, I didn't mean to compare it to sun4i. What I meant was that as far
> as these struct goes, the A133 and the R818 look to have the same PWM
> controller. Just like the v833, v536 and R329.
>
> If the PWM controllers are indeed identical across those SoCs, you can
> just use two compatibles, one for the PWM with 9 channels (again, the
> earliest SoC among the V833, v536 and r329), and one for the PWM with 16
> channels.
>
Ok i see what you mean.
 static const struct of_device_id sun50i_pwm_dt_ids[] =3D {
        {
                .compatible =3D "allwinner,sun8i-v536-pwm",
                .data =3D &sun8i_pwm_data_c9,
        }, {
                .compatible =3D "allwinner,sun50i-r818-pwm",
                .data =3D &sun50i_pwm_data_c16,
        }, {
                /* sentinel */
        },
};
is this OK? Just write two SoC for the " compatible "=EF=BC=9F

>
> None of those SoCs are supported at the moment in Linux though, so it
> would make more sense to support them first before adding a new driver
> for those SoCs, it's gonna be dead code otherwise.
>
> Maxime
>

--000000000000bd21eb05baaae677
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Maxime Ripard &lt;maxime@cerno.tech&g=
t; =E4=BA=8E2021=E5=B9=B42=E6=9C=886=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=
=E5=8D=8812:12=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">Hi,<br>
<br>
On Thu, Feb 04, 2021 at 11:47:34AM +0800, =E7=8F=AD=E6=B6=9B wrote:<br>
&gt; Maxime Ripard &lt;maxime@cerno.tech&gt; =E4=BA=8E2021=E5=B9=B42=E6=9C=
=883=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:46=E5=86=99=E9=81=93=
=EF=BC=9A<br>
&gt; <br>
&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt; On Wed, Feb 03, 2021 at 08:53:17PM +0800, Ban Tao wrote:<br>
&gt; &gt; &gt; From: Ban Tao &lt;<a href=3D"mailto:fengzheng923@gmail.com" =
target=3D"_blank">fengzheng923@gmail.com</a>&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The Allwinner R818, A133, R329, V536 and V833 has a new PWM =
controller<br>
&gt; &gt; &gt; IP compared to the older Allwinner SoCs.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Ban Tao &lt;<a href=3D"mailto:fengzheng923@gm=
ail.com" target=3D"_blank">fengzheng923@gmail.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Thanks for your patch. There&#39;s a bunch of warnings reported b=
y<br>
&gt; &gt; checkpatch --strict, they should be addressed.<br>
&gt; &gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt; v1-&gt;v2:<br>
&gt; &gt; &gt; 1.delete unnecessary code.<br>
&gt; &gt; &gt; 2.using a named define for some constants.<br>
&gt; &gt; &gt; 3.Add comment in sun50i_pwm_config function.<br>
&gt; &gt; &gt; 4.using dev_err_probe() for error handling.<br>
&gt; &gt; &gt; 5.disable the clock after pwmchip_remove().<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A06 +<br>
&gt; &gt; &gt;=C2=A0 drivers/pwm/Kconfig=C2=A0 =C2=A0 =C2=A0 |=C2=A0 11 ++<=
br>
&gt; &gt; &gt;=C2=A0 drivers/pwm/Makefile=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0=
1 +<br>
&gt; &gt; &gt;=C2=A0 drivers/pwm/pwm-sun50i.c | 348 +++++++++++++++++++++++=
++++++++++++++++<br>
&gt; &gt; &gt;=C2=A0 4 files changed, 366 insertions(+)<br>
&gt; &gt; &gt;=C2=A0 create mode 100644 drivers/pwm/pwm-sun50i.c<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; &gt; &gt; index e73636b75f29..d33cf1b69b43 100644<br>
&gt; &gt; &gt; --- a/MAINTAINERS<br>
&gt; &gt; &gt; +++ b/MAINTAINERS<br>
&gt; &gt; &gt; @@ -737,6 +737,12 @@ L:=C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D=
"mailto:linux-media@vger.kernel.org" target=3D"_blank">linux-media@vger.ker=
nel.org</a><br>
&gt; &gt; &gt;=C2=A0 S:=C2=A0 =C2=A0Maintained<br>
&gt; &gt; &gt;=C2=A0 F:=C2=A0 =C2=A0drivers/staging/media/sunxi/cedrus/<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +ALLWINNER PWM DRIVER<br>
&gt; &gt; &gt; +M:=C2=A0 =C2=A0Ban Tao &lt;<a href=3D"mailto:fengzheng923@g=
mail.com" target=3D"_blank">fengzheng923@gmail.com</a>&gt;<br>
&gt; &gt; &gt; +L:=C2=A0 =C2=A0<a href=3D"mailto:linux-pwm@vger.kernel.org"=
 target=3D"_blank">linux-pwm@vger.kernel.org</a><br>
&gt; &gt; &gt; +S:=C2=A0 =C2=A0Maintained<br>
&gt; &gt; &gt; +F:=C2=A0 =C2=A0drivers/pwm/pwm-sun50i.c<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 ALPHA PORT<br>
&gt; &gt; &gt;=C2=A0 M:=C2=A0 =C2=A0Richard Henderson &lt;<a href=3D"mailto=
:rth@twiddle.net" target=3D"_blank">rth@twiddle.net</a>&gt;<br>
&gt; &gt; &gt;=C2=A0 M:=C2=A0 =C2=A0Ivan Kokshaysky &lt;<a href=3D"mailto:i=
nk@jurassic.park.msu.ru" target=3D"_blank">ink@jurassic.park.msu.ru</a>&gt;=
<br>
&gt; &gt; &gt; diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig<br>
&gt; &gt; &gt; index 9a4f66ae8070..17635a8f2ed3 100644<br>
&gt; &gt; &gt; --- a/drivers/pwm/Kconfig<br>
&gt; &gt; &gt; +++ b/drivers/pwm/Kconfig<br>
&gt; &gt; &gt; @@ -552,6 +552,17 @@ config PWM_SUN4I<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0To compile this driver as a=
 module, choose M here: the module<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0will be called pwm-sun4i.<b=
r>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +config PWM_SUN50I<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0tristate &quot;Allwinner enhanced PWM s=
upport&quot;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0depends on ARCH_SUNXI || COMPILE_TEST<b=
r>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0depends on HAS_IOMEM &amp;&amp; COMMON_=
CLK<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0help<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0Enhanced PWM framework driver fo=
r Allwinner R818, A133, R329,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0V536 and V833 SoCs.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0To compile this driver as a modu=
le, choose M here: the module<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0will be called pwm-sun50i.<br>
&gt; &gt; &gt; +<br>
&gt; &gt;<br>
&gt; &gt; Even though it&#39;s unfortunate, there&#39;s a bunch of other So=
Cs part of the<br>
&gt; &gt; sun50i family that are supported by the sun4i driver.<br>
&gt; &gt;<br>
&gt; &gt; Which SoC introduced that new design? It&#39;s usually the name w=
e pick up<br>
&gt; &gt; then.<br>
&gt; &gt;<br>
&gt; <br>
&gt; In fact, some SoCs has not been supported by the sun4i driver, such as=
 v833,<br>
&gt; v536, r818, a133 and r329.<br>
&gt; v833 and v536 are part of the sun8i family, but r818, a133 and r329 ar=
e<br>
&gt; part of the sun50i family.<br>
<br>
Indeed, I missed that sorry. <br>
<br>
&gt; So,I&#39;m confused, how do choose the name of this driver?<br>
<br>
Just go for the earliest SoC that introduced that design. What was the<br>
first SoC to use it?<br>
<br></blockquote><div>The V536 SOC first used this design, so, we should us=
e the name &quot;sun8i-pwm.c&quot;?=C2=A0</div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
&gt; &gt; &gt; +static const struct sun50i_pwm_data sun8i_pwm_data_c9 =3D {=
<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0.npwm =3D 9,<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static const struct sun50i_pwm_data sun50i_pwm_data_c16 =3D=
 {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0.npwm =3D 16,<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +static const struct of_device_id sun50i_pwm_dt_ids[] =3D {<=
br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.compatible=
 =3D &quot;allwinner,sun8i-v833-pwm&quot;,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.data =3D &=
amp;sun8i_pwm_data_c9,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}, {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.compatible=
 =3D &quot;allwinner,sun8i-v536-pwm&quot;,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.data =3D &=
amp;sun8i_pwm_data_c9,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}, {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.compatible=
 =3D &quot;allwinner,sun50i-r818-pwm&quot;,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.data =3D &=
amp;sun50i_pwm_data_c16,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}, {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.compatible=
 =3D &quot;allwinner,sun50i-a133-pwm&quot;,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.data =3D &=
amp;sun50i_pwm_data_c16,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}, {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.compatible=
 =3D &quot;allwinner,sun50i-r329-pwm&quot;,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.data =3D &=
amp;sun8i_pwm_data_c9,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}, {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* sentinel=
 */<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0},<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +MODULE_DEVICE_TABLE(of, sun50i_pwm_dt_ids);<br>
&gt; &gt;<br>
&gt; &gt; What are the differences between all these SoCs? If there&#39;s n=
one between<br>
&gt; &gt; the v833, v536 and R329, and between the r818 and the A133, you s=
hould<br>
&gt; &gt; use the same compatible.<br>
&gt; <br>
&gt; Compared with the sun4i driver, this patch is a completely different P=
WM IP<br>
&gt; controller.<br>
<br>
Sure, I didn&#39;t mean to compare it to sun4i. What I meant was that as fa=
r<br>
as these struct goes, the A133 and the R818 look to have the same PWM<br>
controller. Just like the v833, v536 and R329.<br>
<br>
If the PWM controllers are indeed identical across those SoCs, you can<br>
just use two compatibles, one for the PWM with 9 channels (again, the<br>
earliest SoC among the V833, v536 and r329), and one for the PWM with 16<br=
>
channels.<br></blockquote><div>Ok i see what you mean.<br></div><div>=C2=A0=
static const struct of_device_id sun50i_pwm_dt_ids[] =3D {</div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 .compatible =3D &quot;allwinner,sun8i-v536-pwm&quot;,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .data =3D &amp;sun8i_pwm_data_c9,=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }, {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 .compatible =3D &quot;allwinner,sun50i-r818-pwm&quot;,=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .data =3D &amp;=
sun50i_pwm_data_c16,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }, {<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* sentinel */<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 },<br>};</div><div class=3D"gmail_quote">is this OK? Just wri=
te two SoC for the &quot;

compatible=20

&quot;=EF=BC=9F<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
None of those SoCs are supported at the moment in Linux though, so it<br>
would make more sense to support them first before adding a new driver<br>
for those SoCs, it&#39;s gonna be dead code otherwise.<br>
<br>
Maxime<br>
</blockquote></div></div>

--000000000000bd21eb05baaae677--
