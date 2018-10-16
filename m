From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC 1/4] pwm: sifive: Add DT documentation for SiFive PWM
 Controller.
Date: Wed, 17 Oct 2018 00:04:38 +0200
Message-ID: <20181016220437.GB31973@mithrandir>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-2-git-send-email-atish.patra@wdc.com>
 <20181010134926.GD21134@ulmo>
 <25758ab9-eb36-741b-6264-42412b3ddd8e@wdc.com>
 <20181016110142.GC8852@ulmo>
 <6e108e3c-15c1-b13b-ac3e-60c5eb209c7b@sifive.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6e108e3c-15c1-b13b-ac3e-60c5eb209c7b@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Atish Patra <atish.patra@wdc.com>, Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Wesley Terpstra <wesley@sifive.com>, linus.walleij@linaro.org, palmer@sifive.com, linux-kernel@vger.kernel.org, hch@infradead.org, linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 10:31:42AM -0700, Paul Walmsley wrote:
>=20
> On 10/16/18 4:01 AM, Thierry Reding wrote:
> > On Mon, Oct 15, 2018 at 03:57:35PM -0700, Atish Patra wrote:
> > > On 10/10/18 6:49 AM, Thierry Reding wrote:
> > > > On Tue, Oct 09, 2018 at 11:51:22AM -0700, Atish Patra wrote:
> > > > > +Required properties:
> > > > > +- compatible: should be one of
> > > > > +	"sifive,fu540-c000-pwm0","sifive,pwm0".
> > > > What's the '0' in here? A version number?
> > > >=20
> > > I think yes. Since fu540 is the first Linux capable RISC-V core, SiFi=
ve Guys
> > > decided mark it as version 0.
> > >=20
> > > @Wesly: Please correct me if I am wrong.
> > It seems fairly superfluous to me to have a version number in additon to
> > the fu540-c000, which already seems to be the core plus some sort of
> > part number. Do you really expect there to be any changes in the SoC
> > that would require a different compatible string at this point? If the
> > SoC has taped out, how will you ever get a different version of the PWM
> > IP in it?
> >=20
> > I would expect any improvements or changes to the PWM IP to show up in a
> > different SoC generation, at which point it would be something like
> > "sifive,fu640-c000" maybe, or perhaps "sifive,fu540-d000", or whatever
> > the numbering is.
>=20
>=20
> The "0" suffix refers to a revision number for the underlying PWM IP bloc=
k.
>=20
> It's certainly important to keep that version number on the "sifive,pwm0"
> compatible string that doesn't have the chip name associated with it.

Isn't the hardware identified by "sifive,pwm0" and "sifive,fu540-c000"
effectively identical? Is there a need to have two compatible strings
that refer to the exact same hardware?

> As to whether there could ever be a FU540-C000 part with different IP blo=
ck
> versions on it: FU540-C000 is ultimately a marketing name.=C2=A0 While
> theoretically we shouldn't have another "FU540-C000" chip with different
> peripheral IP block versions on it, I don't think any engineer can guaran=
tee
> that it won't happen.

I would argue that if at some point there was indeed a chip with the
same name but a different IP block version in it, we can figure out what
to call it. Sure there are no guarantees, but it's still fairly unlikely
in my opinion, so I personally wouldn't worry about this up front.

Anyway, I don't feel strongly either way, I'm just pointing out that
this is somewhat unusual. If you want to keep it, feel free to.

Thierry

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvGYHQACgkQ3SOs138+
s6Hahg/+NQ5CHvFT0bH8HcY8uoN6f7XFm/apwAkvBhdwjG5Cwrz5vvnWRk5T6kgu
Uwg9cLx/UDQPEoswnA6J7A/2UHzRojvLYhismbi4JPLxkTNEZEgwAN5VYbVrC1Dx
HBpFtfK30gXG207M27uMSOVf3xd4j1vYliUC662NG4cSOGZJZIjLRmooTIMPoYTk
ICh+GIvxgqw4PdgtyYGi1Yvi6upw9LqOSzUC0sQQNkQqZXv/4SwGeWxEGCOXNxof
Gvg3dUU5/N/jOQWlmZTSOuao1BeEUiGreLcCyv8PoMklYwFUJJlz0DauamuQGINy
WDtHAGcFiIRbrGNAVs59TSz0Wur/o3by9uRSE0UYfa2i2zrYE9PeNSGyunyeMrtu
VacYjYiGyUNRO20YGtn4/rHIOiPZT6vnFY+gj7q5T3q4KghiZgmoRhYHEagJwH8/
IwepyPsn3yKJvepitm1WF4oTQeyAYIIayTYKn25BXXtwv6T8oU6WYBDVvQttgLw4
m8kMf8DErLPwBBI8QGUGbrm5FpiJhX045kmRlSyqL6tXx/xopzNNdioRV7gRprE4
rBQfSrl90OxM9J58eUHeMmi/tasjlKAVmPoyUC04JyQM3IZIT/ZUYJ3sf/eYQigl
tjEHVAh68jtI8NJ1me9cT9z/7NoIDvG8qwQsFXytk51g7bu98DM=
=8BAi
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
