From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 1/4] pwm: Add support for Meson PWM Controller
Date: Tue, 6 Sep 2016 11:07:49 +0200
Message-ID: <20160906090749.GA15644@ulmo.ba.sec>
References: <1471880193-21879-1-git-send-email-narmstrong@baylibre.com>
 <1471880193-21879-2-git-send-email-narmstrong@baylibre.com>
 <20160905090052.GG3532@ulmo.ba.sec>
 <bd7ea1db-d8f9-f075-14ef-732d9bb65e77@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33075 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933326AbcIFJHy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Sep 2016 05:07:54 -0400
Content-Disposition: inline
In-Reply-To: <bd7ea1db-d8f9-f075-14ef-732d9bb65e77@baylibre.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: carlo@caione.org, khilman@baylibre.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 06, 2016 at 10:36:49AM +0200, Neil Armstrong wrote:
> Hi Thierry,
>=20
> On 09/05/2016 11:00 AM, Thierry Reding wrote:
> > On Mon, Aug 22, 2016 at 05:36:30PM +0200, Neil Armstrong wrote:
> >> Add support for the PWM controller found in the Amlogic SoCs.
> >> This driver supports the Meson8b and GXBB SoCs.
> >>
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >> ---
> >>  drivers/pwm/Kconfig     |   9 +
> >>  drivers/pwm/Makefile    |   1 +
> >>  drivers/pwm/pwm-meson.c | 528 +++++++++++++++++++++++++++++++++++++++=
+++++++++
> >>  3 files changed, 538 insertions(+)
> >>  create mode 100644 drivers/pwm/pwm-meson.c
> >=20
> > Hi Neil,
> >=20
> > sorry for taking so long to review this. I had actually started to write
> > a review email since I had noticed a couple of slight oddities about the
> > driver structure (primarily this was about how channel-specific data was
> > split between struct meson_pwm_channel and struct meson_pwm_chip), but I
> > ended up making some changes to the driver in order to see what my
> > suggestions would look like, and if they would indeed improve things.
> > But once I had done that, I thought it a bit pointless to make that into
> > review comments and decided to just push what I had done and ask you to
> > take a look, and if you had no objections to the changes take the driver
> > for a spin to see if it still worked as expected.
>=20
> We re-run our tests and I found 2 bugs, the first one is in meson_pwm_ena=
ble(),
> only the channel A was setup, the fix is :
>=20
> static void meson_pwm_enable(...)
> -	u32 value, clk_shift, clk_enable, enable;
> +	u32 reg, value, clk_shift, clk_enable, enable;
>=20
>  	switch (id) {
>  	case 0:
> [...]
> +		reg =3D REG_PWM_A;
>  		break;
>  	case 1:
> [...]
> +		reg =3D REG_PWM_B;
>  		break;
>  	}
> [...]
> -	writel(value, meson->base + REG_PWM_A);
> +	writel(value, meson->base + reg);

Ah indeed. Good catch.

>=20
> The second bug is in probe(), I understand the point to allocate
> dynamically the channels and attach them to each pwm chip, but when
> calling meson_pwm_init_channels() we get an OOPS because
> meson->chip.pwms[i] are allocated in pwmchip_add(). Moving
> meson_pwm_init_channels() would fix this, but in case of a clk
> PROBE_DEFER, we would need to remove back the pwmchip, which is a
> quite a bad design decision....

Ah yes... that one again. I remember running into that a while ago with
some other driver. To be honest, I think that's a short-coming of the
PWM subsystem and the fix would be for PWM chip registration to be split
into two parts: pwm_chip_init() and pwm_chip_add(). That way, a chip
would be initialized using pwm_chip_init() where the pwms array would be
allocated, and pwm_chip_add() would register the chip with the system.

Currently a few drivers might be vulnerable to a race condition between
registration and implementation (i.e. PWM channels aren't fully set up
when they are exposed to users and sysfs).

