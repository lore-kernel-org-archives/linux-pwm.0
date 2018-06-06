From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH RESEND] pwm: berlin: Don't use broken prescaler values
Date: Wed, 6 Jun 2018 11:44:26 +0200
Message-ID: <20180606094426.GI11810@ulmo>
References: <da60a97a0c6f754faa1f996334b3568ddb2f5ed0.1528137144.git.tommyhebb@gmail.com>
 <20180605091002.GB20649@ulmo>
 <75f1a632-80c3-1d99-8405-01fa9a4c2616@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HkMjoL2LAeBLhbFV"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <75f1a632-80c3-1d99-8405-01fa9a4c2616@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Hebb <tommyhebb@gmail.com>
Cc: linux-arm-kernel@vger.kernel.org, Antoine Tenart <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, jszhang@marvell.com, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org


--HkMjoL2LAeBLhbFV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2018 at 12:48:51PM -0400, Tom Hebb wrote:
> On 06/05/2018 05:10 AM, Thierry Reding wrote:
> > On Mon, Jun 04, 2018 at 02:32:41PM -0400, Thomas Hebb wrote:
> >> Six of the eight prescaler values available for Berlin PWM are not true
> >> prescalers but rather internal shifts that throw away the high bits of
> >> TCNT. Currently, we attempt to use those high bits, leading to erratic
> >> behavior. Restrict the prescaler configurations we select to only the
> >> two that respect the full range of TCNT.
> >>
> >> Tested on BG2CD.
> >>
> >> Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
> >> ---
> >>  drivers/pwm/pwm-berlin.c | 45 ++++++++++++++++++++++------------------
> >>  1 file changed, 25 insertions(+), 20 deletions(-)
> >=20
> > Antoine, Jisheng,
> >=20
> > can you guys review this patch? I'm personally on the fence about this,
> > even if we can technically do the shift in software, I don't necessarily
> > see a reason why we can't "offload" to the hardware.
> >=20
> > Thierry
>=20
> Sorry if my commit message was unclear: this patch doesn't just
> arbitrarily change the hw/sw division of responsibility. The driver in
> its current state is broken (at least on BG2CD), and this patch
> implements a fix.
>=20
> The reason the middle six prescaler values are useless is because they
> do not actually slow down the clock. Instead, they emulate slowing down
> the clock by internally multiplying TCNT.
>=20
> This would be a fine trick, if not for the fact that the internal TCNT
> value has no extra bits beyond the 16 already exposed to software by the
> register. What this means is that, for a prescaler of 4, the software
> must ensure that the top two bits of TCNT are not set, because hardware
> will chop them off; for a prescaler of 8, the top three bits must not be
> set, and so forth. Software does not currently ensure this, resulting in
> a TCNT several orders of magnitude lower than intended any time one of
> those six prescalers are selected.
>=20
> Because hardware chops off the high bits in its internal shift, the
> middle six prescalers don't actually allow *anything* that the first
> doesn't. In fact, they are strictly worse than the first, since the
> internal shift of TCNT prevents software from setting the low bits,
> decreasing the resolution, without providing any extra high bits.
>=20
> By skipping the useless prescalers entirely, this patch actually
> increases the driver's performance, since, when the 4096 prescaler is
> selected, it now does only a single shift rather than the seven
> successive divisions it did before.
>=20
> Let me know if any of this is still unclear, or if you'd like me to
> revise the commit message.

Perfect, the above, with slight adaptations, would make a great commit
message. =3D)

Thierry

--HkMjoL2LAeBLhbFV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlsXrPoACgkQ3SOs138+
s6GzxBAAj5Rgz9llkOkAO+xElptmSy+xjPnJ19nza0IIyS7y49dzz58ygvm5jzbA
ayS1kbldwx2UXao0lkSmU8YWkT28KC7RPv5BC6g0vE0Th1OgcKhousPCr159J8i3
BDi4TRGXsxLsegySklO89CJIK0Qsrzqok0A7TDDilGKtBAo35Bcoeg1lj32/sWic
c2EOJorKsm17nR6bPzcNIh8U3OM9bV2TUsps9EyR0i3M4NF+uT1iy4EnYMxKFGBA
jOjX6RqxlD0dG0ZcGeWGcQyMKoDPY5U0QAF0xSE5FHjPxPQOykkP+3zPbwE66oDG
J53ry8PDuJdXXPzcwUdeqaZOBxby6skyfKq8elPTIuw+MhpyRtG0HEu0c5qQ6ecf
BFVbsJ7rcshhDb6U+TdJvYegVGKNBxZmppXPay2U0JvrtrYo057BAEprzKg3HpEA
nSad4jy3G5C4sxe4bSR44H15GlEZ4UpajCEidkkMst0BHcBf/zohkACQbiKpRkrJ
L0IESJOR5EVmHhxMMlmby4cHNrZHjLtGVJBCGvmcAwSpBde44xhRYg5qi141G7IS
Prz33/O7HOE7zz3EoBMybA/8H0qIsqvABduTtdFuK8RWVcjL5TE6CvSyFe4ZzEJZ
Rs0C3wvZ1YgQRc9eEb1fdxD5B9XhzLQ8GNvUdkYiQxK7Yxi+BXk=
=19hr
-----END PGP SIGNATURE-----

--HkMjoL2LAeBLhbFV--
