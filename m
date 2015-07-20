From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 2/2] pwm-pca9685: Support changing the output frequency
Date: Mon, 20 Jul 2015 11:30:22 +0200
Message-ID: <20150720093011.GQ29614@ulmo>
References: <1437381369-8502-1-git-send-email-clemens.gruber@pqgruber.com>
 <1437381369-8502-3-git-send-email-clemens.gruber@pqgruber.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oDto3OTLsk6uOlQH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437381369-8502-3-git-send-email-clemens.gruber@pqgruber.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org


--oDto3OTLsk6uOlQH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2015 at 10:36:09AM +0200, Clemens Gruber wrote:
> Previously, period_ns and duty_ns were only used to determine the
> ratio of ON and OFF time, the default frequency of 200 Hz was never
> changed.
> The PCA9685 however is capable of changing the PWM output frequency,
> which is expected when changing the period.
>=20
> This patch configures the prescaler accordingly, using the formula
> and notes provided in the PCA9685 datasheet.
> Bounds checking for the minimum and maximum frequencies, last updated
> in revision v.4 of said datasheet, is also added.
>=20
> The prescaler is only touched if the period changed, because we have to
> put the chip into sleep mode to unlock the prescale register.
> If it is changed, the PWM output frequency changes for all outputs,
> because there is one prescaler per chip. This is documented in the
> PCA9685 datasheet and in the comments.

I think the reason why the driver doesn't support changing the frequency
is precisely because it has a per-chip prescaler. So you'd be changing
the frequency from other all other users if one of the channels requests
to do so. If I remember correctly there had been some discussion back at
the time that this wasn't safe to do.

If you have to do this, I'd think you'd need to at least update the duty
cycle of all other users according to the new period.

Thierry

--oDto3OTLsk6uOlQH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVrL+jAAoJEN0jrNd/PrOhdKQQAKqVFXFzbx4UTZ0eqiqlp1s8
BVJFM09mfyTdtVsnZF5ylmtc52r6mkRS579MoRMmlF4kWWEin4hnLPL9EEs5LLHI
eczWEDhgqldKVePS4phLbsuwIiX17h04ZD/p3XR+hz7VxhqzMBEhkE37C0yc2jMP
bd4argl1rfPp4i2D5LiX0bGqNY4Vlk9hW1sDRckNVxrd3hJht/0Ffsv61xleNafY
qk5H6D+/Pb3s73ro3n1fflpXN4CpEV+00lxJEsQNJpz+sbKgNc50Sc3bd0gVJygm
Slvj0X0aFTVgPcOWkaUD0gRa/0WQkqp76HB0iIWU+YZE/a1swalZQDHVueB9S9f/
oq+OaufqCdg2KHXisR4HLSvkIAp0hlEmKgowshS0BK9amxn2aRnJun0S/EX+Ygtc
9B8x/k+q1zWtUy2VeaxvJBk0MKnK8SItVbTSI8ytl7bb8JjvlTkzvdC/JxcWv3sz
VLbExk7m752oJIh4ooS9B9/eJX2QfpiGvVmLAlggmtVc6UW+GmgTb8RnwGeZl+JT
SY/vZP+O4/wSzAIslDZ/R/m6R8F+1Q2/6rffASfR1Pe68ujQw5DlAVRY+N+kIGct
S7YjT/u3H1dxpRz+rCt+fSnmYCf+/LS4hBx3kjYpu5vWnyNkd9O5Pgo9thnWD941
x2p8qpevEIODqpQ3iYwb
=KAaN
-----END PGP SIGNATURE-----

--oDto3OTLsk6uOlQH--
