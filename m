From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 07/17] pwm: sti: Rename channel => device
Date: Mon, 5 Sep 2016 12:33:01 +0200
Message-ID: <20160905103301.GG31424@ulmo.ba.sec>
References: <20160816093508.28307-1-lee.jones@linaro.org>
 <20160816093508.28307-8-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Fnm8lRGFTVS/3GuM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160816093508.28307-8-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, patrice.chotard@st.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--Fnm8lRGFTVS/3GuM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 16, 2016 at 10:34:58AM +0100, Lee Jones wrote:
> This is to bring the terminology used in the STi PWM driver more
> into line with the PWM subsystem.
>=20
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/pwm-sti.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)

Note that it's fine if drivers use different terminology for internals.
Many manuals seem to be using the channel terminology and many drivers
use that. But if you prefer devices that's fine with me.

I've applied this with a minor change, see below.

> diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
[...]
> -	of_property_read_u32(np, "st,pwm-num-chan", &num_chan);
> -	if (num_chan)
> -		cdata->num_chan =3D num_chan;
> +	of_property_read_u32(np, "st,pwm-num-chans", &num_devs);
> +	if (num_devs)
> +		cdata->num_devs =3D num_devs;

I kept the "st,pwm-num-chan" as property name here to avoid breaking
backwards compatiblity. This series changes it back to "st,pwm-num-chan"
sometime later in this series anyway.

Thierry

--Fnm8lRGFTVS/3GuM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzUndAAoJEN0jrNd/PrOh0u4P/jZnPj8LlKyTNVeebgKELZgh
noJfPvmr4nKBxUVQPZ7aGobsAKZrZvgRPnmGJWBuFBAAIfP9bbbOE6kqxfzK0Tme
hXYK/dmwBuuxP89g8Jo4wmhRH4QgCMAfmsFidenId2O1ACke322T7c+jkArb5d+u
Y6AkabG0lzWdkZbx9dvF825MwPcHh2JnH4gn2eV/BNkgBNQ+o5/KnMiBMZMRiF4S
MBpLDNpcINQ4D8VP18INQU00JZ96lNspYGr07juBSTj96WCeSYqqy7IcVMrGu9NK
QaAPqNj7kJ3U4hdsE+SamSw7gBD3CbKJpBY7bzPhj4JbEjyjDEpcsVK/owP2gldR
QmCVM1+5hub7Uq17RaHgYQI7ldHJufAD7Xt9yeQCecVv4U9HjH42vVKKTWwNjF/B
9wJ47EEv79ApETveVaykPlBsBt+fcyTd+ZkbnYUVtnoSUQLb4Atjivb9k/QuYCFS
0XsWnrnsrrJKA3qqlhvYFjBrsJMYyyQqhkCdzBSzxqIGe+Jqr4ZXKi5hAVHnCO4y
cCa08r2LWYAc+mjCTBZ2f/t+oJAiD48eoKmGvO3/LIBooSbbmkqWgFJVB2sK8RJs
X2FPI9n8Vt0cL9DrALfO/SD324TD/+Tyhu+4U5JKGmxidp0EqyxSjZ/4r5XsGm/G
M2rm4TM7FSa4KvIj2f0o
=GCcu
-----END PGP SIGNATURE-----

--Fnm8lRGFTVS/3GuM--
