From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND PATCH v5 0/9] extend PWM framework to support PWM modes
Date: Tue, 16 Oct 2018 14:03:21 +0200
Message-ID: <20181016120321.GG8852@ulmo>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
 <b95d0de2-1a97-36f0-03ad-3b5e52b1fa5d@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hTiIB9CRvBOLTyqY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b95d0de2-1a97-36f0-03ad-3b5e52b1fa5d@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>, Rob Herring <robh+dt@kernel.org>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>, alexandre.belloni@bootlin.com, linux-pwm@vger.kernel.org, treding@nvidia.com, shc_work@mail.ru, mark.rutland@arm.com, corbet@lwn.net, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
List-Id: linux-pwm@vger.kernel.org


--hTiIB9CRvBOLTyqY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 14, 2018 at 06:20:48PM +0200, Nicolas Ferre wrote:
> Thierry,
>=20
> On 28/08/2018 at 15:01, Claudiu Beznea wrote:
> > Hi,
> >=20
> > Please give feedback on these patches which extends the PWM framework in
> > order to support multiple PWM modes of operations. This series is a rew=
ork
> > of [1] and [2].
>=20
> This series started with a RFC back on 5 April 2017 "extend PWM framework=
 to
> support PWM modes". The continuous work starting with v2 of this series on
> January 12, 2018.
>=20
> Then Claudiu tried to address all comments up to v4 which didn't have any
> more reviews. He posted a v5 without comments since May 22, 2018. This
> series is basically a resent of the v5 (as said in the $subject).
>=20
> We would like to know what is preventing this series to be included in the
> PWM sub-system. Note that if some issue still remain with it, we are ready
> to help to solve them.
>=20
> Without feedback from you side, we fear that we would miss a merge window
> again for no obvious reason (DT part is Acked by Rob: patch 5/9).

First off, apologies for not getting around to this earlier.

I think this series is mostly fine, but I still have doubts about the DT
aspects of this. In particular, Rob raised a concern about this here:

	https://lkml.org/lkml/2018/1/22/655

and it seems like that particular question was never fully resolved as
the discussion veered off that particular topic. I know that Rob acked
the DT parts of this, but I suspect that this might have been glossed
over.

To restate the concern: these extended modes have special uses and none
of the users in the kernel, other than sysfs, can use anything other
than the normal mode. They may work fine with other modes, but only if
they ignore the extras that come with them. Therefore I think it's safe
to say that anyone who would want to use these modes would want to
explicitly say so. For example the sysfs interface already does that by
changing the mode only after the "mode" attribute is written. Any users
for special use-cases would want to do the same thing, that is, drive a
PWM in a specific mode, on purpose. You wouldn't have a "generic" user
such as pwm-backlight or leds-pwm request anything other than the normal
mode.

So my question is, do we really need to represent these modes in DT? The
series currently doesn't contain any patches that add users of these new
modes. Are such patches available somewhere, or is the only user of this
supposed to be sysfs?

I'm hesitant to move forward with this as-is without seeing how it will
be used. The PWM specifier flags are somewhat abused by adding modes to
them. I think this hasn't been completely thought through, because the
only reason to specify a mode is to actually set that mode. But then the
DT ABI allows a bitmask of modes to be requested via DT. I know that
only the first of those modes will end up being used, but then why even
allow it in the first place?

And again, even if we allow the mode to be specified in DT, how do the
consumer drivers know that the correct mode was being set in DT. Let's
say we have a consumer that requires the PWM to be driven in
complementary mode. Should it rely on the DT to contain the correct
specification for the mode? And if it knows that it needs complementary
mode, why not just set that mode itself? That way there's no margin for
error.

Thierry

--hTiIB9CRvBOLTyqY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvF04cACgkQ3SOs138+
s6GG0hAAlC2Z3aJHAYoeHw4ddR2xifXrA2kY8m2t9zCD2M+xV2MKYEfTrCDdcFwE
SqIcFv/5rxHCpuxRCe2iaAOEHmg8BbJzmmil00WJ09J+rRCmkQDuaIoiFZTbHfxg
6LJY+qofpaNOXT5VwIM38ZD3Qgp8/+kyxTKZ6bWe5dvBq/36v21A/3rTA2Xm4BEv
SzaaCcIkULGvRAEpqkolMXok/QoE4R7tf+9N9xD76YRYAfLl73tqoZFf4JUubFuN
r3KtjmYX5GuAB8l/41tMidbC91zlFs9H2pd/bz4oyzwb5f2A+gHoGuZMxBQfy0kh
z9vqS/PPnAzDoCZ6RsB3kU/P82ZcHydcfvtOIfwpZjJybiwiSD3eXQdbTgVrx/nO
FmKZ7quScUQS0PyY9j4h/XJ0Tml8+9/TAsdlOORMjIU2kpQLhXWYlWDG1RAMlpMJ
PI+z4ATJGZv0XDDXaDGFxlQ2z4v/+1kANLgd2V5sBUwcQIxRHGD+lDGyL0+8WJXc
C+X9YVxYwut6rfm0dr+f9YBeq+ffT2RoDejHL6bmYB7KOh8HRbJaeNF3uqbYP0UN
2K4c+P0+1xFk/fQqi+NsFYJp0QCBcaWQigrfPNR88BxHh+R6MoGu14aDWnxTohsO
/TJGLriOaUGybg4pyRCA3kW0iODH2U9xSwGh195PYpUM/DC0oCc=
=c3h/
-----END PGP SIGNATURE-----

--hTiIB9CRvBOLTyqY--
