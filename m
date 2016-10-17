From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/5] pwm: sun4i: Add support for PWM
 controller on sun6i SoCs
Date: Mon, 17 Oct 2016 22:08:26 +0200
Message-ID: <20161017200826.jfsbgnurjye4wsdh@lukather>
References: <20161012042059.40015-1-icenowy@aosc.xyz>
 <20161012042059.40015-2-icenowy@aosc.xyz>
 <CAGb2v65P7SQyEv+b0mU_FA=CQxy7qX9h7HE4NivqjZ-ZBh94ww@mail.gmail.com>
 <1476259803.2317.2.camel@Nokia-N900>
 <20161014125743.ykgeiqr4tynq7cmg@lukather>
 <4823581476628157@web22j.yandex.ru>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kkwarfpnym3epiaj"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBXW7STAAKGQEWHE7WSI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <4823581476628157-Lmo0JfpuFbtxpj1cXAZ9Bg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Cc: "wens-jdAy2FN1RRM@public.gmane.org" <wens-jdAy2FN1RRM@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org


--kkwarfpnym3epiaj
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Icenowy,

On Sun, Oct 16, 2016 at 10:29:17PM +0800, Icenowy Zheng wrote:
> Hi,
>=20
> 14.10.2016, 20:58, "Maxime Ripard" <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>:
> > Hi,
> >
> > On Wed, Oct 12, 2016 at 04:10:03PM +0800, Icenowy Zheng wrote:
> >> =C2=A0> On Wed, Oct 12, 2016 at 12:20 PM, Icenowy Zheng <icenowy@aosc.=
xyz> wrote:
> >> =C2=A0> > The PWM controller in A31 is different with other Allwinner =
SoCs, with
> >> =C2=A0> > a control register per channel (in other SoCs the control re=
gister is
> >> =C2=A0> > shared), and each channel are allocated 16 bytes of address =
(but only 8
> >> =C2=A0> > bytes are used.). The register map in one channel is just li=
ke a
> >> =C2=A0> > single-channel A10 PWM controller, however, A31 have a diffe=
rent
> >> =C2=A0> > prescaler table than other SoCs.
> >> =C2=A0> >
> >> =C2=A0> > In order to use the driver for all 4 channels, device nodes =
should be
> >> =C2=A0> > created per channel.
> >> =C2=A0>
> >> =C2=A0> I think Maxime wants you to support the different register off=
sets
> >> =C2=A0> in this driver, and have all 4 channels in the same device (no=
de).
> >>
> >> =C2=A0I think that will make the code much more complex... And in
> >> =C2=A0hardware there may also be 4 controllers... as the register is
> >> =C2=A0aligned at 0x10.
> >
> > You also have to think about it the other way around. This is exposed
> > everywhere as a single device. There may be some undocumented
> > registers hidden somewhere in the memory space of that device. How
> > would you deal with that without touching the device tree?
>=20
> Is the reason only they're listed in the one chapter of user manual?

Well, yes, because it is one single device.

> >
> > Exposing this as a single device is the best solution both from the
> > philosophical point of view, but also from a maintainance aspect.
>=20
> If we really do so, I will go back to the original patch (pwm-sun6i)
> and merge 4 channels.
>=20
> No other PWM block of Allwinner devices uses 4 control registers, and it'=
s
> a significant difference to make it a dedicated driver.
>=20
> However, I still think we should have 4 nodes, since the 4 channels can w=
ork
> very dedicatedly, with different control register... This can be a reason=
 to see
> them as 4 dedicated controllers.
>=20
> (And as PWM uses only oscXX, we cannot judge it according to the clock tr=
ee,
> and Occam's Razor will apply to think it's 4 A10-like PWM controller...)
>=20
> If we just think it's because it's a whole part, why don't we combine ehc=
i and ohci
> to one driver? Just because we can reuse {e,o}hci-platform...
>=20
> It's the same reason to see it as 4 controllers.

Duplicating code is usually not a good idea. In this case, this will
be easier for you to deal with the A31 PWM, but all the rest of the
code (how to enable, disable it, setup the rates, when to enable the
clocks, when to disable them) will be duplicated, even though part of
them are really non-trivial.

Have you looked at reg_field? It really allows you to deal quite
cleanly with those kinds of quirks.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--kkwarfpnym3epiaj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYBS+5AAoJEBx+YmzsjxAg6/YQALeCO65UINxbv5LllJZelxuy
nr4ASB00iSGzm0O3Hth607FOE4PH5TEAcdVr2Dnd2trwUMUJjUCBfbHnGtAalPPT
JlkTjCUjly+xUWQHNixP0E7rDEiyTYDhLi3gr5yEnFcLfUS386OKFd0NAZZCYlJX
cx1k69GUfiqHJY3DiqtB4oTVH8ARN1rK4C0ZEERU2F3YwehKpIx+eQOOHKkfDUeG
7edEUdL0m66M4kyJrfQ4PWC3WmWtVAUtF7xQ+/O444Yz2zrDwY0FaW7PVQxG1Tya
mBxCmb4+DvMK2VyMGQlLgVk0aFLS50WwnkD+CcqLJtIuREpp6xCxQEcN96AdNSYE
I9qCvAGYfwaG85N+2ySiE+YHs9IA2eAd5m45GuLMD/0GNTr7/7qAjj9UYZ3g/HWm
FreavM/GPg+25d2eOxVMENlluavEnsA7wzNgqUfW2uz2EVlS0cevep5gj9ykcoHu
TeT4vGSk785ytqQlTCgsPFljENertoN8croFqGs8DQ8oiZLL75k01RFz8lYADkCD
Y4AUluCuHt+t9aTW2s0dZhbbp+j+8pE9tChScSG9kjIUDJP4Y4kpBNZ0yVkBpdvH
wM0sdLjpNXuCfVusWks0upbli1sR0aUY1PzwFTsMGkAiBv7Dp2YhL9BOL64bQDrF
mgdMVkf79P8ADmXTaZEY
=npWY
-----END PGP SIGNATURE-----

--kkwarfpnym3epiaj--
