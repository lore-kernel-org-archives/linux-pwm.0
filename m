Return-path: <kernel-bounces@pengutronix.de>
Date: Tue, 9 Oct 2018 09:34:07 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20181009073407.GA5565@ulmo>
References: <20180820095221.fydcvtz7ppcymrta@pengutronix.de>
 <20180820144357.7206-1-u.kleine-koenig@pengutronix.de>
 <20180820144357.7206-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <20180820144357.7206-2-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] pwm: document the pin state after pwm_disable() to
 be undefined
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Gavin Schenk <g.schenk@eckelmann.de>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2018 at 04:43:56PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Contrarily to the common assumption that pwm_disable() stops the
> output at the state where it just happens to be, this isn't what the
> hardware does on some machines. For example on i.MX6 the pin goes to
> 0 level instead.
>=20
> Note this doesn't reduce the expressiveness of the pwm-API because if
> you want the PWM-Pin to stay at a given state, you are supposed to
> configure it to 0% or 100% duty cycle without calling pwm_disable().
> The backend driver is free to implement potential power savings
> already when the duty cycle changes to one of these two cases so this
> doesn't come at an increased runtime power cost (once the respective
> drivers are fixed).
>=20
> In return this allows to adhere to the API more easily for drivers that
> currently cannot know if it's ok to disable the hardware on
> pwm_disable() because the caller might or might not rely on the pin
> stopping at a certain level.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  Documentation/pwm.txt | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

I don't think this is correct. An API whose result is an undefined state
is useless in my opinion. So either we properly define what the state
should be after a disable operation, or we might as well just remove the
disable operation altogether.

=46rom an API point of view I think it makes more sense to define the
state after disable to be inactive, that is high for normal PWM and low
for inversed PWM. The reason for this is that the disabled state is
effectively what the reset state of the PWM would be. If the PWM is
inverted, typically the board design has a pull-up somewhere to avoid a
backlight or LED from getting enabled by default. In all other cases a
PWM pin is likely just going to default to low when disabled.

This also matches what all other drivers, and users, assume.

Thierry

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlu8WewACgkQ3SOs138+
s6GiWBAAqpR+4FRB2fZtqC5vXcpUGKCIeH8BoqQznPRCVOsYjtZDdCyfXdjZDazx
eD/mAFV0e1OIyOoqd6Z+HPJJ8kpQYX3nl3drxeoFjvef9uMPyF7DUIRYdoCzimMX
atlb3lD1+QKan3NRbDXDncD/txPkmGhEK2md2Q1pnKRosjbStv6XIAMRjpoVFPJd
y0dSF41eN4l+sM4gy2sRTJ0VGQCxqT3x8XDXnk2GqnMbRmlIbuFCikjOHPtLG+d7
oZGUPfcDx5RYpP2gb9jLX66WCZkxHdC16BdOpK0zX1dwpeNKrzohoMpfI1rkJ275
mSMMzNkLpVLQAZ051nD26JYjwoGe/h7R/Jo4fK58S9aYJhphSq9SyXqbF5GoKocw
Z115BwTM87bv+WMhhleQAecUi/WvbvecuxSyfMPXz8o+aAks5E0plSHg2wn2ne0R
dezku7aJIledwxx4Gs1NI9WxS4OXotYAjVeKCJToWj7Vj2M9rfZkKHMDt/xZemBo
twMUEjljPfuMazTRBJFYXUfj69NfsbYjGS+RCybMoBsW+cDrH6fhlENRNj+Zubup
LMlZYkgdFwf0uAc+YCnzWotqka9wMpaM6uI2io2fg6NLguE3Vc28PpCrBWc22S30
ZgDTFGdKuxwg/Qx1X1V2LG7HSRDjcPXcCb/SZzJuNpZlYky8YeA=
=C8GX
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
