Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8362882CD;
	Fri, 17 Jul 2026 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784296183; cv=none; b=MiUsXaxcHQ58jtMfcmcMDNXsDCEM8xhmZo9m9UpY3uymv9gC7BezaUea98ebFMAA2Y7lUqikkCX7vXEuA4LxmEXyx/kzdfjRnUyyac5xzzzm9xkgA4bH6/LHpVvi2heZs/4VK5/zlZp3iFu5atYWhouRn23T3j4vcxUP0XikPfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784296183; c=relaxed/simple;
	bh=AkwHWZII0F/BybCTZb4VDHcXVkNVOznlkRAjKJa07YE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ce2fCesQThvFs+nozEhnoxm+RjaUEkRi0hSNBGdSWpLmDzLRxRJtUZtbBwxqidvDZ+7gA8bY3KJLywpPIHTuc1xRwqKaneVA8vu1BaR00zMrIYMqW6P6ucsmtwVt3eaauK1XkLWLwQHmwk4JzYFrUKThWj02oNhDYiyWaQYsry4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bS+u6ktS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bS+u6ktS"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 30B701F000E9;
	Fri, 17 Jul 2026 13:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784296182;
	bh=DcKvn5xWvX7Tr6o2MEzx2nnPtuk3QJuyXuR/1daQF0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bS+u6ktSdRzWUanGEc0V5cWmp6CbSnnJYUP7RynZcNWeWsDwEdf3CXtkhPE0D/Ohw
	 w8+Jtl2vezLlDPYM+dWjAvVh2t29XjkWaxu49NoZe1e+GWEcIQy25ItHK2p7Cu2kAE
	 LJIfgHW8IVixF1j33i0yvRkRPqQODccgtnTUTyb9ej0ZuUUOuwM7vih/Bfj/wDfvMu
	 Vu9eJ/4hCInKHzxKuAx50vq0eC0Cp/KWhpe1UOz/Gxvq8jfvY/suYkEGyyvacmCirm
	 mCJBR1L6DzPm1iswUgYINM05WE+5OG81pWgDR9niqWipTeiTq1wneATBBdWBP1wjuQ
	 wmPoS4nIQExAQ==
Date: Fri, 17 Jul 2026 15:49:40 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Naushir Patuck <naush@raspberrypi.com>, Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com, 
	Sean Young <sean@mess.org>, Julian Braha <julianbraha@gmail.com>
Subject: Re: [PATCH v6 2/3] pwm: rp1: Add RP1 PWM controller driver
Message-ID: <alowzfIvKGFkZI1q@monoceros>
References: <cover.1783097764.git.andrea.porta@suse.com>
 <5171610d8bebdd10eea44bff5236502d765b5918.1783097764.git.andrea.porta@suse.com>
 <alibzwe9Mjf3GxJo@monoceros>
 <aln1D3E5QZULZ2U1@apocalypse>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jjjqwa23viq7hrdc"
Content-Disposition: inline
In-Reply-To: <aln1D3E5QZULZ2U1@apocalypse>


--jjjqwa23viq7hrdc
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 2/3] pwm: rp1: Add RP1 PWM controller driver
MIME-Version: 1.0

Hello Andrea,

