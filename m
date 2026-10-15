Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A0753F6BB;
	Thu, 15 Oct 2026 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792084368; cv=none; b=Zk8XJexiaYrmMgto0ZRYmlTROqKeD4KC0glcZsKtGnUTp+1V1NcaLpYcGpaKN4rmPaXZhPBTHI9mvaIlrLMtYlNulXWdJ5SiAJok3RHg/+1RtrVq1cmUxaEO7icf30uD8pMqPmMMaZ+hEhzufbqBxym2HMKiupmC8aLXABQcdOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792084368; c=relaxed/simple;
	bh=DnnHiNAiW95Nj48NkwkHpodyvcASUuC5OMZdQ+b9tVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPls3gEdQs2MiYCjkN+M6vGb48Gf98ZEnzjGOK6NmS9rMQXLvLbiiqyKeSdqinbbmnbPk3m5p4AgmORbPPKDfVFnbsmKcAFf3vOvOWsG8X/bsCQQDeF/7FnS5ESNw9d8FsWpPf6v7wU0KPCKPZ5PzRB+eZChkIWvX5t4/ygY9+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcjbF0FI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcjbF0FI"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 29EA31F000C4;
	Thu, 15 Oct 2026 17:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792084355;
	bh=DnnHiNAiW95Nj48NkwkHpodyvcASUuC5OMZdQ+b9tVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RcjbF0FIpvsaiXOIOFm5HjelbDLthaGxlgh1MkRd9B9iydwN7cX3DoP/00A2gsdYu
	 KTwt1IJHLTERBSYcC4jBXRpSt1hJYFJxzGrFs1+3LDd9vDV1sEL93ZCKXq53LOjTxe
	 RBQ/CBuDkDuQMPYG3ber+DjhfvcOx8ELzKfXplGkHSM05TZD4k2udjhmPz3fjYaP/d
	 ywMVIWcBbzxUeRy/KG+ad8JmqrXemuQzzSs+dIKh3Agsc2afNmhDP4I77XwMov5bFF
	 X68/GXa+mMpxMA51CMJGjCViJAgGOvkpa5yRyOSaGvx19c9AyrEuJBlvS3eB8XtyWf
	 aK+AjYOweSmPg==
Date: Thu, 15 Oct 2026 19:12:33 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Alexandre Mergnat <amergnat@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: meson: Convert to waveform API
Message-ID: <atEJA3Tf_-AJL75W@monoceros>
References: <20260717-pwm_meson_convert_to_waveform_api-v1-1-d7dbdae1318d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2xg6pvfu72f3g5cg"
Content-Disposition: inline
In-Reply-To: <20260717-pwm_meson_convert_to_waveform_api-v1-1-d7dbdae1318d@baylibre.com>


--2xg6pvfu72f3g5cg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: meson: Convert to waveform API
MIME-Version: 1.0

Hello Alexandre,

On Fri, Jul 17, 2026 at 09:18:17PM +0200, Alexandre Mergnat wrote:
> The PWM subsystem introduced a new waveform abstraction that
> describes a PWM signal by period length, duty length and duty offset
> instead of period, duty cycle and polarity. The meson driver still
> uses the legacy .apply() and .get_state() callbacks and does not
> implement the waveform callbacks, so consumers cannot use the
> pwm_*_waveform() helper functions with it.
>=20
> Adopt the new API by implementing .round_waveform_tohw(),
> .round_waveform_fromhw(), .read_waveform() and .write_waveform()
> with a private meson_pwm_waveform struct holding the hardware
> representation. The cached channel state fields (rate, hi, lo,
> constant, inverted) are removed; counter values are now computed in
> .round_waveform_tohw() via clk_round_rate() without register writes,
> then committed in .write_waveform().
>=20
> The hardware invert bit places the duty active phase at the end of the
> period on revisions that have it. Input clock rates are kept at or
> below 1 GHz so each counter cycle remains representable in nanoseconds
> by .round_waveform_fromhw(). Requests for which clk_round_rate() cannot
> provide such a rate are rejected. Otherwise, period counts above the
> 16-bit range are clamped, while a zero count is rounded up to one and
> signalled by .round_waveform_tohw() returning 1.
>=20
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

I applied your patch now to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
nexxt

as v7.5-rc1 material (sorry, I was to slow for the upcoming merge
window, I want that patch cook in next for some time).

Thanks for your patience
Uwe

--2xg6pvfu72f3g5cg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrRCX4ACgkQj4D7WH0S
/k6TQQf/efb5VXK9xmAkdKGOSO1kf3kZYIB42Ug6bMGMo6wgaCUCsH7FfLY/qvO/
Ltg49fEHW9Ub2pBPnhpSdqb1nPNrF0EvFCyiYxYVS0g4i4CjxnXVCmvaG/PsGzew
ld4gXMse/qsncxe2lpFVGwDmWgx7eAVE1cOv5wN1wLn3l3MBBvWV0MarrqH2FEdC
41AMdjDsXUgNsn8VezVhU5RgUcCp1NU6KPahjVIc51RGlVXmz6qPZLp6k4IQyJIp
84s2qnpgbTx3xa7qvMGNzwVU/OaoIW3jawCFsocyPMM/n5NDpLP7Kz7edGO0wYFA
kzvSf9bTVcWoZibsVu5ZgX3bejw2AA==
=4Kmq
-----END PGP SIGNATURE-----

--2xg6pvfu72f3g5cg--
