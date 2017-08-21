From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 069/102] pwm: hibvt: explicitly request exclusive reset
 control
Date: Mon, 21 Aug 2017 08:54:25 +0200
Message-ID: <20170821065425.GG18996@ulmo>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
 <20170719152646.25903-70-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L+ofChggJdETEG3Y"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170719152646.25903-70-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--L+ofChggJdETEG3Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2017 at 05:26:13PM +0200, Philipp Zabel wrote:
> Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
> reset lines") started to transition the reset control request API calls
> to explicitly state whether the driver needs exclusive or shared reset
> control behavior. Convert all drivers requesting exclusive resets to the
> explicit API call so the temporary transition helpers can be removed.
>=20
> No functional changes.
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: linux-pwm@vger.kernel.org
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/pwm/pwm-hibvt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-4.14/drivers, thanks.

Thierry

--L+ofChggJdETEG3Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmag54ACgkQ3SOs138+
s6E2yg//bQQ648x82pn8hvtvtF862CvZJr1OvIs9JURV5SbMCG56nimuLP9+oARs
9shy7E1OLrCwf4f1lGmsuJ3fzMD5tGtGYvDMc1fpj4hdxt7F/s6/XB0qgTgBb77j
avbp7oHPhtv8aJM046QgCU26XVg2xzzeRO7WCZEzsvPCNc0Od5X+/pInojew6BU8
hF+oav6OpMaGuAC9YJFlvFXMipzpiUc8peuI9Q3gw20KX/1zb7Ku4pK4Y6G42YHB
S/Z4hgi/ZOJ8SeAPNMnirdLAgEhVkloW6KoS8sxtapzjRhPYtlYI9J2wcM54GoFN
Zh2EMKr5UNNcHwIBhY4k/jU1AUnF4L0SGG5kc3s1Brra4Cv2SO2HGlDGNunOI8En
5HxX5Ob6LYIRoQMbCYkxDg/Cb6Gljp6eyhEeeMaW6u1dBfv/V/TfVQZyMLWbeuMB
lcsV7w3I07S0dBAjUrCNra45b7ujbVkqN+hH70M7HVeXLcFDHe+f8ogVr1rQn9LL
Gpw1cTbJ1l0ybGUIKZ8NrHg3SszvfEek2WeKKh+GXPtKXRCVvozOX8Qn8n3agLMk
ddrqc670Szlrqu1pAk6k+Nh6GpmpSSR+LPMbOlW/y3WMJr4Hv4+r+MK6VnXk5La6
N3c9tHkp8qEEVZPQKseMDPh7kG9sWv8RT0GvcKPqisVX0seE4+k=
=cW0g
-----END PGP SIGNATURE-----

--L+ofChggJdETEG3Y--
