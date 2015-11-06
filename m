From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 03/10] pwm: sunxi: Yield some time to the pwm-block to
 become ready
Date: Fri, 6 Nov 2015 17:12:53 +0100
Message-ID: <20151106161253.GH8418@ulmo>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
 <1445895161-2317-4-git-send-email-o.schinagl@ultimaker.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OgApRN/oydYDdnYz"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36602 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbbKFQM4 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Nov 2015 11:12:56 -0500
Content-Disposition: inline
In-Reply-To: <1445895161-2317-4-git-send-email-o.schinagl@ultimaker.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Olliver Schinagl <o.schinagl@ultimaker.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Olliver Schinagl <oliver@schinagl.nl>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Joachim Eastwood <manabian@gmail.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Olliver Schinagl <oliver+list@schinagl.nl>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--OgApRN/oydYDdnYz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2015 at 10:32:34PM +0100, Olliver Schinagl wrote:
> The pwm-block of some of the sunxi chips feature a 'ready' flag to
> indicate the software that it is ready for new commands.
>=20
> Right now, when we call pwm_config and set the period, we write the
> values to the registers, and turn off the clock to the IP. Because of
> this, the hardware does not have time to configure the hardware and set
> the 'ready' flag.
>=20
> By running the clock just before making new changes and before checking
> if the hardware is ready, the hardware has time to reconfigure itself
> and set the clear the flag appropriately.
>=20
> Signed-off-by: Olliver Schinagl <o.schinagl@ultimaker.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 43 +++++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 18 deletions(-)

This looks okay to me (except for one minor thing I noticed, see below),
but I'd like an Acked-by from one of the sunxi people. Maxime, any
comments on this?

> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 58ff424..4d84d9d 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -104,6 +104,22 @@ static int sun4i_pwm_config(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  	u64 clk_rate, div =3D 0;
>  	unsigned int prescaler =3D 0;
>  	int err;
> +	int ret =3D 0;

Why not reuse err?

Thierry

--OgApRN/oydYDdnYz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWPNGFAAoJEN0jrNd/PrOhcqUP/A5PtWBqEDEazT77qFlANp1b
/F3Yf7B8BK8nntILKSqFYsYR0F4+gElroIqsmVWn8dQdsORvLWzD4TyrLq9fU5Fg
sQNLGF4WaSJXboPbjQ0erjin/89SraEHWvmgmVAIMGvpImSK84WC2WvkPLlVB/zU
oBqyXShFNgtFVM0CG/P6pF3IAkL7AnHTEefTmOnfRCFxyFpTtmcEIAgYP/Up7d6X
pjwIlcH1LX5Jf/2+GOsclYMFAXlnqwbYRZpseblgUhErBOku97o/1znS3iTsC4Cb
j19clRSW3XyoVrlVuWMYualWppDgFuqPNaN/1TG/Zmxj2aN4qL+mJEC2JJbBy9p4
HyzO3D7PGsm12hYhX7t4xj1vDOfUQnsNbmBTHFDPEfo+XSbUMYoUfdM2wSDK01Gf
mXfFpKQkJpTpvK3p6Gdo5VNTWSR4hsLxqZPJhBhmbFPSom5AwnyklH6y5e4AMxQi
VCg5MGZtmS817HSOm0jJVow4iq435aGQ0AVD0F7sx0hzMCnMKhvQ2FBPmIM2kmZ/
q9UpFnpUhWlcRsNvliU4U9HE53+SWVshfsaukZuNayUmMiIJuAmlW+ZSz0lZJ1Jk
hImGmSxoRUrlLOV2VUSAIL8bUrXZ8b6EXVk+RPM4MF2/vygO0J0Fnr/0OdQlvPLj
GvCl8OMC0YkiXcW9ST69
=bXu/
-----END PGP SIGNATURE-----

--OgApRN/oydYDdnYz--
