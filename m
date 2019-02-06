From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Wed, 6 Feb 2019 13:44:42 +0100
Message-ID: <20190206124442.GG21676@ulmo>
References: <1548762199-7065-1-git-send-email-yash.shah@sifive.com>
 <1548762199-7065-3-git-send-email-yash.shah@sifive.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eMnpOGXCMazMAbfp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1548762199-7065-3-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yash Shah <yash.shah@sifive.com>
Cc: palmer@sifive.com, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com, paul.walmsley@sifive.com
List-Id: linux-pwm@vger.kernel.org


--eMnpOGXCMazMAbfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 29, 2019 at 05:13:19PM +0530, Yash Shah wrote:
[...]
> diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
[...]
> +static void pwm_sifive_update_clock(struct pwm_sifive_ddata *pwm,
> +				    unsigned long rate)
> +{
> +	/* (1 << (16+scale)) * 10^9/rate = real_period */
> +	unsigned long scale_pow =
> +			(pwm->approx_period * (u64)rate) / NSEC_PER_SEC;

I think you need another div64_ul() for this one to fix the linker error
that the 0-day builder was pointing out.

Thierry

--eMnpOGXCMazMAbfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxa1roACgkQ3SOs138+
s6Ho7w/44E8oDkjBRAR5L9470vsccMPAjzx4g2A7RH4LgdftIUAZcBK6SO0hlwHQ
5Obv6Zz5m0W0RF8MkaVyIdtgLUfnEMSTSz3JMT3aDCZ6SvJttXthHoGuzNgEM1U2
zJJS/zw0Rkw1uDfIwlYU/A2dxa5pye5w/9XymmQfA2+1dUvEMtvDQLwg8sCxV7Kt
xxmZ/xkogqT15Dlez28duZ5qW9IHRBixx6ihoCEUgFF91tC/ZUAcnq3ouBuesAsf
5uuwgW86CUXYo7fqjwHObMVjqbAXTQOaXcr00pYsBRXD+KRfgHtYp6mGDeabXOa2
70wvWfzFGVama3PK6eUH/9pZ0Bl1HBZbn5L9PFHSxexsakZnLDKzeiuwdYLbBC6T
wTN+tekJhBZf/o286YsObORPMkjpQ8AYAtAnlMHsOLdiLJROPU+AMw9qnjQgOk54
4CfFuntAA9zJg+DaObAHuDlrU83pa71wSWytGSdgDjpvcmCtt7D30BuIvnIjp9D/
apsnqQRQY6jKtd5G76AQaGuhShJIoPFRJI4zRTjZ1UlGwA0isbIvqiU6R4iH4/v4
Y03Pcr1JBYn/adGE8v3PH+z0vuF3jrrVZ4sUdKWtErT99q/PdxK6pqYnoami1IFt
gMQmQrsiH8XfRde6dE1kf0ebvKwTe9IrbtR2HTEXhcnd4ieBGg==
=YYF2
-----END PGP SIGNATURE-----

--eMnpOGXCMazMAbfp--