> The smartest fix I found was to allocate channels in probe, init them
> them attach them after pwmchip_add():
>=20
> static int meson_pwm_init_channels(..., struct meson_pwm_channel *channel=
s)
> {
> +	struct meson_pwm_channel *channels;
> [...]
> -	for (i =3D 0; i < meson->chip.npwm; i++) {
> -		struct pwm_device *pwm =3D &meson->chip.pwms[i];
> -		struct meson_pwm_channel *channel;
> -
> -		channel =3D devm_kzalloc(dev, sizeof(*channel), GFP_KERNEL);
> -		if (!channel)
> -			return -ENOMEM;
> +	if (!channels)
> +		return -EINVAL;
>=20
> +	for (i =3D 0; i < meson->chip.npwm; i++) {
> [...]
> +		memset(&channels[i], 0, sizeof(struct meson_pwm_channel));
> [...]
> //Rename "channel->" into "channels[i]."//
> [...]
> -		pwm_set_chip_data(pwm, channel);
>  	}
>=20
>  	return 0;
> }
>=20
> +static void meson_pwm_add_channels_data(struct meson_pwm *meson,
> +					struct meson_pwm_channel *channels)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < meson->chip.npwm; i++)
> +		pwm_set_chip_data(&meson->chip.pwms[i], &channels[i]);
> +}
>=20
> static int meson_pwm_probe(struct platform_device *pdev)
> {
> +	struct meson_pwm_channel *channels;
> [...]
> -	err =3D meson_pwm_init_channels(meson);
> -	if (err < 0)
> -		return err;
> -
>  	meson->chip.dev =3D &pdev->dev;
> [...]
>  	meson->chip.of_pwm_n_cells =3D 3;
>=20
> +	channels =3D devm_kmalloc_array(&pdev->dev, 2, sizeof(*meson),
> +				      GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	err =3D meson_pwm_init_channels(meson, channels);
> +	if (err < 0)
> +		return err;
> +
>  	err =3D pwmchip_add(&meson->chip);
> [...]
> +	meson_pwm_add_channels_data(meson, channels);
> +
>  	platform_set_drvdata(pdev, meson);
>=20
>  	return 0;
> }

That's the race I was talking about above. I suppose it's not too big an
issue since other drivers seem to manage, so I'm going to merge your
fixed driver.

Unless you feel like taking a stab at the pwm_chip_init()/pwm_chip_add()
split, in which case your driver would be the first to be race-free. =3D)

Thierry

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzodjAAoJEN0jrNd/PrOhXmMP/0AUf3uZw4jv3L0Wy1gR6LOL
TIMix+HrMEsFiECXBx5mP5dzxs72+MIX0hjE8Tz6Au8G//YdwsAgcYhCnSsfxI1g
iyt/I7mQBcr4zxG7Wogord6+lYV2m21a+q2Y8dnEvgCalD6d51Jl/IlnS4jaBFMR
wam+NUvPCqj9iolhhoF6Mw/9x8wpTr5SypRFMlUXz0t9ETr2WUkV2+nNEjbTS641
Rc5hjVGvwp2ipfr2G1yaP1/2ZRaZ7IuyhvJgSOo1Zj/zTfAwxWS9Z6OAJiCG2zlV
7kyL+5N87HdM5tZ0Fkr+sGEq7oqusTp16WO+wb0PkR+dQwhCbpCW0nFY6U8OaIQ+
kQEBUT8BfAG4JsbJKp4NHS78WNGPDuZrPYqhb1O/MXjGnvniw23R1bTodSWmjKHp
qmfjfyNxPZbkPvozQPNSyAbFK0dnhaIV+yYjAGCFWyLib7/SMaKcn+7p8V620dyD
Fg4y9m3mIVKSb70CUq8u/73iBbqFj1Gl/8QUnuag3nViGPkS1aSzsT3o036i5qgw
xg8E37OC841PZoG457K9INKXTcCk//roymg+R/JJKl0sM09SDSJG01ozdRvOS7jm
ArgwcJY7fcNc6TzURdQIzPjNjPR6P0EO2HbP2n8JqB7xY71bkmMGGLfg0tDaL/nF
qHnfMFmZoe38KmbtlIdr
=vHvb
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
