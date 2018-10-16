From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC 1/4] pwm: sifive: Add DT documentation for SiFive PWM
 Controller.
Date: Tue, 16 Oct 2018 13:01:42 +0200
Message-ID: <20181016110142.GC8852@ulmo>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-2-git-send-email-atish.patra@wdc.com>
 <20181010134926.GD21134@ulmo>
 <25758ab9-eb36-741b-6264-42412b3ddd8e@wdc.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <25758ab9-eb36-741b-6264-42412b3ddd8e@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Atish Patra <atish.patra@wdc.com>, Rob Herring <robh+dt@kernel.org>
Cc: Wesley Terpstra <wesley@sifive.com>, palmer@sifive.com, linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, linus.walleij@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, hch@infradead.org
List-Id: linux-pwm@vger.kernel.org


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 03:57:35PM -0700, Atish Patra wrote:
> On 10/10/18 6:49 AM, Thierry Reding wrote:
> > On Tue, Oct 09, 2018 at 11:51:22AM -0700, Atish Patra wrote:
> > > From: "Wesley W. Terpstra" <wesley@sifive.com>
> > >=20
> > > DT documentation for PWM controller added with updated compatible
> > > string.
> > >=20
> > > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > > [Atish: Compatible string update]
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > ---
> > >   .../devicetree/bindings/pwm/pwm-sifive.txt         | 32 +++++++++++=
+++++++++++
> > >   1 file changed, 32 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive=
=2Etxt
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/D=
ocumentation/devicetree/bindings/pwm/pwm-sifive.txt
> > > new file mode 100644
> > > index 00000000..532b10fc
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > > @@ -0,0 +1,32 @@
> > > +SiFive PWM controller
> > > +
> > > +Unlike most other PWM controllers, the SiFive PWM controller current=
ly only
> > > +supports one period for all channels in the PWM. This is set globall=
y in DTS.
> > > +The period also has significant restrictions on the values it can ac=
hieve,
> > > +which the driver rounds to the nearest achievable frequency.
> >=20
> > What restrictions are these? If "nearest achievable" is too far off the
> > target period it might be preferable to error out.
> >=20
>=20
> @Wes: Any comments?
>=20
> > > +Required properties:
> > > +- compatible: should be one of
> > > +	"sifive,fu540-c000-pwm0","sifive,pwm0".
> >=20
> > What's the '0' in here? A version number?
> >=20
>=20
> I think yes. Since fu540 is the first Linux capable RISC-V core, SiFive G=
uys
> decided mark it as version 0.
>=20
> @Wesly: Please correct me if I am wrong.

It seems fairly superfluous to me to have a version number in additon to
the fu540-c000, which already seems to be the core plus some sort of
part number. Do you really expect there to be any changes in the SoC
that would require a different compatible string at this point? If the
SoC has taped out, how will you ever get a different version of the PWM
IP in it?

I would expect any improvements or changes to the PWM IP to show up in a
different SoC generation, at which point it would be something like
"sifive,fu640-c000" maybe, or perhaps "sifive,fu540-d000", or whatever
the numbering is.

> > > +	PWM controller is HiFive Unleashed specific chip which warrants a
> > > +	specific compatible string. The second string is kept for backward
> > > +	compatibility until a firmware update with latest compatible string.
> > > +- reg: physical base address and length of the controller's registers
> > > +- clocks: The frequency the controller runs at
> > > +- #pwm-cells: Should be 2.
> > > +  The first cell is the PWM channel number
> > > +  The second cell is the PWM polarity
> > > +- sifive,approx-period: the driver will get as close to this period =
as it can
> >=20
> > Given the above comment, maybe "sifive,period"?
> >=20
>=20
> ok.
> In Unleashed board, the DT is loaded by FSBL (first stage boot loader).
> Thus, changing device tree entries requires a FSBL update. If we update t=
his
> string, we need to update the driver to parse both properties so that
> existing devices with older firmware continue to work.
>=20
> This is probably ok as we anyways do that for compatible strings. Just
> wanted to update that here for the record.

I'm going to defer to Rob on this. He's said in the past that he doesn't
care about existing bindings that haven't been vetted through upstream,
even if that means that bootloaders may have to be updated. I know he's
been fairly strict on this in the past, but let's see if there is room
for exceptions.

Thierry

--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvFxRMACgkQ3SOs138+
s6GhURAAmC6vuSADDLFab6WEqwRLFGoo9to8KJZ7D+7hu7qf/bAwo8RXJ30UXWyE
72UmII/bY4sTDaBAPU0e4LhN7fwp4TaOWqV03FN2zalTxPeeVF7zEE7elulhsZNp
9UuSTvIAXvHK8FmE3mFoGXduSaDAfpDmx2CzLZrHtJ14JSK2xpRr6z7K2OX2XdWP
YsPglyv40v1e/x8p/GlsiO8fo8+AtOFyyCvIq/IcI+o3ynQZXwyYsGOdSrtPYHTj
51ZDLXJK4dAxLijoJ/MPpZGq50BNbtSlgsylEkHV/7iLhGqskQkjXlUlM1zPBTeX
VWHK+/akjOzlEhase3MaBA4wNgZZ0JPXWn+pUWIK4CjL9A6sTbxWEiVGBK9Heo5O
3ghb8BcJolWVgS0Z9xnamcs1SXODhqwQzZhVNNSW2xQTsdEW0+OKcwWuNANOOzrr
a7yZQYL55G+C3cBL74Kc4n82gjlIsl+q85OD0XMyhpoVRPd2SvLFqy7nHXVRl50K
PGEJNwLIFYgKzFcHUQI7uO+wBAo9Lx92QPBVtUJCrbBwJxcgkCXwwWMQqLyR5WbL
Uaw2K5rb6ICdIxzlsd4C97alXe/7xCU0tSLiUmieno02appctkBQEoceKqeVAbOZ
A2+T8lVGEmPg3ugVzeSyvJxDXo679KUNQAGHz7GgTg3yJmDhraI=
=UizH
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--
