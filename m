From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: meson: fix mux clock names
Date: Mon, 20 Aug 2018 11:32:42 +0200
Message-ID: <20180820093242.GC8242@ulmo>
References: <20180801105720.23999-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180801105720.23999-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 12:57:20PM +0200, Jerome Brunet wrote:
> Current clock name looks like this:
> /soc/bus@ffd00000/pwm@1b000#mux0
>=20
> This is bad because CCF uses the clock to create a directory in clk debug=
fs.
> With such name, the directory creation (silently) fails and the debugfs
> entry end up being created at the debugfs root.
>=20
> With this change, the clock name will now be:
> ffd1b000.pwm#mux0
>=20
> This matches the clock naming scheme used in the ethernet and mmc driver.
> It also fixes the problem with debugfs.
>=20
> Fixes: 36af66a79056 ("pwm: Convert to using %pOF instead of full_name")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/pwm/pwm-meson.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

Thierry

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlt6iroACgkQ3SOs138+
s6Ek3w/8CJ+FuFrZL+LE/RFDTuEtukAo1boyyc1MykHQ8cHPRBBsiHXFhyKLVUsr
hz31W9xtX98G71ROnzpDbBFyS5j/SPnZLaIGFwbwEqAzIsKDS8MhkYH2wjEH0gVC
V9jNXqWYYiGItsGyfXkvPiSULD1OHKD6hpYDC4kQhe+WvFmCk9R/135X0myETf9S
sEa17iLJ6HAh0AvCV930agM2wZ5tEi1TRL/sfca0XS06Vx5qXtdy9dtaFlrKU6jW
w3cvHTf0bxCY7ShmNrzvE5esok2VV2wir5fwj6hIDUIK9crCvQ6QcOiMP2ZZHlrQ
kZgeC3T6O2hXkGWv/q4yjS6mj5It8zNcwAsX5EUoFept+6SCFZLU+1Z7ZqHrlP33
gknC6AHcutrK5r2Z7Q5p9eUkdRStlexpXok5LtrHoKjnPpuoIUuaIahFXZpidQ9d
lhfNTinvaq1Eu/oPcO4/JWI8GixACkLNgH7urUfvgV3YfQj4q4wQ3nTfHOOM7PnA
dJKk9GqsUf1f+oTgms+iBCnxGJ+AzhIeyr3wy2FiLljwicApwILe2xAXl1HqwT9R
YfTOn7ufs3EE3q1U6TaO/0H7QDVnHva6P5CjX2O3Gs8K1vz8QnXCA8vJUH0JB2WB
+p0trXuYlb1mkyKQb3MbB0vXuc1aRb7qsZ+qBQJq79Nx6Ia2CpU=
=LNSJ
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
