Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792657785;
	b=SQph5hbFRuM9tD5nlPaYakFDNCReAhTSFeE9aIrDgodQ+JYUZuux/JCOFDBc+HkRGF9d
	 BqMaQDSY7XytuU8J8MPXUA45T8s5ay85uExxpgR5GKnQAH1sMbpn9H7wl6HRnBhXXFMWL
	 dRt5tIy6yozFklOrnfUKI4JuBH7yRvC3qnpikK95Vz9Z3kYUbzSJqv/hd/EJZe4C7Namw
	 DLonvK/4WNcLhrkIwO3wG1BDVTK3ucgeqfNX30D0qV281VKg/tLTZpRJs/gl0VBsJOPYZ
	 pEUSAH+0B35GMHgA7oaX9fG6mKe3ndLji+BpZBxXIoWZB3dxbEmE5NVCYmsetzNretg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657785;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lYu0vxaasiD556MfAu5R9CUvlfrPZLDJu4XoI/LGb7U=;
	b=0JirlxpU/osSD5iQx/V4icjpLcnUsuo6Ohlsm4P9KDbEZVJcde1lFvyRDD8b0qITwufj
	 PZRPTreH/w6V7aUUGFGkZ8o+F3vSAta8BhcAmQxjxEGz0bfa+ZHPv7zOjy99gptkJ5rpM
	 835T44AL0X2Ql1fG44Lrkej1tzCg7pv3/6Cli+mjsySd3alS2ReBKSCF1ybbirP1pe/I3
	 Pa8UhR07y+Ku8jC/MJLO2zpijryA/m38t7AY7kTJxQQEbVptBhP+PmdnPumCMK5UW6frt
	 PyTXu6jSLiLFLCYSEKJSNIkaw/QC7PMW2qSQ9H2Yxha9kzDZ37AyCh8xzo8skX7eWfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B8x6yJxU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 9D7FF606A319;
	Thu, 22 Oct 2026 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B8x6yJxU
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9D2971F000C2;
	Thu, 22 Oct 2026 08:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792657785;
	bh=lYu0vxaasiD556MfAu5R9CUvlfrPZLDJu4XoI/LGb7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B8x6yJxUgG3bqv1qwvA+Elk6beiej5IQqxuu6cLea8Kwj1mr/5wfv06Ah6Sbe+oyd
	 zXFyfUUW0kwJU7qLEdx1FthXM6deLKsMYLoDabW5Ap+g3m/pwpnLmTxtiERWaM8K6l
	 agRqpWIWrDooC08lbEOfoq7JO6nZXfhF76hFzXn1Jzg/xVOr4Q36D6hRIy/BBCAFjG
	 FvFCZP8yMs3FRa3MyAhjmbt1k0AXE84bEimzMhpRPSZ8XvRu38Wr3jE1qjP1hsd6Pk
	 NNcqLlm2nWMpFqUu03bnfx2thjzLnP1xYsaCQ5NG5Z1pAhffGyq/RInr155CUPMLqJ
	 W1laGKxSZbBQA==
Date: Thu, 22 Oct 2026 10:29:42 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: atmel: Fix prescaler for periods of 2^32 clock
 cycles or more
Message-ID: <atnHHaOwTkI78_tc@monoceros>
References: <20261016161221.16553-1-kmehltretter@gmail.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vqpjgoh36dtmnefm"
Content-Disposition: inline
In-Reply-To: <20261016161221.16553-1-kmehltretter@gmail.com>


--vqpjgoh36dtmnefm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: atmel: Fix prescaler for periods of 2^32 clock
 cycles or more
MIME-Version: 1.0

Hello Karl,

