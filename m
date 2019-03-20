From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: tiehrpwm: Update shadow register for disabling PWMs
Date: Wed, 20 Mar 2019 12:31:22 +0100
Message-ID: <20190320113122.GC23838@ulmo>
References: <20190312090846.29519-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190312090846.29519-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Christoph =?utf-8?Q?Vogtl=C3=A4nder?= <c.vogtlaender@sigma-surface-science.com>
List-Id: linux-pwm@vger.kernel.org


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2019 at 02:38:46PM +0530, Vignesh Raghavendra wrote:
> From: Christoph Vogtl=C3=A4nder <c.vogtlaender@sigma-surface-science.com>
>=20
> It must be made sure that immediate mode is not already set, when
> modifying shadow register value in ehrpwm_pwm_disable(). Otherwise
> modifications to the action-qualifier continuous S/W force
> register(AQSFRC) will be done in the active register.
> This may happen when both channels are being disabled. In this case,
> only the first channel state will be recorded as disabled in the shadow
> register. Later, when enabling the first channel again, the second
> channel would be enabled as well. Setting RLDCSF to zero, first, ensures
> that the shadow register is updated as desired.
>=20
> Fixes: 38dabd91ff0b ("pwm: tiehrpwm: Fix disabling of output of PWMs")
> Signed-off-by: Christoph Vogtl=C3=A4nder <c.vogtlaender@sigma-surface-sci=
ence.com>
> [vigneshr@ti.com: Improve commit message]
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  drivers/pwm/pwm-tiehrpwm.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

Thierry

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlySJIoACgkQ3SOs138+
s6GH9RAAlwIpQi4Gp8VyqL0xxWDtcvhjF+5T/vNJWUudy+Th2MB7bP8ou2KvZ/yZ
rvhJQXfkwdR61jaa6j2ZH68gbJAILEnbOlDLKgkfsQ16nTLYxJvI4VRy+OxvowKO
/yx08iYXiHdXpGEhnKWaLMYoBbimE0WE04PoHGhXTBWDsFfP1og/Tgvgps26BQ3j
Wpz7LrHcSuxTFSCIwDuLGFxv58zYb6wKgAv7DoeptJ3VUlDi6V/i7viHg9MWiq+U
psPPdHwW+0zhY6y5LxpUozQ9rGaCyRVbMYp1y5SfJUZaHYJcgO8JHO8YTMGqNViX
vp5wL2K4jE70TlMF8GGQnQYzF+RdDJr0XPXskz7hLzndjx5vre1w5ECilWbvpha6
aRLnMQpbI9enzX9SdeLH+/5qUrTC7gUO5HO9zaiu606w5SO6PGD/bknbRPO6zH3R
ilXolsxeLRX5PngnwPbtM1CEG5RAREKYZZHgYog8sEhLDdf2j3M9qRShBOk/3mlJ
Y3Tmj1Zu1ailuDeICwhKgDIG2DVZ26RquROq3TBnw6h/wVqd8KKLRf4zAzVG+gzx
0MTakHxT6Y+m2IWawQhpcC7pqLF+uEJwsHnSfr2uLc2ke+idnpXLxklFR8sD9vDM
cqpkaisS0F+ciKx8QnuPwVPxTAbvSb8R3AA1q/bvEyDllbKQjLs=
=VRBA
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
