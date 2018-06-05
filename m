From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH RESEND] pwm: berlin: Don't use broken prescaler values
Date: Tue, 5 Jun 2018 11:10:02 +0200
Message-ID: <20180605091002.GB20649@ulmo>
References: <da60a97a0c6f754faa1f996334b3568ddb2f5ed0.1528137144.git.tommyhebb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <da60a97a0c6f754faa1f996334b3568ddb2f5ed0.1528137144.git.tommyhebb@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Hebb <tommyhebb@gmail.com>
Cc: linux-arm-kernel@vger.kernel.org, Antoine Tenart <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, jszhang@marvell.com, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04, 2018 at 02:32:41PM -0400, Thomas Hebb wrote:
> Six of the eight prescaler values available for Berlin PWM are not true
> prescalers but rather internal shifts that throw away the high bits of
> TCNT. Currently, we attempt to use those high bits, leading to erratic
> behavior. Restrict the prescaler configurations we select to only the
> two that respect the full range of TCNT.
>=20
> Tested on BG2CD.
>=20
> Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
> ---
>  drivers/pwm/pwm-berlin.c | 45 ++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 20 deletions(-)

Antoine, Jisheng,

can you guys review this patch? I'm personally on the fence about this,
even if we can technically do the shift in software, I don't necessarily
see a reason why we can't "offload" to the hardware.

Thierry

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlsWU2oACgkQ3SOs138+
s6GVRxAAjtDtoWcWJDED+8JBGHIwJ4bkBhydvYPZdxgcyemoA6A5BfjqloDGBOKh
Ly6bVZbtxMy89hhnXlsrG5n2LPWbx/RzzTdmdFVSlmqZY7dbXSzhGs1ADIApG4DF
iGjCdJtz8A60vCWyIY6TvYGmwDwth6R+Htk/j12rDWy91Al7k14NX+e4OfLAF0XC
ARDh5NC/YrFaUbTbTNc36mrT/yUNag5ysmYhTcubuQC92Ogjhkvf1dE1eIjoMb91
YLTFf15S7arZGyU5Yz71Tdolq2yEMuTZKh8vAH+Jk+hM7kQ8bSwF0UxaIvFCx6OL
3cK6bkdpxrNGSU1Y27HXauUUqGFLSb/o1DqTGry0a/FFSHcpjfc/Q3vFdaPvU98N
9MJY8DoHJ8FN4b/vlhf2xb+JtG48dZyb9AwNkEdncrKfg7SU064VrYagSt6DU3vn
/f3eLJLAQutiK7AejJs9Jl0RpU9I3ePoYIHgU28NxEYXA5Ok33dmmUbIB7l+XBnP
mneag4aRTVwe5CHlO5+bCL5UV+I2Ea6FUDyel1sBxGiy0sT9CAy801yjCtM9hywR
yDgWqM6I9lG0kA8XlKgKNEzTGzW0/+8a+0aAXDEmdax4/IywL66sY3gc20KeWVWV
nlA3BfPgEO4JMbUIRCBS7KEbL2iEyAt4mCMiteVH0d0H9/1HnsA=
=N5PO
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