On Fri, Oct 16, 2026 at 06:12:21PM +0200, Karl Mehltretter wrote:
> atmel_pwm_calculate_cprd_and_pres() keeps the period in clock cycles in
> an unsigned long long but derives the prescaler from fls(cycles). fls()
> takes an unsigned int, so the upper 32 bits are ignored.
>=20
> On controllers that the driver configures with a 32-bit period register
> (SAM9X60, SAM9X7) a request of 2^32 clock cycles or more therefore gets
> prescaler 0 and a truncated CPRD. The request succeeds and sysfs
> reports the requested period.
>=20
> On a SAM9X75 (PWM clock 266.67 MHz) this affects periods from about
> 16.1 s on. Requesting 20 s with a 10 s duty cycle
>=20
>   # echo 2 > /sys/class/pwm/pwmchip0/export
>   # echo 20000000000 > /sys/class/pwm/pwmchip0/pwm2/period
>   # echo 10000000000 > /sys/class/pwm/pwmchip0/pwm2/duty_cycle
>   # echo 1 > /sys/class/pwm/pwmchip0/pwm2/enable
>=20
> programs CPRE=3D0, CPRD=3D0x3de4355c and CDTY=3D0x9ef21aae. The channel r=
uns
> with a period of 3.9 s, measured from the period end flag in PWM_ISR.
> With this duty cycle CDTY is above CPRD, so the output stays inactive
> and an LED on it stays dark.
>=20
> Use fls64() so that the prescaler is derived from the full 64-bit
> value. The driver then programs CPRE=3D1, CPRD=3D0x9ef21aae and
> CDTY=3D0x4f790d57. The measured period is 20.0 s and the LED is on for
> 10 s of every 20 s.
>=20
> Controllers configured with a 16-bit period register are unaffected
> for all representable periods. Some oversized requests of 2^32 clock
> cycles or more now fail with -EINVAL instead of being programmed with
> truncated values. Clamping such requests to the maximum possible
> configuration is a pre-existing issue best addressed when converting
> the driver to the waveform API.
>=20
> The truncation was not reachable when it was introduced. The period
> was an unsigned int in nanoseconds then, which limits it to about
> 4.29 s. Commit a9d887dc1c60 ("pwm: Convert period and duty cycle to
> u64") made longer periods possible.
>=20
> Fixes: a9d887dc1c60 ("pwm: Convert period and duty cycle to u64")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> Changes in v2:
> - Keep only the Fixes tag for the commit that exposed the bug (Uwe).
> - Clarify the pre-existing handling of oversized requests (Uwe).
> - Add Microchip's confirmation of the data sheet error.
> - Rebase onto v7.3-rc7.
> - No code changes from v1.
>=20
> v1: https://lore.kernel.org/r/20261003083036.21584-1-kmehltretter@gmail.c=
om/
>=20
> Notes:
>     Found while testing a Rust port of this driver on a SAM9X75 Curiosity
>     board. The port uses a 64-bit fls. Its registers differed from the C
>     driver for long periods.
>=20
>     Tested on that board with a v7.3-rc5-based kernel built with clang
>     22.1.8. PC20 was routed to PWM2 (peripheral function C) in a local
>     device tree. The blue LED is on that pin.
>=20
>     - Without the patch there are 23 period ends in 90 s, 3.88 s to 3.93 s
>       apart. The LED stays dark.
>     - With the patch the period ends are 19.98 s to 20.01 s apart. The LED
>       is on for 10 s of every 20 s.
>=20
>     The SAM9X60 and SAM9X7 data sheets describe the channel counter as
>     16 bit. That does not match the hardware.
>=20
>     - The 20.0 s result needs CPRD=3D0x9ef21aae. All 32 bits are used.
>     - Commit 0285827d546d ("pwm: atmel: Add support for controllers with
>       32 bit counters") says 32 bit.
>     - Microchip's Harmony PWM example for this board programs
>       CPRD=3D133333333.
>=20
>     Microchip support has confirmed that the data sheets are incorrect and
>     will be corrected.
>=20
>  drivers/pwm/pwm-atmel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index 86918523d821..574020d90a3b 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -195,7 +195,7 @@ static int atmel_pwm_calculate_cprd_and_pres(struct p=
wm_chip *chip,
>  	 * So for each bit the number of clock cycles is wider divide the input
>  	 * clock frequency by two using pres and shift cprd accordingly.
>  	 */
> -	shift =3D fls(cycles) - atmel_pwm->data->cfg.period_bits;
> +	shift =3D fls64(cycles) - atmel_pwm->data->cfg.period_bits;
> =20
>  	if (shift > PWM_MAX_PRES) {
>  		dev_err(pwmchip_parent(chip), "pres exceeds the maximum value\n");

just above this code snippet there is:

	unsigned long long cycles =3D state->period;

        /* Calculate the period cycles and prescale value */
        cycles *=3D clkrate;
        do_div(cycles, NSEC_PER_SEC);

there is another overflow happening here if state->period * clkrate
doesn't fit into an u64. A complete fix converts that to:

	cycles =3D mul_u64_u64_div_u64(state->period, clkrate, NSEC_PER_SEC);

which prevents an overflow if clkrate =E2=89=A4 NSEC_PER_SEC.
The latter can be asserted by checking that at probe time after calling
clk_rate_exclusive_get().

The options now are I apply your patch anyhow and the above can be
addressed later, or you rework your patch to a complete fix. What is
your preference?

Best regards
Uwe

--vqpjgoh36dtmnefm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrZyXQACgkQj4D7WH0S
/k4Z5gf+P23ZuNjCGy3QqwfAby1YXzFwIUQKlB3VaXDXBzPdSBx6mF3pApLnsOJP
XBf4v0U/6l4Q8Nu20efYTpdzRFRrfnZAXFsViQFiXUuYYrfGZ6HYll6BSR/BEwZR
kDLWldJXiXTfNVJ/pV0SWcHSJjvQQmko5P7djFCcc1HRWBJDHBelwWpYnwP4Pfvk
+yv/TM6OpPlt/XDa+nNzH/SZcckTKLZ5LBURgYVRG21WV9F5pB+yhfnEkpyqDPxy
XFmCEPF3iQ9E2T5QIeVDb+8FIvUwMKYt5iPxe7kudsT4bqni9l7eMWM/J4OIKWbs
WiLS/g7Ts3dqzSiOOexq60i4CRfAHw==
=3fwJ
-----END PGP SIGNATURE-----

--vqpjgoh36dtmnefm--