On Fri, Jul 17, 2026 at 11:25:35AM +0200, Andrea della Porta wrote:
> On 11:18 Thu 16 Jul     , Uwe Kleine-K=F6nig wrote:
> > On Fri, Jul 03, 2026 at 07:05:25PM +0200, Andrea della Porta wrote:
> > > +static int rp1_pwm_round_waveform_tohw(struct pwm_chip *chip,
> > > +				       struct pwm_device *pwm,
> > > +				       const struct pwm_waveform *wf,
> > > +				       void *_wfhw)
> > > +{
> > > +	struct rp1_pwm *rp1 =3D pwmchip_get_drvdata(chip);
> > > +	u64 period_ticks, duty_ticks, offset_ticks;
> > > +	struct rp1_pwm_waveform *wfhw =3D _wfhw;
> > > +	u64 clk_rate =3D rp1->clk_rate;
> > > +	int ret =3D 0;
> > > +
> > > +	if (!wf->period_length_ns) {
> > > +		wfhw->enabled =3D false;
> > > +		wfhw->inverted_polarity =3D (pwm_get_polarity(pwm) =3D=3D PWM_POLA=
RITY_INVERSED);
> >=20
> > pwm_get_polarity(pwm) looks wrong here for several reasons. 1st the
> > polarity is defined in *wf and should not depend on the current state,
> > 2nd for a disabled hardware the polarity doesn't matter anyhow, and 3rd
> > you should not call pwm API functions from the lowlevel driver (which
> > might interfere with subsystem locking).
>=20
> Ok, but in this case what the output of the disabled channel should be?
> If it was inverted before the disable, would it make sense to let the out=
put
> be high? Or are we allowed to hard code a polarity value on disable?

Given that not all hardwares can drive the output of a disabled PWM to a
fixed level, a consumer that relies on a fixed inactive level output
must not disable the PWM. So it doesn't matter what you do on
wf->period_length_ns =3D=3D 0, the only objective is to save power.

> > > +	if (!wfhw->inverted_polarity) {
> > > +		wf->duty_length_ns =3D DIV_ROUND_UP_ULL((u64)wfhw->duty_ticks * NS=
EC_PER_SEC,
> > > +						      (u32)clk_rate);
> > > +	} else {
> > > +		if (wfhw->duty_ticks > (u64)wfhw->period_ticks + 1) {
> > > +			/* 100% duty cycle case */
> > > +			ticks =3D 0;
> > > +		} else {
> > > +			ticks =3D (u64)wfhw->period_ticks + 1 - wfhw->duty_ticks;
> > > +		}
> > > +		wf->duty_length_ns =3D DIV_ROUND_UP_ULL(ticks * NSEC_PER_SEC, clk_=
rate);
> > > +		wf->duty_offset_ns =3D wf->period_length_ns - wf->duty_length_ns;
> >=20
> > The duty_offset_ns calculation is wrong.
> >=20
> > Consider clk_rate =3D 3000000, period_ticks =3D 8, inverted_polarity =
=3D true and
> > duty_ticks =3D 4.
> >=20
> > Then you have:
> >=20
> > 	.period_length_ns =3D 2666.6666666666666 ns ~> 2667
> > 	.duty_length_ns =3D 1333.3333333333333 ns -> 1334
> > 	.duty_offset_ns =3D 1333.3333333333333 ns -> 1334
> >=20
> > but .period_length_ns - .duty_length_ns is 1333.
> >=20
> > To get this right, you have to calculate
> >=20
> > 	wf->duty_offset_ns =3D DIV_ROUND_UP_ULL((u64)(wfhw->period_ticks + 1 -=
 ticks) * NSEC_PER_SEC, clk_rate);
>=20
> So it will end up as 'duty_length_ns + duty_offset_ns >
> period_length_ns', which is timing violation. Is it allowed (or even
> required) in the PWM subsystem?

Not all hardwares support that, but logically it makes sense. The active
phase of the output just crosses the period border. With duty_length_ns
+ duty_offset_ns < period_length_ns (and duty_offset > 0) it's the
inactive phase that crosses the period border, and there is no reason
why the active phase should be more special than the inactive one.

Best regards
Uwe

--jjjqwa23viq7hrdc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpaMvEACgkQj4D7WH0S
/k5Qrwf9EZx/Oe2WWXWSFUVsH8QkJDmP3mG5iNkR/MQ0szDAAbCoKKKjO82HN/L2
5fGLEoeIblzXzA+UjdFGz8Agg08zLTrbEc2/SclkG0O6nUVpJ1OtMjRSqKcAk7bn
Zi1CwmtHROqTTPcULCzHFO+8O0a0YwxQUpKysR1R0fTI0/WC0Yj/R72K2wH5qQAI
AwzU4MUjk6DCl5jljRaRlfGn78mB9NXmkyFDD26ZLraglEhTi8ZZUv3ZkM9OXI3j
i6N+xJ6hQCpp2LyVZPmylZ+rQ8VljWF2UJeZLBUEzHwXbTzfqnpz0aiujMDJGWX0
VDBHJxe2pBQ4yt6dlW3sND+xCf3GdQ==
=oeK6
-----END PGP SIGNATURE-----

--jjjqwa23viq7hrdc--
