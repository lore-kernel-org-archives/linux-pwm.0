From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/1] pwm: Convert period and duty cycle to u64
Date: Wed, 16 Oct 2019 12:15:39 +0200
Message-ID: <20191016101539.GC1303817@ulmo>
References: <1571191899-6150-1-git-send-email-gurus@codeaurora.org>
 <1571191899-6150-2-git-send-email-gurus@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1571191899-6150-2-git-send-email-gurus@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: linux-pwm@vger.kernel.org, kernel-team@android.com, Mark Salyzyn <salyzyn@google.com>, Sandeep Patil <sspatil@google.com>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2019 at 07:11:39PM -0700, Guru Das Srinagesh wrote:
> Because period and duty cycle are defined as ints with units of
> nanoseconds, the maximum time duration that can be set is limited to
> ~2.147 seconds. Change their definitions to u64 so that higher durations
> may be set.
>=20
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  drivers/pwm/core.c  |  4 ++--
>  drivers/pwm/sysfs.c | 10 +++++-----
>  include/linux/pwm.h | 16 ++++++++--------
>  3 files changed, 15 insertions(+), 15 deletions(-)

Actually, we can't do that without further preparatory work. The reason
is that consumers use the period and duty_cycle members in computations
of their own, which lead to errors such as this:

	armv7l-unknown-linux-gnueabihf-ld: drivers/video/backlight/pwm_bl.o: in fu=
nction `pwm_backlight_probe':
	pwm_bl.c:(.text+0x3b0): undefined reference to `__aeabi_uldivmod'

So I think we need to audit all consumers carefully and make sure that
they use do_div() where necessary to avoid such errors.

Thierry

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2m7ckACgkQ3SOs138+
s6E3vRAAnNeRoEkw1nWChlsRV2oFUeMV8EhmXTwbwrqtiCWmnOjb+/EOZEnMSemA
hmjdlh2370rL41Gubfgw0xk8Y/ndu60GtgoaW0KMJvcgYrfxtb72ocoJ+LREDHTq
YZOYVUaouvpqTqjRil81m6mSdOh+yuwTvL1Ey+rbiBP4FJ+tomPYqwXfIgr0ckxQ
dQ0BUN6NcAph6j1IadOq3baRStp6Kh74lkLnMbHQ5J8l/EWlfx4sL9jim5E4B/pi
umbV5HUo12yslZ9Rv991p9gk8H87tVgPzjUp6L1xdLQvevuTL5nDPmBjPlYCJPcT
nhLNWQeXJoKT6smGRasNTA1YFIB52Zz0+2RnhzwhSo86xMs0Eo4GmLSFIB7kGY+i
P8OXO68Ak3hcD5hwb0uftnTwleVDhmxhBzT1yvWG1cO9qzGPq54UuJQcJrjEslOm
FrHkmIk7IkqVIQPCWYZTG2qqc1+mlksnJC1zJ5tZjVPdGnFnbUOACXF0WEyI83xO
cUln72zQBf1cm06DNH+50zrUbjRyRK3poQaQ/RLYZvfGVICe2s1q5CzqJnpg5Ggb
/pofEITAj7ehCarLCb0nnyK1pTWl3MLtIStJ3kitDnmEwMo5LahtG3/HN8JZupuL
BIeelKTY8NqjYaOFFW+lw/x1JssudLHasSNVGX0MMb/5Y9oPYrg=
=wQCl
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
