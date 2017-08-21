From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: Convert to using %pOF instead of full_name
Date: Mon, 21 Aug 2017 08:57:32 +0200
Message-ID: <20170821065732.GI18996@ulmo>
References: <20170718214339.7774-45-robh@kernel.org>
 <20170725113854.GA22355@ulmo>
 <CAL_Jsq+Oumkr=Npktxz2RnC9EMf8QWgvaw8SKx1uCLbjQg==Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3U8TY7m7wOx7RL1F"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35836 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdHUG5g (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Aug 2017 02:57:36 -0400
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+Oumkr=Npktxz2RnC9EMf8QWgvaw8SKx1uCLbjQg==Vg@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, Linux PWM List <linux-pwm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-amlogic@lists.infradead.org


--3U8TY7m7wOx7RL1F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2017 at 05:12:55PM -0500, Rob Herring wrote:
> On Tue, Jul 25, 2017 at 6:38 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > On Tue, Jul 18, 2017 at 04:43:25PM -0500, Rob Herring wrote:
> >> Now that we have a custom printf format specifier, convert users of
> >> full_name to use %pOF instead. This is preparation to remove storing
> >> of the full path string for each node.
> >>
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >> Cc: Thierry Reding <thierry.reding@gmail.com>
> >> Cc: Carlo Caione <carlo@caione.org>
> >> Cc: Kevin Hilman <khilman@baylibre.com>
> >> Cc: linux-pwm@vger.kernel.org
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: linux-amlogic@lists.infradead.org
> >> ---
> >>  drivers/pwm/pwm-meson.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Applied, thanks.
>=20
> This is not showing up in -next.

Yes, I had forgotten to push this out. I've done that now, so it should
be in the next -next.

Thierry

--3U8TY7m7wOx7RL1F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmahFwACgkQ3SOs138+
s6GVDw/8CzXgEl+fJxpljAZ/ku2hPpZyyMPn8y/gRDQodBks01udSYleTW8rcpSx
VHex+hsEsmSXwcD0cL1x9AQD13PuA+R3elfi+24WclSLg9hfE5M80G01YJaXB2zO
bH/8fGo/7UfcBu1fynf2cxvxoG3xJvd0Zows0S9gULZZ5hh6XYFRBxev5toYscUF
rsmZEplkTtc0m6aNdH6Q+ol8Ul6J0sPvDsI+Tn4RXBe48zgdn4ZSXOvUXFGq4Sa1
qdzYuxVJavRO9SllOlXmjio2s/bFTVcM419KY5wLa/tJqYxp/D673nho0SA2lF8q
08vWuwB1XvbtcWvR+KgL/iP7krgpm1QFAFUFabigzUMovrRmxLl0yFHGWGZcvk2v
vjlQENGNbxVtd/ZEI6222MS8BoGi80/od02W8Ix3/pGcxZgjAUCMBa0J9GrjgBEr
Uuyab4+rBs4BmtqMU37gdYJ/zeuBLNuebJcUscKH6z9QMMnfhUt4TYhSBIjkhxLb
M6bps3PgmQHqS/iI9bbWtAmlAGYr6bK30y2xclDASzFeYSFAgNVlT7zrhfT8A5Wr
ohv1l0xDbWItrVEYzBIuf7KSwA0fihwiXSbaJguUspjye3KmvhRcKz0wCZ22Yspr
6KvHvYE65JUZxB7Bw8RRCPA72TUBWPZW4LXUOoA41VNzXXtcUCs=
=5e/k
-----END PGP SIGNATURE-----

--3U8TY7m7wOx7RL1F--
