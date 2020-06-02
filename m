From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V4] pwm: tegra: dynamic clk freq configuration by PWM
 driver
Date: Tue, 2 Jun 2020 14:47:58 +0200
Message-ID: <20200602124758.GE3360525@ulmo>
References: <1590988836-11308-1-git-send-email-spatra@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k3qmt+ucFURmlhDS"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1590988836-11308-1-git-send-email-spatra@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sandipan Patra <spatra@nvidia.com>
Cc: treding@nvidia.com, jonathanh@nvidia.com, u.kleine-koenig@pengutronix.de, bbasu@nvidia.com, ldewangan@nvidia.com, kyarlagadda@nvidia.com, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--k3qmt+ucFURmlhDS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 01, 2020 at 10:50:36AM +0530, Sandipan Patra wrote:
> Added support for dynamic clock freq configuration in pwm kernel driver.
> Earlier the pwm driver used to cache boot time clock rate by pwm clock
> parent during probe. Hence dynamically changing pwm frequency was not
> possible for all the possible ranges. With this change, dynamic calculati=
on
> is enabled and it is able to set the requested period from sysfs knob
> provided the value is supported by clock source.
>=20
> Changes mainly have 2 parts:
>   - T186 and later chips [1]
>   - T210 and prior chips [2]
>=20
> For [1] - Changes implemented to set pwm period dynamically and
>           also checks added to allow only if requested period(ns) is
>           below or equals to higher range.
>=20
> For [2] - Only checks if the requested period(ns) is below or equals
>           to higher range defined by max clock limit. The limitation
>           in T210 or prior chips are due to the reason of having only
>           one pwm-controller supporting multiple channels. But later
>           chips have multiple pwm controller instances each having
> 	  single channel support.
>=20
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> ---
> PATCH V4:
> 1. Code comments fixes
>=20
> PATCH V3:
> 1. Return -EINVAL if requested period does not fall inside limit.
> 2. Store the new clock rate for further references.
> 3. Variable name change reverted.
> 4. Comments corrected and new comments are added.
>=20
> PATCH V2:
> 1. Maximum frequency calculation is moved to probe.
> 2. Added descriptions for PWM register bits and functional behavior
>    of the controller when new configuration is applied.
> 3. Setting period with possible value when supplied period is below limit.
> 4. Corrected the earlier code comment:
>    plus 1 instead of minus 1 during pwm calculation
>=20
>  drivers/pwm/pwm-tegra.c | 80 +++++++++++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 76 insertions(+), 4 deletions(-)

Applied, thanks.

Thierry

--k3qmt+ucFURmlhDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7WSn0ACgkQ3SOs138+
s6Gs2hAAuKnY8XRGX2cCIMv6LUK/mMn655EzVcw8MBN6IjTjqWgPbkQf590CXT0E
/YdjXLEMaijZhzvsffpkUZpRfQJkbmUqQ1fTLM1ag+6Y6NKWZrrz2XRE8HAmwjef
2Vz7qxFXPofe6KblDH6hdpMt0GiYgGKNr2SMPd/Mr8nGIcTFHjSz1J2jdXjHKi7d
3yrKgXH1/3YjjiYLuVqoritQlnwFVWELGargD4o7pDgu/9untwWLrCAVs7QH1ST2
6vZwChEsC9lHvg0GbA9Lz0QLXuFG89FDlpYGOnik96R3/8Lpq8hvXDlmn0ttJn6H
9SBzAWQpyMdz4GW0/a09o79YmzOLB4hH20du8s0nzB0i6QphMkZGjOeXNPkxHGU2
e2ga6dbvDFLHvN61xii91hMEwH1DvhL0uWgwwXmNq4Bsz205fjhubE6SptVQ6c6q
lNPh5JJuhKYyuWjRTWZyW8hx0VImqE89IAFkmLrEzeiasAPc/frvo3uCqrn46s+B
YouYpYk2STWRs9NiFTh5FRso86BSOovFqWS35DagLFcTHw7gGcbuzQMl3ZTfJKdQ
+29iq/Dx1U43IEA4YQj0zoGfnTglk+c/W91D69AicdbLVT5yScRpefmu9on654Lh
cjvAU1Yx5zgM5dXhdLw1dN5IVbcNIoR/rs4SmGORb4XpS0XKqyw=
=ZV5c
-----END PGP SIGNATURE-----

--k3qmt+ucFURmlhDS--
