Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118743;
	b=sN8Duze6fWAE5LW9QCsoyO/TbH8lDY1wavCKw1/S1B0mOwtcM+XQF1vhQa/jtpGeiTJy
	 oSRUmNFXp4EjyHLe5+VPNMAF6dK7AXs7OmkUZHFEsJVhVYfza136Ek4rNiFMTJtWOuRUX
	 kRSsPf8Mvtk2v/QerZ9aitQDe5UwdL4fVDz2c4j+BO1Bkmj4pfCQhIRLQlqVY5J3W3zpd
	 5aryKxMbyOiCZUednbM0FaQWDgdOWhKa2m+58clpDAyZqkdgW4SehPlWGts5TCUIWQpEn
	 fkXjo5n8Vj3MYdOZyjXckaRi8gNE6i6zUUzAStu09hAFluj2E6xe+znA+irOIngIBbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118743;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kvHpdbzr181XbRpEgtV1R2oktcYB29tcS5XHBNv0lQ8=;
	b=KoUOxH97hXzKH3k8C7fdKuyRm1h9OQTOxLTUJGF0Yt1Gll9NSlkeHgBvWDqvyPcHIYz1
	 m6pJg6gFsn7SNl23L/S9k4iuYycLbSTLMeuq26pH1kjXqBD5cQH86MrAZ84IUmSQ9mXfq
	 dBrqnl8LGG0wKYA9jNEx5JolBcXAnwYp217An3zciqu1r7p/eptaJkmnCzx9iHz+d9k00
	 QqjXq4/OES2mt2G/GkjI/vtU8+DW/+513Ep+Rki9ZPhqxcyKWc4nXjciX4A9rCkmvTPU2
	 JbFFRT6t/9fz6KW7N3colL/+VU/iA9usU82igHfM8Oa87tXdUNVxn3DXFvYM59fghaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="L/9wjUU8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 837CE606A31A;
	Tue, 27 Oct 2026 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L/9wjUU8
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C18B21F01825;
	Tue, 27 Oct 2026 16:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793118743;
	bh=kvHpdbzr181XbRpEgtV1R2oktcYB29tcS5XHBNv0lQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L/9wjUU8d3mrJwpelfh/WNYBeL7ClsTN5Z/FIX9bgBT1bfIhFUN3uaTN0CEBEiPwu
	 QCRNL0gSXhd8ncuR9jPx5QFJNPcHNPAo2d3R8t7++MKn7Z48961Ce4h7KI5UDuxYl3
	 07CrG3a8hujQ5s9l2pItC+VbFzItUn9n97KARlIuArpKZleglBPKNFp5J5a03ALXbf
	 sg0amAQcUKZC/SyPFhVmBuCHVm0vaQpfcM88JU8TqsFkaVHbuf+VmMkShkS6NfPvvY
	 oESgVQBE981tciY4ny4xpyD9tT8Ki/cRNVBY6Y4XeWq89PigUFKMseSmjmbEXl+SvT
	 n34tFbBgT8Gow==
Date: Tue, 27 Oct 2026 17:32:20 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Gregor Herburger <gregor.herburger@linutronix.de>, 
	Stanimir Varbanov <svarbanov@suse.de>, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Gary Guo <gary@garyguo.net>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH RFC 3/4] hwmon: Add driver for Raspberry Pi RP1 fan
 tachometer
Message-ID: <auDRHk8eaYife2zH@monoceros>
References: <cover.1792748690.git.andrea.porta@suse.com>
 <0d2249a66732bfce38a2260bee08cd1ba4097e51.1792748690.git.andrea.porta@suse.com>
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
	protocol="application/pgp-signature"; boundary="wczsomz7ltpapr6j"
Content-Disposition: inline
In-Reply-To: <0d2249a66732bfce38a2260bee08cd1ba4097e51.1792748690.git.andrea.porta@suse.com>


--wczsomz7ltpapr6j
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 3/4] hwmon: Add driver for Raspberry Pi RP1 fan
 tachometer
MIME-Version: 1.0

Hello,

On Fri, Oct 23, 2026 at 12:15:56PM +0200, Andrea della Porta wrote:
> Add a hardware monitoring driver to support the fan tachometer on the
> Raspberry Pi RP1 southbridge, found on the Raspberry Pi 5.
>=20
> The RP1 PWM controller block contains specific MMIO registers that hold
> the current fan speed in RPM. These registers are periodically updated by
> the RP1 internal firmware based on the tachometer pulses.
>=20
> Since the Linux PWM subsystem does not currently offer a framework for
> exposing integrated hardware tachometer readings, this driver is
> implemented as a standalone hwmon device. It parses the
> 'raspberrypi,pwm-tachometer' DT property to find the supplier PWM device,
> establishes a device link to ensure proper lifecycle management, and uses
> RP1-specific PWM functions to retrieve the RPM values.

I wonder if the tachometer readout should be a counter driver? That
would allow this driver to not be specific to the RP1 hardware.

Best regards
Uwe

--wczsomz7ltpapr6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrg0hIACgkQj4D7WH0S
/k4tWgf/aBdc0sompTuoqGx4glA5Q7tPemfla+YycjTGdxt9ZwZgvezbioJbkniK
oTXSogrYNoBat5wjHuBQluVrr7TxDUAYcPemNasPLXXw8YsFbuQ6VkxeNJxnoFLI
efQX1S4xPFPOZogKw/pXdFopxrV3J+SGNyNzIKp5CLBHu+MipL78wMBX4W7j2IL8
Fda5MbTg+pbz8BNA5NNmr1xbwLLt+hSSGommcetIOv16gzgyrKd0vZeEtFTsFQSS
NQcPN9XQYOp9unKPk1L1FKip3M+uew5pmOyMYgGBhSoSVetzagYc7FF0YQwK6+Ai
TrVi1WtPSfetPZ6w6o39mL5AThZ+Pg==
=1ZwV
-----END PGP SIGNATURE-----

--wczsomz7ltpapr6j--
