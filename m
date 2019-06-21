From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 3/3] leds-pwm.c: support ACPI via firmware-node
 framework
Date: Fri, 21 Jun 2019 13:01:28 +0200
Message-ID: <20190621110128.GD24145@amd>
References: <cover.1560327219.git.nikolaus.voss@loewensteinmedical.de>
 <5df196d63671205d6722d21bec0ae5857a6b91eb.1560327219.git.nikolaus.voss@loewensteinmedical.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3Pql8miugIZX0722"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5df196d63671205d6722d21bec0ae5857a6b91eb.1560327219.git.nikolaus.voss@loewensteinmedical.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Dan Murphy <dmurphy@ti.com>, Thierry Reding <thierry.reding@gmail.com>, linux-acpi@vger.kernel.org, devel@acpica.org, linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, nv@vosn.de
List-Id: linux-pwm@vger.kernel.org


--3Pql8miugIZX0722
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-06-12 10:36:08, Nikolaus Voss wrote:
> DT specific handling is replaced by firmware-node abstration to support
> ACPI specification of PWM LEDS.
>=20
> Example ASL:
> Device (PWML)
> {
>     Name (_HID, "PRP0001")
>     Name (_DSD, Package () {
>           ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>           Package () { Package () {"compatible",
>                                     Package () {"pwm-leds"}}}})
>=20
>     Device (PWL0)
>     {
>         Name (_HID, "PRP0001")
>         Name (_DSD, Package () {
>               ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>               Package () {
>                            Package () {"label", "alarm-led"},
>                            Package () {"pwms", Package ()
>                                        {\_SB_.PCI0.PWM, 0, 600000, 0}},
>                            Package () {"linux,default-state", "off"}}})
>     }
> }
>=20
> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3Pql8miugIZX0722
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0MuQgACgkQMOfwapXb+vLdfQCdEXpSEGq2qMko5kRPf//HXH7j
GnMAoKHopDvN/1Q+REF1JJVm1jCtatXO
=4BB0
-----END PGP SIGNATURE-----

--3Pql8miugIZX0722--
